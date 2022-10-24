```diff
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol b/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol
deleted file mode 100644
index 7dc5593..0000000
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
-
-/**
- * @dev Interface of the ERC20 standard as defined in the EIP.
- */
-interface IERC20 {
-  /**
-   * @dev Returns the amount of tokens in existence.
-   */
-  function totalSupply() external view returns (uint256);
-
-  /**
-   * @dev Returns the amount of tokens owned by `account`.
-   */
-  function balanceOf(address account) external view returns (uint256);
-
-  /**
-   * @dev Moves `amount` tokens from the caller's account to `recipient`.
-   *
-   * Returns a boolean value indicating whether the operation succeeded.
-   *
-   * Emits a {Transfer} event.
-   */
-  function transfer(address recipient, uint256 amount) external returns (bool);
-
-  /**
-   * @dev Returns the remaining number of tokens that `spender` will be
-   * allowed to spend on behalf of `owner` through {transferFrom}. This is
-   * zero by default.
-   *
-   * This value changes when {approve} or {transferFrom} are called.
-   */
-  function allowance(address owner, address spender) external view returns (uint256);
-
-  /**
-   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
-   *
-   * Returns a boolean value indicating whether the operation succeeded.
-   *
-   * IMPORTANT: Beware that changing an allowance with this method brings the risk
-   * that someone may use both the old and the new allowance by unfortunate
-   * transaction ordering. One possible solution to mitigate this race
-   * condition is to first reduce the spender's allowance to 0 and set the
-   * desired value afterwards:
-   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
-   *
-   * Emits an {Approval} event.
-   */
-  function approve(address spender, uint256 amount) external returns (bool);
-
-  /**
-   * @dev Moves `amount` tokens from `sender` to `recipient` using the
-   * allowance mechanism. `amount` is then deducted from the caller's
-   * allowance.
-   *
-   * Returns a boolean value indicating whether the operation succeeded.
-   *
-   * Emits a {Transfer} event.
-   */
-  function transferFrom(
-    address sender,
-    address recipient,
-    uint256 amount
-  ) external returns (bool);
-
-  /**
-   * @dev Emitted when `value` tokens are moved from one account (`from`) to
-   * another (`to`).
-   *
-   * Note that `value` may be zero.
-   */
-  event Transfer(address indexed from, address indexed to, uint256 value);
-
-  /**
-   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
-   * a call to {approve}. `value` is the new allowance.
-   */
-  event Approval(address indexed owner, address indexed spender, uint256 value);
-}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol b/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
deleted file mode 100644
index 0269305..0000000
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
-
-import {IERC20} from './IERC20.sol';
-
-interface IERC20Detailed is IERC20 {
-  function name() external view returns (string memory);
-
-  function symbol() external view returns (string memory);
-
-  function decimals() external view returns (uint8);
-}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol b/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
deleted file mode 100644
index 6d70809..0000000
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+++ /dev/null
@@ -1,255 +0,0 @@
-// SPDX-License-Identifier: MIT
-// OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
-pragma solidity 0.8.10;
-
-/**
- * @dev Wrappers over Solidity's uintXX/intXX casting operators with added overflow
- * checks.
- *
- * Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
- * easily result in undesired exploitation or bugs, since developers usually
- * assume that overflows raise errors. `SafeCast` restores this intuition by
- * reverting the transaction when such an operation overflows.
- *
- * Using this library instead of the unchecked operations eliminates an entire
- * class of bugs, so it's recommended to use it always.
- *
- * Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
- * all math on `uint256` and `int256` and then downcasting.
- */
-library SafeCast {
-  /**
-   * @dev Returns the downcasted uint224 from uint256, reverting on
-   * overflow (when the input is greater than largest uint224).
-   *
-   * Counterpart to Solidity's `uint224` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 224 bits
-   */
-  function toUint224(uint256 value) internal pure returns (uint224) {
-    require(value <= type(uint224).max, "SafeCast: value doesn't fit in 224 bits");
-    return uint224(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint128 from uint256, reverting on
-   * overflow (when the input is greater than largest uint128).
-   *
-   * Counterpart to Solidity's `uint128` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 128 bits
-   */
-  function toUint128(uint256 value) internal pure returns (uint128) {
-    require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
-    return uint128(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint96 from uint256, reverting on
-   * overflow (when the input is greater than largest uint96).
-   *
-   * Counterpart to Solidity's `uint96` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 96 bits
-   */
-  function toUint96(uint256 value) internal pure returns (uint96) {
-    require(value <= type(uint96).max, "SafeCast: value doesn't fit in 96 bits");
-    return uint96(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint64 from uint256, reverting on
-   * overflow (when the input is greater than largest uint64).
-   *
-   * Counterpart to Solidity's `uint64` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 64 bits
-   */
-  function toUint64(uint256 value) internal pure returns (uint64) {
-    require(value <= type(uint64).max, "SafeCast: value doesn't fit in 64 bits");
-    return uint64(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint32 from uint256, reverting on
-   * overflow (when the input is greater than largest uint32).
-   *
-   * Counterpart to Solidity's `uint32` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 32 bits
-   */
-  function toUint32(uint256 value) internal pure returns (uint32) {
-    require(value <= type(uint32).max, "SafeCast: value doesn't fit in 32 bits");
-    return uint32(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint16 from uint256, reverting on
-   * overflow (when the input is greater than largest uint16).
-   *
-   * Counterpart to Solidity's `uint16` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 16 bits
-   */
-  function toUint16(uint256 value) internal pure returns (uint16) {
-    require(value <= type(uint16).max, "SafeCast: value doesn't fit in 16 bits");
-    return uint16(value);
-  }
-
-  /**
-   * @dev Returns the downcasted uint8 from uint256, reverting on
-   * overflow (when the input is greater than largest uint8).
-   *
-   * Counterpart to Solidity's `uint8` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 8 bits.
-   */
-  function toUint8(uint256 value) internal pure returns (uint8) {
-    require(value <= type(uint8).max, "SafeCast: value doesn't fit in 8 bits");
-    return uint8(value);
-  }
-
-  /**
-   * @dev Converts a signed int256 into an unsigned uint256.
-   *
-   * Requirements:
-   *
-   * - input must be greater than or equal to 0.
-   */
-  function toUint256(int256 value) internal pure returns (uint256) {
-    require(value >= 0, 'SafeCast: value must be positive');
-    return uint256(value);
-  }
-
-  /**
-   * @dev Returns the downcasted int128 from int256, reverting on
-   * overflow (when the input is less than smallest int128 or
-   * greater than largest int128).
-   *
-   * Counterpart to Solidity's `int128` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 128 bits
-   *
-   * _Available since v3.1._
-   */
-  function toInt128(int256 value) internal pure returns (int128) {
-    require(
-      value >= type(int128).min && value <= type(int128).max,
-      "SafeCast: value doesn't fit in 128 bits"
-    );
-    return int128(value);
-  }
-
-  /**
-   * @dev Returns the downcasted int64 from int256, reverting on
-   * overflow (when the input is less than smallest int64 or
-   * greater than largest int64).
-   *
-   * Counterpart to Solidity's `int64` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 64 bits
-   *
-   * _Available since v3.1._
-   */
-  function toInt64(int256 value) internal pure returns (int64) {
-    require(
-      value >= type(int64).min && value <= type(int64).max,
-      "SafeCast: value doesn't fit in 64 bits"
-    );
-    return int64(value);
-  }
-
-  /**
-   * @dev Returns the downcasted int32 from int256, reverting on
-   * overflow (when the input is less than smallest int32 or
-   * greater than largest int32).
-   *
-   * Counterpart to Solidity's `int32` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 32 bits
-   *
-   * _Available since v3.1._
-   */
-  function toInt32(int256 value) internal pure returns (int32) {
-    require(
-      value >= type(int32).min && value <= type(int32).max,
-      "SafeCast: value doesn't fit in 32 bits"
-    );
-    return int32(value);
-  }
-
-  /**
-   * @dev Returns the downcasted int16 from int256, reverting on
-   * overflow (when the input is less than smallest int16 or
-   * greater than largest int16).
-   *
-   * Counterpart to Solidity's `int16` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 16 bits
-   *
-   * _Available since v3.1._
-   */
-  function toInt16(int256 value) internal pure returns (int16) {
-    require(
-      value >= type(int16).min && value <= type(int16).max,
-      "SafeCast: value doesn't fit in 16 bits"
-    );
-    return int16(value);
-  }
-
-  /**
-   * @dev Returns the downcasted int8 from int256, reverting on
-   * overflow (when the input is less than smallest int8 or
-   * greater than largest int8).
-   *
-   * Counterpart to Solidity's `int8` operator.
-   *
-   * Requirements:
-   *
-   * - input must fit into 8 bits.
-   *
-   * _Available since v3.1._
-   */
-  function toInt8(int256 value) internal pure returns (int8) {
-    require(
-      value >= type(int8).min && value <= type(int8).max,
-      "SafeCast: value doesn't fit in 8 bits"
-    );
-    return int8(value);
-  }
-
-  /**
-   * @dev Converts an unsigned uint256 into a signed int256.
-   *
-   * Requirements:
-   *
-   * - input must be less than or equal to maxInt256.
-   */
-  function toInt256(uint256 value) internal pure returns (int256) {
-    // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
-    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
-    return int256(value);
-  }
-}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol b/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol
deleted file mode 100644
index 901e875..0000000
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: AGPL-3.0
-pragma solidity 0.8.10;
-
-/**
- * @title IScaledBalanceToken
- * @author Aave
- * @notice Defines the basic interface for a scaledbalance token.
- **/
-interface IScaledBalanceToken {
-  /**
-   * @dev Emitted after the mint action
-   * @param caller The address performing the mint
-   * @param onBehalfOf The address of the user that will receive the minted scaled balance tokens
-   * @param value The amount being minted (user entered amount + balance increase from interest)
-   * @param balanceIncrease The increase in balance since the last action of the user
-   * @param index The next liquidity index of the reserve
-   **/
-  event Mint(
-    address indexed caller,
-    address indexed onBehalfOf,
-    uint256 value,
-    uint256 balanceIncrease,
-    uint256 index
-  );
-
-  /**
-   * @dev Emitted after scaled balance tokens are burned
-   * @param from The address from which the scaled tokens will be burned
-   * @param target The address that will receive the underlying, if any
-   * @param value The amount being burned (user entered amount - balance increase from interest)
-   * @param balanceIncrease The increase in balance since the last action of the user
-   * @param index The next liquidity index of the reserve
-   **/
-  event Burn(
-    address indexed from,
-    address indexed target,
-    uint256 value,
-    uint256 balanceIncrease,
-    uint256 index
-  );
-
-  /**
-   * @notice Returns the scaled balance of the user.
-   * @dev The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
-   * at the moment of the update
-   * @param user The user whose balance is calculated
-   * @return The scaled balance of the user
-   **/
-  function scaledBalanceOf(address user) external view returns (uint256);
-
-  /**
-   * @notice Returns the scaled balance of the user and the scaled total supply.
-   * @param user The address of the user
-   * @return The scaled balance of the user
-   * @return The scaled total supply
-   **/
-  function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256);
-
-  /**
-   * @notice Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)
-   * @return The scaled total supply
-   **/
-  function scaledTotalSupply() external view returns (uint256);
-
-  /**
-   * @notice Returns last index interest was accrued to the user's balance
-   * @param user The address of the user
-   * @return The last index interest was accrued to the user's balance, expressed in ray
-   **/
-  function getPreviousIndex(address user) external view returns (uint256);
-}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol b/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
deleted file mode 100644
index 570c319..0000000
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: AGPL-3.0
-pragma solidity 0.8.10;
-
-/**
- * @title VersionedInitializable
- * @author Aave, inspired by the OpenZeppelin Initializable contract
- * @notice Helper contract to implement initializer functions. To use it, replace
- * the constructor with a function that has the `initializer` modifier.
- * @dev WARNING: Unlike constructors, initializer functions must be manually
- * invoked. This applies both to deploying an Initializable contract, as well
- * as extending an Initializable contract via inheritance.
- * WARNING: When used with inheritance, manual care must be taken to not invoke
- * a parent initializer twice, or ensure that all initializers are idempotent,
- * because this is not dealt with automatically as with constructors.
- */
-abstract contract VersionedInitializable {
-  /**
-   * @dev Indicates that the contract has been initialized.
-   */
-  uint256 private lastInitializedRevision = 0;
-
-  /**
-   * @dev Indicates that the contract is in the process of being initialized.
-   */
-  bool private initializing;
-
-  /**
-   * @dev Modifier to use in the initializer function of a contract.
-   */
-  modifier initializer() {
-    uint256 revision = getRevision();
-    require(
-      initializing || isConstructor() || revision > lastInitializedRevision,
-      'Contract instance has already been initialized'
-    );
-
-    bool isTopLevelCall = !initializing;
-    if (isTopLevelCall) {
-      initializing = true;
-      lastInitializedRevision = revision;
-    }
-
-    _;
-
-    if (isTopLevelCall) {
-      initializing = false;
-    }
-  }
-
-  /**
-   * @notice Returns the revision number of the contract
-   * @dev Needs to be defined in the inherited class as a constant.
-   * @return The revision number
-   **/
-  function getRevision() internal pure virtual returns (uint256);
-
-  /**
-   * @notice Returns true if and only if the function is running in the constructor
-   * @return True if the function is running in the constructor
-   **/
-  function isConstructor() private view returns (bool) {
-    // extcodesize checks the size of the code stored in an address, and
-    // address returns the current address. Since the code is still not
-    // deployed when running a constructor, any checks on its code size will
-    // yield zero, making it an effective way to detect if a contract is
-    // under construction or not.
-    uint256 cs;
-    //solium-disable-next-line
-    assembly {
-      cs := extcodesize(address())
-    }
-    return cs == 0;
-  }
-
-  // Reserved storage space to allow for layout changes in the future.
-  uint256[50] private ______gap;
-}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol b/./src/contracts/RewardsController.sol
similarity index 96%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol
rename to ./src/contracts/RewardsController.sol
index 45bd0ea..8b7aeac 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol
+++ b/./src/contracts/RewardsController.sol
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 import {VersionedInitializable} from '@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol';
 import {SafeCast} from '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol';
 import {IScaledBalanceToken} from '@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol';
 import {RewardsDistributor} from './RewardsDistributor.sol';
-import {IRewardsController} from './interfaces/IRewardsController.sol';
-import {ITransferStrategyBase} from './interfaces/ITransferStrategyBase.sol';
-import {RewardsDataTypes} from './libraries/RewardsDataTypes.sol';
-import {IEACAggregatorProxy} from '../misc/interfaces/IEACAggregatorProxy.sol';
+import {IRewardsController} from '../interfaces/IRewardsController.sol';
+import {ITransferStrategyBase} from '../interfaces/ITransferStrategyBase.sol';
+import {RewardsDataTypes} from '../libraries/RewardsDataTypes.sol';
+import {IEACAggregatorProxy} from '../interfaces/IEACAggregatorProxy.sol';
 
 /**
  * @title RewardsController
@@ -18,7 +18,7 @@ import {IEACAggregatorProxy} from '../misc/interfaces/IEACAggregatorProxy.sol';
 contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 1;
+  uint256 public constant REVISION = 2;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
@@ -45,11 +45,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
 
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
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol b/./src/contracts/RewardsDistributor.sol
similarity index 96%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol
rename to ./src/contracts/RewardsDistributor.sol
index 56db747..9d3429c 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol
+++ b/./src/contracts/RewardsDistributor.sol
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
+import {IScaledBalanceToken} from '@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol';
 import {IERC20Detailed} from '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol';
 import {SafeCast} from '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol';
-import {IRewardsDistributor} from './interfaces/IRewardsDistributor.sol';
-import {RewardsDataTypes} from './libraries/RewardsDataTypes.sol';
+import {IRewardsDistributor} from '../interfaces/IRewardsDistributor.sol';
+import {RewardsDataTypes} from '../libraries/RewardsDataTypes.sol';
 
 /**
  * @title RewardsDistributor
@@ -57,6 +58,22 @@ abstract contract RewardsDistributor is IRewardsDistributor {
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
@@ -186,7 +203,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
       (uint256 newIndex, ) = _updateRewardData(
         rewardConfig,
-        IERC20Detailed(asset).totalSupply(),
+        IScaledBalanceToken(asset).scaledTotalSupply(),
         10**decimals
       );
 
diff --git a/./src/contracts/UpgradeRewardsControllerPayload.sol b/./src/contracts/UpgradeRewardsControllerPayload.sol
new file mode 100644
index 0000000..0ad289a
--- /dev/null
+++ b/./src/contracts/UpgradeRewardsControllerPayload.sol
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: MIT
+pragma solidity ^0.8.0;
+
+import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
+import {RewardsController} from './RewardsController.sol';
+import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';
+import {IInitializableAdminUpgradeabilityProxy} from '../interfaces/IInitializableAdminUpgradeabilityProxy.sol';
+
+contract UpgradeRewardsControllerPayload is IProposalGenericExecutor {
+  // generic constants
+  bytes32 public constant INCENTIVES_CONTROLLER_ADDRESS_ID =
+    0x703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba54532; // keccak256("INCENTIVES_CONTROLLER")
+
+  // network specific addresses
+  IPoolAddressesProvider public immutable POOL_ADDRESS_PROVIDER;
+  address public immutable INCENTIVES_CONTROLLER;
+
+  constructor(IPoolAddressesProvider poolAddressesProvider, address incentivesController) {
+    INCENTIVES_CONTROLLER = incentivesController;
+    POOL_ADDRESS_PROVIDER = poolAddressesProvider;
+  }
+
+  function execute() external {
+    address emissionManager = RewardsController(INCENTIVES_CONTROLLER).getEmissionManager();
+    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
+    POOL_ADDRESS_PROVIDER.setAddressAsProxy(
+      INCENTIVES_CONTROLLER_ADDRESS_ID,
+      address(rewardsControllerImpl)
+    );
+  }
+}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol b/./src/interfaces/IEACAggregatorProxy.sol
similarity index 96%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol
rename to ./src/interfaces/IEACAggregatorProxy.sol
index ddb6f13..3e7fb9a 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol
+++ b/./src/interfaces/IEACAggregatorProxy.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 interface IEACAggregatorProxy {
   function decimals() external view returns (uint8);
diff --git a/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol b/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol
new file mode 100644
index 0000000..d52ea98
--- /dev/null
+++ b/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: AGPL-3.0
+pragma solidity >=0.7.0 <0.9.0;
+
+interface IInitializableAdminUpgradeabilityProxy {
+  function upgradeTo(address newImpl) external;
+
+  function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
+
+  function admin() external returns (address);
+
+  function REVISION() external returns (uint256);
+
+  function changeAdmin(address newAdmin) external;
+
+  function implementation() external returns (address);
+}
diff --git a/./src/interfaces/IProposalGenericExecutor.sol b/./src/interfaces/IProposalGenericExecutor.sol
new file mode 100644
index 0000000..b3ef5d6
--- /dev/null
+++ b/./src/interfaces/IProposalGenericExecutor.sol
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: MIT
+pragma solidity ^0.8.0;
+
+interface IProposalGenericExecutor {
+  function execute() external;
+}
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol b/./src/interfaces/IRewardsController.sol
similarity index 98%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol
rename to ./src/interfaces/IRewardsController.sol
index 706e3cd..3604f8e 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol
+++ b/./src/interfaces/IRewardsController.sol
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 import {IRewardsDistributor} from './IRewardsDistributor.sol';
 import {ITransferStrategyBase} from './ITransferStrategyBase.sol';
-import {IEACAggregatorProxy} from '../../misc/interfaces/IEACAggregatorProxy.sol';
+import {IEACAggregatorProxy} from './IEACAggregatorProxy.sol';
 import {RewardsDataTypes} from '../libraries/RewardsDataTypes.sol';
 
 /**
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol b/./src/interfaces/IRewardsDistributor.sol
similarity index 93%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol
rename to ./src/interfaces/IRewardsDistributor.sol
index 431fdfe..63ab688 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol
+++ b/./src/interfaces/IRewardsDistributor.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 /**
  * @title IRewardsDistributor
@@ -119,6 +119,15 @@ interface IRewardsDistributor {
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
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol b/./src/interfaces/ITransferStrategyBase.sol
similarity index 98%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol
rename to ./src/interfaces/ITransferStrategyBase.sol
index 46d67b0..b1007a0 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol
+++ b/./src/interfaces/ITransferStrategyBase.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: AGPL-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 interface ITransferStrategyBase {
   event EmergencyWithdrawal(
diff --git a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol b/./src/libraries/RewardsDataTypes.sol
similarity index 89%
rename from ./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol
rename to ./src/libraries/RewardsDataTypes.sol
index e8e631c..8ee3e33 100644
--- a/./etherscan/polygon_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol
+++ b/./src/libraries/RewardsDataTypes.sol
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 import {ITransferStrategyBase} from '../interfaces/ITransferStrategyBase.sol';
-import {IEACAggregatorProxy} from '../../misc/interfaces/IEACAggregatorProxy.sol';
+import {IEACAggregatorProxy} from '../interfaces/IEACAggregatorProxy.sol';
 
 library RewardsDataTypes {
   struct RewardsConfigInput {
```
