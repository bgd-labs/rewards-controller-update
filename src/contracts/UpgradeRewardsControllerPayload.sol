// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {RewardsController} from './RewardsController.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../interfaces/IInitializableAdminUpgradeabilityProxy.sol';

contract UpgradeRewardsControllerPayload is IProposalGenericExecutor {
  // generic constants
  bytes32 public constant INCENTIVES_CONTROLLER_ADDRESS_ID =
    0x703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba54532; // keccak256("INCENTIVES_CONTROLLER")

  // network specific addresses
  IPoolAddressesProvider public immutable POOL_ADDRESS_PROVIDER;
  address public immutable INCENTIVES_CONTROLLER;

  constructor(IPoolAddressesProvider poolAddressesProvider, address incentivesController) {
    INCENTIVES_CONTROLLER = incentivesController;
    POOL_ADDRESS_PROVIDER = poolAddressesProvider;
  }

  function execute() external {
    address emissionManager = RewardsController(INCENTIVES_CONTROLLER).getEmissionManager();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    POOL_ADDRESS_PROVIDER.setAddressAsProxy(
      INCENTIVES_CONTROLLER_ADDRESS_ID,
      address(rewardsControllerImpl)
    );
  }
}
