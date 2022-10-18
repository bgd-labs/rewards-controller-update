// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RewardsController} from 'aave-v3-periphery/contracts/rewards/RewardsController.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../interfaces/IInitializableAdminUpgradeabilityProxy.sol';

contract UpgradeRewardsControllerPayload is IProposalGenericExecutor {
  address immutable INCENTIVES_CONTROLLER;

  constructor(address incentivesController) {
    INCENTIVES_CONTROLLER = incentivesController;
  }

  function execute() external {
    address emissionManager = RewardsController(INCENTIVES_CONTROLLER)
      .getEmissionManager();
    RewardsController rewardsControllerImpl = new RewardsController(
      emissionManager
    );
    IInitializableAdminUpgradeabilityProxy(INCENTIVES_CONTROLLER)
      .upgradeToAndCall(
        address(rewardsControllerImpl),
        abi.encodeWithSelector(
          RewardsController.initialize.selector,
          emissionManager
        )
      );
  }
}
