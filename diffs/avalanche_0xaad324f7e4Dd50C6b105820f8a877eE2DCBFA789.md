```diff
diff --git a/./src/etherscan/avalanche_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol b/./src/Flattened.sol
index 8f2b1a5..2842668 100644
--- a/./src/etherscan/avalanche_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol
+++ b/./src/Flattened.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 /**
  * @title VersionedInitializable
@@ -603,6 +603,21 @@ interface IRewardsDistributor {
       uint256
     );
 
+  /**
+   * @dev Calculates the next value of an specific distribution index, with validations.
+   * @param asset The incentivized asset
+   * @param reward The reward token of the incentivized asset
+   * @return The old index of the asset distribution
+   * @return The new index of the asset distribution
+   **/
+  function getAssetIndex(address asset, address reward)
+    external
+    view
+    returns(
+      uint256,
+      uint256
+    );
+
   /**
    * @dev Returns the list of available reward token addresses of an incentivized asset
    * @param asset The incentivized asset
@@ -748,22 +763,33 @@ library RewardsDataTypes {
   }
 
   struct UserData {
-    uint104 index; // matches reward index
+    // Liquidity index of the reward distribution for the user
+    uint104 index;
+    // Amount of accrued rewards for the user since last user index update
     uint128 accrued;
   }
 
   struct RewardData {
+    // Liquidity index of the reward distribution
     uint104 index;
+    // Amount of reward tokens distributed per second
     uint88 emissionPerSecond;
+    // Timestamp of the last reward index update
     uint32 lastUpdateTimestamp;
+    // The end of the distribution of rewards (in seconds)
     uint32 distributionEnd;
+    // Map of user addresses and their rewards data (userAddress => userData)
     mapping(address => UserData) usersData;
   }
 
   struct AssetData {
+    // Map of reward token addresses and their data (rewardTokenAddress => rewardData)
     mapping(address => RewardData) rewards;
+    // List of reward token addresses for the asset
     mapping(uint128 => address) availableRewards;
+    // Count of reward tokens for the asset
     uint128 availableRewardsCount;
+    // Number of decimals of the asset
     uint8 decimals;
   }
 }
@@ -775,19 +801,19 @@ library RewardsDataTypes {
  **/
 abstract contract RewardsDistributor is IRewardsDistributor {
   using SafeCast for uint256;
-  // manager of incentives
+  // Manager of incentives
   address internal _emissionManager;
 
-  // asset => AssetData
+  // Map of rewarded asset addresses and their data (assetAddress => assetData)
   mapping(address => RewardsDataTypes.AssetData) internal _assets;
 
-  // reward => enabled
+  // Map of reward assets (rewardAddress => enabled)
   mapping(address => bool) internal _isRewardEnabled;
 
-  // global rewards list
+  // Rewards list
   address[] internal _rewardsList;
 
-  //global assets list
+  // Assets list
   address[] internal _assetsList;
 
   modifier onlyEmissionManager() {
@@ -795,10 +821,6 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     _;
   }
 
-  constructor(address emissionManager) {
-    _setEmissionManager(emissionManager);
-  }
-
   /// @inheritdoc IRewardsDistributor
   function getRewardsData(address asset, address reward)
     public
@@ -819,6 +841,22 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     );
   }
 
+  /// @inheritdoc IRewardsDistributor
+  function getAssetIndex(address asset, address reward)
+    external
+    view
+    override
+    returns (uint256, uint256)
+  {
+    RewardsDataTypes.RewardData storage rewardData = _assets[asset].rewards[reward];
+    return
+      _getAssetIndex(
+        rewardData,
+        IScaledBalanceToken(asset).scaledTotalSupply(),
+        10**_assets[asset].decimals
+      );
+  }
+
   /// @inheritdoc IRewardsDistributor
   function getDistributionEnd(address asset, address reward)
     external
@@ -948,7 +986,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
       (uint256 newIndex, ) = _updateRewardData(
         rewardConfig,
-        IERC20Detailed(asset).totalSupply(),
+        IScaledBalanceToken(asset).scaledTotalSupply(),
         10**decimals
       );
 
@@ -1167,11 +1205,15 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     // Add unrealized rewards
     for (uint256 i = 0; i < userAssetBalances.length; i++) {
       if (userAssetBalances[i].userBalance == 0) {
-        continue;
+        unclaimedRewards += _assets[userAssetBalances[i].asset]
+          .rewards[reward]
+          .usersData[user]
+          .accrued;
+      } else {
+        unclaimedRewards +=
+          _getPendingRewards(user, reward, userAssetBalances[i]) +
+          _assets[userAssetBalances[i].asset].rewards[reward].usersData[user].accrued;
       }
-      unclaimedRewards +=
-        _getPendingRewards(user, reward, userAssetBalances[i]) +
-        _assets[userAssetBalances[i].asset].rewards[reward].usersData[user].accrued;
     }
 
     return unclaimedRewards;
@@ -1227,6 +1269,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
   /**
    * @dev Calculates the next value of an specific distribution index, with validations
+   * @param rewardData Storage pointer to the distribution reward config
    * @param totalSupply of the asset being rewarded
    * @param assetUnit One unit of asset (10**decimals)
    * @return The new index.
@@ -1403,10 +1446,10 @@ interface IRewardsController is IRewardsDistributor {
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;
 
   /**
-   * @dev Called by the corresponding asset on any update that affects the rewards distribution
-   * @param user The address of the user
-   * @param userBalance The user balance of the asset
-   * @param totalSupply The total supply of the asset
+   * @dev Called by the corresponding asset on transfer hook in order to update the rewards distribution.
+   * @param user The address of the user whose asset balance has changed 
+   * @param userBalance The previous user balance prior to balance change 
+   * @param totalSupply The total supply of the asset prior to user balance change
    **/
   function handleAction(
     address user,
@@ -1505,7 +1548,7 @@ interface IRewardsController is IRewardsDistributor {
 contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 1;
+  uint256 public constant REVISION = 2;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
@@ -1528,15 +1571,14 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
     _;
   }
 
-  constructor(address emissionManager) RewardsDistributor(emissionManager) {}
-
   /**
    * @dev Initialize for RewardsController
+   * @dev Modified version which makes this a noop as otherwise
+   * https://github.com/aave/aave-v3-core/blob/master/contracts/protocol/configuration/PoolAddressesProvider.sol#L171
+   * would set the emissionManager to the pooladdressesprovider on the upgrade
    * @param emissionManager address of the EmissionManager
    **/
-  function initialize(address emissionManager) external initializer {
-    _setEmissionManager(emissionManager);
-  }
+  function initialize(address emissionManager) external initializer {}
 
   /// @inheritdoc IRewardsController
   function getClaimer(address user) external view override returns (address) {
```
