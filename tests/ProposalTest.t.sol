// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';

contract ProposalTest is Test {
  UpgradeRewardsControllerPayload public payload;
  uint256 optimismFork;

  function setUp() public {
    optimismFork = vm.createSelectFork(vm.rpcUrl('optimism'), 30039500);
    payload = new UpgradeRewardsControllerPayload(
      AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER
    );
  }

  function testProposalE2E() public {
    payload.execute();
  }
}
