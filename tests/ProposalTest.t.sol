// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Polygon, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony} from 'aave-address-book/AaveAddressBook.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';
import {MockExecutor} from './MockExecutor.sol';
import {BaseTest} from './BaseTest.sol';

contract ProposalTestPolygon is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 34550201);
    _setUp(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Polygon.ACL_ADMIN
    );
  }
}

contract ProposalTestAvalanche is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 21304418);
    _setUp(
      AaveV3Avalanche.POOL_ADDRESSES_PROVIDER,
      AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Avalanche.ACL_ADMIN
    );
  }
}

contract ProposalTestOptimism is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 30397201);
    _setUp(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Optimism.ACL_ADMIN
    );
  }
}

contract ProposalTestArbitrum is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 31262890);
    _setUp(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Arbitrum.ACL_ADMIN
    );
  }
}

contract ProposalTestFantom is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('fantom'), 49609704);
    _setUp(
      AaveV3Fantom.POOL_ADDRESSES_PROVIDER,
      AaveV3Fantom.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Fantom.ACL_ADMIN
    );
  }
}

contract ProposalTestHarmony is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('harmony'), 32871646);
    _setUp(
      AaveV3Harmony.POOL_ADDRESSES_PROVIDER,
      AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Harmony.ACL_ADMIN
    );
  }
}
