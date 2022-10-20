// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony} from 'aave-address-book/AaveAddressBook.sol';
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

contract DeployAvalanche is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Avalanche.POOL_ADDRESSES_PROVIDER,
      AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}

contract DeployOptimism is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}

contract DeployArbitrum is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}

contract DeployFantom is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Fantom.POOL_ADDRESSES_PROVIDER,
      AaveV3Fantom.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}

contract DeployHarmony is Script {
  function run() external {
    vm.startBroadcast();
    new UpgradeRewardsControllerPayload(
      AaveV3Harmony.POOL_ADDRESSES_PROVIDER,
      AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER
    );
    vm.stopBroadcast();
  }
}
