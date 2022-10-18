// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';

contract Deploy is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(address(0));
    vm.stopBroadcast();
  }
}
