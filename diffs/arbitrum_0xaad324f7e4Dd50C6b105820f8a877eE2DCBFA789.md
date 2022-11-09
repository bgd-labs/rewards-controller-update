```diff
diff --git a/./src/etherscan/arbitrum_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol b/./src/Flattened.sol
index 8f2b1a5..9553e7e 100644
--- a/./src/etherscan/arbitrum_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/Flattened.sol
+++ b/./src/Flattened.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 /**
  * @title VersionedInitializable
@@ -603,6 +603,15 @@ interface IRewardsDistributor {
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
@@ -819,6 +828,22 @@ abstract contract RewardsDistributor is IRewardsDistributor {
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
@@ -948,7 +973,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
       (uint256 newIndex, ) = _updateRewardData(
         rewardConfig,
-        IERC20Detailed(asset).totalSupply(),
+        IScaledBalanceToken(asset).scaledTotalSupply(),
         10**decimals
       );
 
@@ -1167,11 +1192,15 @@ abstract contract RewardsDistributor is IRewardsDistributor {
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
@@ -1505,7 +1534,7 @@ interface IRewardsController is IRewardsDistributor {
 contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 1;
+  uint256 public constant REVISION = 2;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
@@ -1532,11 +1561,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
 
   /**
    * @dev Initialize for RewardsController
+   * @dev Modified version which makes this a noop as otherwise it would be overwritten on the upgrade.
    * @param emissionManager address of the EmissionManager
    **/
-  function initialize(address emissionManager) external initializer {
-    _setEmissionManager(emissionManager);
-  }
+  function initialize(address emissionManager) external initializer {}
 
   /// @inheritdoc IRewardsController
   function getClaimer(address user) external view override returns (address) {
```
