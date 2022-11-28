```diff
diff --git a/./src/etherscan/avalanche_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol b/./src/Flattened.sol
index 8f2b1a5..838877f 100644
--- a/./src/etherscan/avalanche_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol
+++ b/./src/Flattened.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 /**
  * @title VersionedInitializable
@@ -529,16 +529,6 @@ interface IRewardsDistributor {
     uint256 rewardsAccrued
   );
 
-  /**
-   * @dev Emitted when the emission manager address is updated.
-   * @param oldEmissionManager The address of the old emission manager
-   * @param newEmissionManager The address of the new emission manager
-   */
-  event EmissionManagerUpdated(
-    address indexed oldEmissionManager,
-    address indexed newEmissionManager
-  );
-
   /**
    * @dev Sets the end date for the distribution
    * @param asset The asset to incentivize
@@ -603,6 +593,15 @@ interface IRewardsDistributor {
       uint256
     );
 
+  /**
+   * @dev Calculates the next value of an specific distribution index, with validations.
+   * @param asset The incentivized asset
+   * @param reward The reward token of the incentivized asset
+   * @return The old index of the asset distribution
+   * @return The new index of the asset distribution
+   **/
+  function getAssetIndex(address asset, address reward) external view returns (uint256, uint256);
+
   /**
    * @dev Returns the list of available reward token addresses of an incentivized asset
    * @param asset The incentivized asset
@@ -660,13 +659,14 @@ interface IRewardsDistributor {
    * @dev Returns the address of the emission manager
    * @return The address of the EmissionManager
    */
+  function EMISSION_MANAGER() external view returns (address);
+
+  /**
+   * @dev Returns the address of the emission manager.
+   * Deprecated: This getter is maintained for compatibility purposes. Use the `EMISSION_MANAGER()` function instead.
+   * @return The address of the EmissionManager
+   */
   function getEmissionManager() external view returns (address);
-
-  /**
-   * @dev Updates the address of the emission manager
-   * @param emissionManager The address of the new EmissionManager
-   */
-  function setEmissionManager(address emissionManager) external;
 }
 
 interface ITransferStrategyBase {
@@ -748,22 +748,33 @@ library RewardsDataTypes {
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
@@ -775,28 +786,31 @@ library RewardsDataTypes {
  **/
 abstract contract RewardsDistributor is IRewardsDistributor {
   using SafeCast for uint256;
-  // manager of incentives
+
+  // Manager of incentives
+  address public immutable EMISSION_MANAGER;
+  // Deprecated: This storage slot is kept for backwards compatibility purposes.
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
-    require(msg.sender == _emissionManager, 'ONLY_EMISSION_MANAGER');
+    require(msg.sender == EMISSION_MANAGER, 'ONLY_EMISSION_MANAGER');
     _;
   }
 
   constructor(address emissionManager) {
-    _setEmissionManager(emissionManager);
+    EMISSION_MANAGER = emissionManager;
   }
 
   /// @inheritdoc IRewardsDistributor
@@ -819,6 +833,22 @@ abstract contract RewardsDistributor is IRewardsDistributor {
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
@@ -948,7 +978,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
       (uint256 newIndex, ) = _updateRewardData(
         rewardConfig,
-        IERC20Detailed(asset).totalSupply(),
+        IScaledBalanceToken(asset).scaledTotalSupply(),
         10**decimals
       );
 
@@ -1167,11 +1197,15 @@ abstract contract RewardsDistributor is IRewardsDistributor {
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
@@ -1227,6 +1261,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
   /**
    * @dev Calculates the next value of an specific distribution index, with validations
+   * @param rewardData Storage pointer to the distribution reward config
    * @param totalSupply of the asset being rewarded
    * @param assetUnit One unit of asset (10**decimals)
    * @return The new index.
@@ -1280,22 +1315,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
   /// @inheritdoc IRewardsDistributor
   function getEmissionManager() external view returns (address) {
-    return _emissionManager;
-  }
-
-  /// @inheritdoc IRewardsDistributor
-  function setEmissionManager(address emissionManager) external onlyEmissionManager {
-    _setEmissionManager(emissionManager);
-  }
-
-  /**
-   * @dev Updates the address of the emission manager
-   * @param emissionManager The address of the new EmissionManager
-   */
-  function _setEmissionManager(address emissionManager) internal {
-    address previousEmissionManager = _emissionManager;
-    _emissionManager = emissionManager;
-    emit EmissionManagerUpdated(previousEmissionManager, emissionManager);
+    return EMISSION_MANAGER;
   }
 }
 
@@ -1403,10 +1423,10 @@ interface IRewardsController is IRewardsDistributor {
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
@@ -1505,7 +1525,7 @@ interface IRewardsController is IRewardsDistributor {
 contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 1;
+  uint256 public constant REVISION = 2;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
@@ -1532,11 +1552,9 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
 
   /**
    * @dev Initialize for RewardsController
-   * @param emissionManager address of the EmissionManager
+   * @dev It expects an address as argument since its initialized via PoolAddressesProvider._updateImpl()
    **/
-  function initialize(address emissionManager) external initializer {
-    _setEmissionManager(emissionManager);
-  }
+  function initialize(address) external initializer {}
 
   /// @inheritdoc IRewardsController
   function getClaimer(address user) external view override returns (address) {
```
