// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony} from 'aave-address-book/AaveAddressBook.sol';
import {Test} from 'forge-std/Test.sol';
import {Script} from 'forge-std/Script.sol';
import {RewardsController} from '@aave/periphery-v3/contracts/rewards/RewardsController.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';

contract DeployPolygon is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    new UpgradeRewardsControllerPayload(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      rewardsControllerImpl
    );
    vm.stopBroadcast();
  }
}

contract DeployAvalanche is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    vm.stopBroadcast();
  }
}

contract DeployOptimism is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    vm.stopBroadcast();
  }
}

contract DeployArbitrum is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    vm.stopBroadcast();
  }
}

contract DeployFantom is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Fantom.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    vm.stopBroadcast();
  }
}

contract DeployHarmony is Script {
  function run() external {
    address emissionManager = RewardsController(AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER)
      .getEmissionManager();

    vm.startBroadcast();
    RewardsController rewardsControllerImpl = new RewardsController(emissionManager);
    rewardsControllerImpl.initialize(address(0));
    vm.stopBroadcast();
  }
}

contract EmitCalldata is Script, Test {
  bytes32 public constant INCENTIVES_CONTROLLER_ADDRESS_ID =
    0x703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba54532;

  function run(address rewardsControllerImpl) external returns (bytes memory) {
    bytes memory callData = abi.encodeWithSelector(
      IPoolAddressesProvider.setAddressAsProxy.selector,
      INCENTIVES_CONTROLLER_ADDRESS_ID,
      rewardsControllerImpl
    );
    emit log_bytes(callData);
    return callData;
  }
}
