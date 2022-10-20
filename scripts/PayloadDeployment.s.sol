// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {Script} from 'forge-std/Script.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';

contract DeployPolygon is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}
