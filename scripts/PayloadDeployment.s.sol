// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3Goerli, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony} from 'aave-address-book/AaveAddressBook.sol';
import {Test} from 'forge-std/Test.sol';
import {Script} from 'forge-std/Script.sol';
import {RewardsController} from '@aave/periphery-v3/contracts/rewards/RewardsController.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
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

// test
contract DeployGoerli is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Goerli.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract DeployAvalanche is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract DeployOptimism is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract DeployArbitrum is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract DeployFantom is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Fantom.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract DeployHarmony is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(emissionManager);
    vm.stopBroadcast();
  }
}

contract EmitCalldata is Script, Test {
  function run(address rewardsControllerImpl) external {
    bytes memory callData = abi.encodeWithSelector(
      IPoolAddressesProvider.setAddressAsProxy.selector,
      rewardsControllerImpl
    );
    emit log_bytes(callData);
  }
}
