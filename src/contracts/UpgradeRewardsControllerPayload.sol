// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {RewardsController} from '@aave/periphery-v3/contracts/rewards/RewardsController.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../interfaces/IInitializableAdminUpgradeabilityProxy.sol';

/**
 * @title UpgradeRewardsControllerPayload
 * @author BGD Labs
 * @notice This payload will update the RewardsController implementation on a V3 pool
 * https://governance.aave.com/t/bgd-upgrade-of-aave-v3-periphery-to-3-0-1-across-networks/10744
 */
contract UpgradeRewardsControllerPayload is IProposalGenericExecutor {
  // generic constants
  bytes32 public constant INCENTIVES_CONTROLLER_ADDRESS_ID =
    0x703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba54532; // keccak256("INCENTIVES_CONTROLLER")

  // network specific addresses
  IPoolAddressesProvider public immutable POOL_ADDRESS_PROVIDER;
  RewardsController public immutable REWARDS_CONTROLLER_IMPL;

  constructor(IPoolAddressesProvider poolAddressesProvider, RewardsController rewardsControllerImpl)
  {
    POOL_ADDRESS_PROVIDER = poolAddressesProvider;
    REWARDS_CONTROLLER_IMPL = rewardsControllerImpl;
  }

  function execute() external {
    POOL_ADDRESS_PROVIDER.setAddressAsProxy(
      INCENTIVES_CONTROLLER_ADDRESS_ID,
      address(REWARDS_CONTROLLER_IMPL)
    );
  }
}
