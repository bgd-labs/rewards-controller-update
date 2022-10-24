```diff
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol b/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol
deleted file mode 100644
index 7dc5593..0000000
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol b/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
deleted file mode 100644
index 0269305..0000000
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol b/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
deleted file mode 100644
index 6d70809..0000000
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol b/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol
deleted file mode 100644
index 901e875..0000000
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/interfaces/IScaledBalanceToken.sol
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol b/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
deleted file mode 100644
index 570c319..0000000
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol b/./src/contracts/RewardsController.sol
similarity index 85%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol
rename to ./src/contracts/RewardsController.sol
index 45bd0ea..21ce886 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol
+++ b/./src/contracts/RewardsController.sol
@@ -1,24 +1,28 @@
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
  * @notice Abstract contract template to build Distributors contracts for ERC20 rewards to protocol participants
  * @author Aave
  **/
-contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
+contract RewardsController is
+  RewardsDistributor,
+  VersionedInitializable,
+  IRewardsController
+{
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 1;
+  uint256 public constant REVISION = 2;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
@@ -45,11 +49,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
 
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
@@ -65,12 +68,22 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   }
 
   /// @inheritdoc IRewardsController
-  function getRewardOracle(address reward) external view override returns (address) {
+  function getRewardOracle(address reward)
+    external
+    view
+    override
+    returns (address)
+  {
     return address(_rewardOracle[reward]);
   }
 
   /// @inheritdoc IRewardsController
-  function getTransferStrategy(address reward) external view override returns (address) {
+  function getTransferStrategy(address reward)
+    external
+    view
+    override
+    returns (address)
+  {
     return address(_transferStrategy[reward]);
   }
 
@@ -82,7 +95,8 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   {
     for (uint256 i = 0; i < config.length; i++) {
       // Get the current Scaled Total Supply of AToken or Debt token
-      config[i].totalSupply = IScaledBalanceToken(config[i].asset).scaledTotalSupply();
+      config[i].totalSupply = IScaledBalanceToken(config[i].asset)
+        .scaledTotalSupply();
 
       // Install TransferStrategy logic at IncentivesController
       _installTransferStrategy(config[i].reward, config[i].transferStrategy);
@@ -94,10 +108,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   }
 
   /// @inheritdoc IRewardsController
-  function setTransferStrategy(address reward, ITransferStrategyBase transferStrategy)
-    external
-    onlyEmissionManager
-  {
+  function setTransferStrategy(
+    address reward,
+    ITransferStrategyBase transferStrategy
+  ) external onlyEmissionManager {
     _installTransferStrategy(reward, transferStrategy);
   }
 
@@ -136,7 +150,12 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
     address user,
     address to,
     address reward
-  ) external override onlyAuthorizedClaimers(msg.sender, user) returns (uint256) {
+  )
+    external
+    override
+    onlyAuthorizedClaimers(msg.sender, user)
+    returns (uint256)
+  {
     require(user != address(0), 'INVALID_USER_ADDRESS');
     require(to != address(0), 'INVALID_TO_ADDRESS');
     return _claimRewards(assets, amount, msg.sender, user, to, reward);
@@ -148,7 +167,8 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
     uint256 amount,
     address reward
   ) external override returns (uint256) {
-    return _claimRewards(assets, amount, msg.sender, msg.sender, msg.sender, reward);
+    return
+      _claimRewards(assets, amount, msg.sender, msg.sender, msg.sender, reward);
   }
 
   /// @inheritdoc IRewardsController
@@ -187,7 +207,11 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   }
 
   /// @inheritdoc IRewardsController
-  function setClaimer(address user, address caller) external override onlyEmissionManager {
+  function setClaimer(address user, address caller)
+    external
+    override
+    onlyEmissionManager
+  {
     _authorizedClaimers[user] = caller;
     emit ClaimerSet(user, caller);
   }
@@ -207,9 +231,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
     userAssetBalances = new RewardsDataTypes.UserAssetBalance[](assets.length);
     for (uint256 i = 0; i < assets.length; i++) {
       userAssetBalances[i].asset = assets[i];
-      (userAssetBalances[i].userBalance, userAssetBalances[i].totalSupply) = IScaledBalanceToken(
-        assets[i]
-      ).getScaledUserBalanceAndSupply(user);
+      (
+        userAssetBalances[i].userBalance,
+        userAssetBalances[i].totalSupply
+      ) = IScaledBalanceToken(assets[i]).getScaledUserBalanceAndSupply(user);
     }
     return userAssetBalances;
   }
@@ -247,7 +272,8 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
       } else {
         uint256 difference = totalRewards - amount;
         totalRewards -= difference;
-        _assets[asset].rewards[reward].usersData[user].accrued = difference.toUint128();
+        _assets[asset].rewards[reward].usersData[user].accrued = difference
+          .toUint128();
         break;
       }
     }
@@ -277,7 +303,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
     address claimer,
     address user,
     address to
-  ) internal returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {
+  )
+    internal
+    returns (address[] memory rewardsList, uint256[] memory claimedAmounts)
+  {
     uint256 rewardsListLength = _rewardsList.length;
     rewardsList = new address[](rewardsListLength);
     claimedAmounts = new uint256[](rewardsListLength);
@@ -290,7 +319,10 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
         if (rewardsList[j] == address(0)) {
           rewardsList[j] = _rewardsList[j];
         }
-        uint256 rewardAmount = _assets[asset].rewards[rewardsList[j]].usersData[user].accrued;
+        uint256 rewardAmount = _assets[asset]
+          .rewards[rewardsList[j]]
+          .usersData[user]
+          .accrued;
         if (rewardAmount != 0) {
           claimedAmounts[j] += rewardAmount;
           _assets[asset].rewards[rewardsList[j]].usersData[user].accrued = 0;
@@ -345,11 +377,18 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
    * @param reward The address of the reward token
    * @param transferStrategy The address of the reward TransferStrategy
    */
-  function _installTransferStrategy(address reward, ITransferStrategyBase transferStrategy)
-    internal
-  {
-    require(address(transferStrategy) != address(0), 'STRATEGY_CAN_NOT_BE_ZERO');
-    require(_isContract(address(transferStrategy)) == true, 'STRATEGY_MUST_BE_CONTRACT');
+  function _installTransferStrategy(
+    address reward,
+    ITransferStrategyBase transferStrategy
+  ) internal {
+    require(
+      address(transferStrategy) != address(0),
+      'STRATEGY_CAN_NOT_BE_ZERO'
+    );
+    require(
+      _isContract(address(transferStrategy)) == true,
+      'STRATEGY_MUST_BE_CONTRACT'
+    );
 
     _transferStrategy[reward] = transferStrategy;
 
@@ -363,7 +402,9 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
    * @param rewardOracle The address of the price oracle
    */
 
-  function _setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) internal {
+  function _setRewardOracle(address reward, IEACAggregatorProxy rewardOracle)
+    internal
+  {
     require(rewardOracle.latestAnswer() > 0, 'ORACLE_MUST_RETURN_PRICE');
     _rewardOracle[reward] = rewardOracle;
     emit RewardOracleUpdated(reward, address(rewardOracle));
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol b/./src/contracts/RewardsDistributor.sol
similarity index 87%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol
rename to ./src/contracts/RewardsDistributor.sol
index 56db747..a4d7f98 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsDistributor.sol
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
@@ -57,6 +58,24 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     );
   }
 
+  /// @inheritdoc IRewardsDistributor
+  function getAssetIndex(address asset, address reward)
+    external
+    view
+    override
+    returns (uint256, uint256)
+  {
+    RewardsDataTypes.RewardData storage rewardData = _assets[asset].rewards[
+      reward
+    ];
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
@@ -68,7 +87,12 @@ abstract contract RewardsDistributor is IRewardsDistributor {
   }
 
   /// @inheritdoc IRewardsDistributor
-  function getRewardsByAsset(address asset) external view override returns (address[] memory) {
+  function getRewardsByAsset(address asset)
+    external
+    view
+    override
+    returns (address[] memory)
+  {
     uint128 rewardsCount = _assets[asset].availableRewardsCount;
     address[] memory availableRewards = new address[](rewardsCount);
 
@@ -101,7 +125,10 @@ abstract contract RewardsDistributor is IRewardsDistributor {
   {
     uint256 totalAccrued;
     for (uint256 i = 0; i < _assetsList.length; i++) {
-      totalAccrued += _assets[_assetsList[i]].rewards[reward].usersData[user].accrued;
+      totalAccrued += _assets[_assetsList[i]]
+        .rewards[reward]
+        .usersData[user]
+        .accrued;
     }
 
     return totalAccrued;
@@ -123,10 +150,8 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     override
     returns (address[] memory rewardsList, uint256[] memory unclaimedAmounts)
   {
-    RewardsDataTypes.UserAssetBalance[] memory userAssetBalances = _getUserAssetBalances(
-      assets,
-      user
-    );
+    RewardsDataTypes.UserAssetBalance[]
+      memory userAssetBalances = _getUserAssetBalances(assets, user);
     rewardsList = new address[](_rewardsList.length);
     unclaimedAmounts = new uint256[](rewardsList.length);
 
@@ -142,7 +167,11 @@ abstract contract RewardsDistributor is IRewardsDistributor {
         if (userAssetBalances[i].userBalance == 0) {
           continue;
         }
-        unclaimedAmounts[r] += _getPendingRewards(user, rewardsList[r], userAssetBalances[i]);
+        unclaimedAmounts[r] += _getPendingRewards(
+          user,
+          rewardsList[r],
+          userAssetBalances[i]
+        );
       }
     }
     return (rewardsList, unclaimedAmounts);
@@ -177,7 +206,9 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     require(rewards.length == newEmissionsPerSecond.length, 'INVALID_INPUT');
     for (uint256 i = 0; i < rewards.length; i++) {
       RewardsDataTypes.AssetData storage assetConfig = _assets[asset];
-      RewardsDataTypes.RewardData storage rewardConfig = _assets[asset].rewards[rewards[i]];
+      RewardsDataTypes.RewardData storage rewardConfig = _assets[asset].rewards[
+        rewards[i]
+      ];
       uint256 decimals = assetConfig.decimals;
       require(
         decimals != 0 && rewardConfig.lastUpdateTimestamp != 0,
@@ -186,7 +217,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 
       (uint256 newIndex, ) = _updateRewardData(
         rewardConfig,
-        IERC20Detailed(asset).totalSupply(),
+        IScaledBalanceToken(asset).scaledTotalSupply(),
         10**decimals
       );
 
@@ -209,20 +240,21 @@ abstract contract RewardsDistributor is IRewardsDistributor {
    * @dev Configure the _assets for a specific emission
    * @param rewardsInput The array of each asset configuration
    **/
-  function _configureAssets(RewardsDataTypes.RewardsConfigInput[] memory rewardsInput) internal {
+  function _configureAssets(
+    RewardsDataTypes.RewardsConfigInput[] memory rewardsInput
+  ) internal {
     for (uint256 i = 0; i < rewardsInput.length; i++) {
       if (_assets[rewardsInput[i].asset].decimals == 0) {
         //never initialized before, adding to the list of assets
         _assetsList.push(rewardsInput[i].asset);
       }
 
-      uint256 decimals = _assets[rewardsInput[i].asset].decimals = IERC20Detailed(
+      uint256 decimals = _assets[rewardsInput[i].asset]
+        .decimals = IERC20Detailed(rewardsInput[i].asset).decimals();
+
+      RewardsDataTypes.RewardData storage rewardConfig = _assets[
         rewardsInput[i].asset
-      ).decimals();
-
-      RewardsDataTypes.RewardData storage rewardConfig = _assets[rewardsInput[i].asset].rewards[
-        rewardsInput[i].reward
-      ];
+      ].rewards[rewardsInput[i].reward];
 
       // Add reward address to asset available rewards if latestUpdateTimestamp is zero
       if (rewardConfig.lastUpdateTimestamp == 0) {
@@ -276,7 +308,11 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     uint256 totalSupply,
     uint256 assetUnit
   ) internal returns (uint256, bool) {
-    (uint256 oldIndex, uint256 newIndex) = _getAssetIndex(rewardData, totalSupply, assetUnit);
+    (uint256 oldIndex, uint256 newIndex) = _getAssetIndex(
+      rewardData,
+      totalSupply,
+      assetUnit
+    );
     bool indexUpdated;
     if (newIndex != oldIndex) {
       require(newIndex <= type(uint104).max, 'INDEX_OVERFLOW');
@@ -315,7 +351,12 @@ abstract contract RewardsDistributor is IRewardsDistributor {
       // already checked for overflow in _updateRewardData
       rewardData.usersData[user].index = uint104(newAssetIndex);
       if (userBalance != 0) {
-        rewardsAccrued = _getRewards(userBalance, newAssetIndex, userIndex, assetUnit);
+        rewardsAccrued = _getRewards(
+          userBalance,
+          newAssetIndex,
+          userIndex,
+          assetUnit
+        );
 
         rewardData.usersData[user].accrued += rewardsAccrued.toUint128();
       }
@@ -348,7 +389,9 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     unchecked {
       for (uint128 r = 0; r < numAvailableRewards; r++) {
         address reward = _assets[asset].availableRewards[r];
-        RewardsDataTypes.RewardData storage rewardData = _assets[asset].rewards[reward];
+        RewardsDataTypes.RewardData storage rewardData = _assets[asset].rewards[
+          reward
+        ];
 
         (uint256 newAssetIndex, bool rewardDataUpdated) = _updateRewardData(
           rewardData,
@@ -365,7 +408,14 @@ abstract contract RewardsDistributor is IRewardsDistributor {
         );
 
         if (rewardDataUpdated || userDataUpdated) {
-          emit Accrued(asset, reward, user, newAssetIndex, newAssetIndex, rewardsAccrued);
+          emit Accrued(
+            asset,
+            reward,
+            user,
+            newAssetIndex,
+            newAssetIndex,
+            rewardsAccrued
+          );
         }
       }
     }
@@ -409,7 +459,10 @@ abstract contract RewardsDistributor is IRewardsDistributor {
       }
       unclaimedRewards +=
         _getPendingRewards(user, reward, userAssetBalances[i]) +
-        _assets[userAssetBalances[i].asset].rewards[reward].usersData[user].accrued;
+        _assets[userAssetBalances[i].asset]
+          .rewards[reward]
+          .usersData[user]
+          .accrued;
     }
 
     return unclaimedRewards;
@@ -427,11 +480,15 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     address reward,
     RewardsDataTypes.UserAssetBalance memory userAssetBalance
   ) internal view returns (uint256) {
-    RewardsDataTypes.RewardData storage rewardData = _assets[userAssetBalance.asset].rewards[
-      reward
-    ];
+    RewardsDataTypes.RewardData storage rewardData = _assets[
+      userAssetBalance.asset
+    ].rewards[reward];
     uint256 assetUnit = 10**_assets[userAssetBalance.asset].decimals;
-    (, uint256 nextIndex) = _getAssetIndex(rewardData, userAssetBalance.totalSupply, assetUnit);
+    (, uint256 nextIndex) = _getAssetIndex(
+      rewardData,
+      userAssetBalance.totalSupply,
+      assetUnit
+    );
 
     return
       _getRewards(
@@ -522,7 +579,10 @@ abstract contract RewardsDistributor is IRewardsDistributor {
   }
 
   /// @inheritdoc IRewardsDistributor
-  function setEmissionManager(address emissionManager) external onlyEmissionManager {
+  function setEmissionManager(address emissionManager)
+    external
+    onlyEmissionManager
+  {
     _setEmissionManager(emissionManager);
   }
 
diff --git a/./src/contracts/UpgradeRewardsControllerPayload.sol b/./src/contracts/UpgradeRewardsControllerPayload.sol
new file mode 100644
index 0000000..7574af6
--- /dev/null
+++ b/./src/contracts/UpgradeRewardsControllerPayload.sol
@@ -0,0 +1,37 @@
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
+  constructor(
+    IPoolAddressesProvider poolAddressesProvider,
+    address incentivesController
+  ) {
+    INCENTIVES_CONTROLLER = incentivesController;
+    POOL_ADDRESS_PROVIDER = poolAddressesProvider;
+  }
+
+  function execute() external {
+    address emissionManager = RewardsController(INCENTIVES_CONTROLLER)
+      .getEmissionManager();
+    RewardsController rewardsControllerImpl = new RewardsController(
+      emissionManager
+    );
+    POOL_ADDRESS_PROVIDER.setAddressAsProxy(
+      INCENTIVES_CONTROLLER_ADDRESS_ID,
+      address(rewardsControllerImpl)
+    );
+  }
+}
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol b/./src/interfaces/IEACAggregatorProxy.sol
similarity index 96%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol
rename to ./src/interfaces/IEACAggregatorProxy.sol
index ddb6f13..3e7fb9a 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol
+++ b/./src/interfaces/IEACAggregatorProxy.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 interface IEACAggregatorProxy {
   function decimals() external view returns (uint8);
diff --git a/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol b/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol
new file mode 100644
index 0000000..ef975d2
--- /dev/null
+++ b/./src/interfaces/IInitializableAdminUpgradeabilityProxy.sol
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: AGPL-3.0
+pragma solidity >=0.7.0 <0.9.0;
+
+interface IInitializableAdminUpgradeabilityProxy {
+  function upgradeTo(address newImpl) external;
+
+  function upgradeToAndCall(address newImplementation, bytes calldata data)
+    external
+    payable;
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol b/./src/interfaces/IRewardsController.sol
similarity index 93%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol
rename to ./src/interfaces/IRewardsController.sol
index 706e3cd..1b87936 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol
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
@@ -40,14 +40,20 @@ interface IRewardsController is IRewardsDistributor {
    * @param reward The address of the token reward
    * @param transferStrategy The address of TransferStrategy contract
    */
-  event TransferStrategyInstalled(address indexed reward, address indexed transferStrategy);
+  event TransferStrategyInstalled(
+    address indexed reward,
+    address indexed transferStrategy
+  );
 
   /**
    * @dev Emitted when the reward oracle is updated
    * @param reward The address of the token reward
    * @param rewardOracle The address of oracle
    */
-  event RewardOracleUpdated(address indexed reward, address indexed rewardOracle);
+  event RewardOracleUpdated(
+    address indexed reward,
+    address indexed rewardOracle
+  );
 
   /**
    * @dev Whitelists an address to claim the rewards on behalf of another address
@@ -61,7 +67,10 @@ interface IRewardsController is IRewardsDistributor {
    * @param reward The address of the reward token
    * @param transferStrategy The address of the TransferStrategy logic contract
    */
-  function setTransferStrategy(address reward, ITransferStrategyBase transferStrategy) external;
+  function setTransferStrategy(
+    address reward,
+    ITransferStrategyBase transferStrategy
+  ) external;
 
   /**
    * @dev Sets an Aave Oracle contract to enforce rewards with a source of value.
@@ -72,7 +81,8 @@ interface IRewardsController is IRewardsDistributor {
    * @param reward The address of the reward to set the price aggregator
    * @param rewardOracle The address of price aggregator that follows IEACAggregatorProxy interface
    */
-  function setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) external;
+  function setRewardOracle(address reward, IEACAggregatorProxy rewardOracle)
+    external;
 
   /**
    * @dev Get the price aggregator oracle address
@@ -107,7 +117,8 @@ interface IRewardsController is IRewardsDistributor {
    *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
    *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
-  function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;
+  function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config)
+    external;
 
   /**
    * @dev Called by the corresponding asset on any update that affects the rewards distribution
@@ -191,7 +202,9 @@ interface IRewardsController is IRewardsDistributor {
     address[] calldata assets,
     address user,
     address to
-  ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
+  )
+    external
+    returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 
   /**
    * @dev Claims all reward for msg.sender, on all the assets of the pool, accumulating the pending rewards
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol b/./src/interfaces/IRewardsDistributor.sol
similarity index 93%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol
rename to ./src/interfaces/IRewardsDistributor.sol
index 431fdfe..2d76047 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol
+++ b/./src/interfaces/IRewardsDistributor.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: agpl-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 /**
  * @title IRewardsDistributor
@@ -119,6 +119,21 @@ interface IRewardsDistributor {
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
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol b/./src/interfaces/ITransferStrategyBase.sol
similarity index 98%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol
rename to ./src/interfaces/ITransferStrategyBase.sol
index 46d67b0..b1007a0 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol
+++ b/./src/interfaces/ITransferStrategyBase.sol
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: AGPL-3.0
-pragma solidity 0.8.10;
+pragma solidity ^0.8.10;
 
 interface ITransferStrategyBase {
   event EmergencyWithdrawal(
diff --git a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol b/./src/libraries/RewardsDataTypes.sol
similarity index 89%
rename from ./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol
rename to ./src/libraries/RewardsDataTypes.sol
index e8e631c..8ee3e33 100644
--- a/./etherscan/fantom_0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789/RewardsController/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol
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
