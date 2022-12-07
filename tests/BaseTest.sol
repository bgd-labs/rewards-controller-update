// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {RewardsController} from '@aave/periphery-v3/contracts/rewards/RewardsController.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';
import {MockExecutor} from './MockExecutor.sol';

abstract contract Base is Test {
  IPoolAddressesProvider internal _poolAddressProvider;
  address internal _incentivesController;

  bytes32 public constant INCENTIVES_CONTROLLER_ADDRESS_ID =
    0x703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba54532; // keccak256("INCENTIVES_CONTROLLER")

  function _setUp(
    IPoolAddressesProvider poolAddressProvider,
    address incentivesController,
    address aclAdmin
  ) internal virtual;

  function _execute() internal virtual;

  function test_adminIsPoolAddressesProvider() public {
    assertEq(
      ProxyHelpers.getInitializableAdminUpgradeabilityProxyAdmin(vm, _incentivesController),
      address(_poolAddressProvider)
    );
  }

  function test_setAddressIsProperlySet() public {
    assertEq(
      _poolAddressProvider.getAddress(INCENTIVES_CONTROLLER_ADDRESS_ID),
      _incentivesController
    );
  }

  function test_proposalPayloadExecution() public {
    address emissionManagerBefore = RewardsController(_incentivesController).getEmissionManager();
    address implBefore = ProxyHelpers.getInitializableAdminUpgradeabilityProxyImplementation(
      vm,
      _incentivesController
    );

    _execute();

    address emissionManagerAfter = RewardsController(_incentivesController).getEmissionManager();
    address implAfter = ProxyHelpers.getInitializableAdminUpgradeabilityProxyImplementation(
      vm,
      _incentivesController
    );

    // implementation should change
    assertTrue(implBefore != implAfter, 'IMPL_UPDATE');
    // emissionManager should stay the same
    assertEq(emissionManagerBefore, emissionManagerAfter, 'EMISSION_MANAGER_UPDATE');
  }
}

abstract contract BaseTest is Base {
  UpgradeRewardsControllerPayload public payload;
  RewardsController public rewardsController;
  MockExecutor internal _aclAdmin;

  function _setUp(
    IPoolAddressesProvider poolAddressProvider,
    address incentivesController,
    address aclAdmin
  ) internal override {
    address emissionManager = RewardsController(incentivesController).getEmissionManager();
    rewardsController = new RewardsController(emissionManager);
    rewardsController.initialize(address(0));
    payload = new UpgradeRewardsControllerPayload(poolAddressProvider, rewardsController);
    MockExecutor mockExecutor = new MockExecutor();
    vm.etch(aclAdmin, address(mockExecutor).code);

    _poolAddressProvider = poolAddressProvider;
    _incentivesController = incentivesController;
    _aclAdmin = MockExecutor(aclAdmin);
  }

  function _execute() internal override {
    _aclAdmin.execute(address(payload));
  }
}

abstract contract BaseTestGuardian is Base {
  RewardsController public rewardsController;
  address internal _aclAdmin;

  function _setUp(
    IPoolAddressesProvider poolAddressProvider,
    address incentivesController,
    address aclAdmin
  ) internal override {
    address emissionManager = RewardsController(incentivesController).getEmissionManager();
    rewardsController = new RewardsController(emissionManager);
    rewardsController.initialize(address(0));

    _poolAddressProvider = poolAddressProvider;
    _incentivesController = incentivesController;
    _aclAdmin = aclAdmin;
  }

  function _execute() internal override {
    vm.startPrank(_aclAdmin);
    _poolAddressProvider.setAddressAsProxy(
      INCENTIVES_CONTROLLER_ADDRESS_ID,
      address(rewardsController)
    );
    vm.stopPrank();
  }
}
