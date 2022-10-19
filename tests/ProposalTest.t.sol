// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';

contract ProposalTest is Test {
  UpgradeRewardsControllerPayload public payload;
  uint256 optimismFork;

  function setUp() public {
    optimismFork = vm.createSelectFork(vm.rpcUrl('avalanche'), 21227378);
    payload = new UpgradeRewardsControllerPayload(
      AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER
    );
  }

  function testProposalpayload() public {
    vm.startPrank(address(AaveV3Avalanche.ACL_ADMIN));
    address(payload).delegatecall(
      abi.encodeWithSelector(payload.execute.selector)
    );

    // assertEq(
    //   IInitializableAdminUpgradeabilityProxy(
    //     AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER
    //   ).implementation(),
    //   address(payload)
    // );
  }
}
