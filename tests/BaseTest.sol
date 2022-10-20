// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';
import {MockExecutor} from './MockExecutor.sol';

abstract contract BaseTest is Test {
  UpgradeRewardsControllerPayload public payload;
  MockExecutor internal _aclAdmin;
  IPoolAddressesProvider internal _poolAddressProvider;
  address internal _incentivesController;

  function _setUp(
    IPoolAddressesProvider poolAddressProvider,
    address incentivesController,
    address aclAdmin
  ) internal {
    payload = new UpgradeRewardsControllerPayload(
      poolAddressProvider,
      incentivesController
    );
    MockExecutor mockExecutor = new MockExecutor();
    vm.etch(aclAdmin, address(mockExecutor).code);

    _poolAddressProvider = poolAddressProvider;
    _incentivesController = incentivesController;
    _aclAdmin = MockExecutor(aclAdmin);
  }

  function _execute() internal {
    _aclAdmin.execute(address(payload));
  }

  function test_adminIsPoolAddressesProvider() public {
    assertEq(
      ProxyHelpers.getInitializableAdminUpgradeabilityProxyAdmin(
        vm,
        _incentivesController
      ),
      address(_poolAddressProvider)
    );
  }

  function test_setAddressIsProperlySet() public {
    assertEq(
      _poolAddressProvider.getAddress(
        payload.INCENTIVES_CONTROLLER_ADDRESS_ID()
      ),
      payload.INCENTIVES_CONTROLLER()
    );
  }

  function test_proposalPayloadExecution() public {
    _execute();
  }
}
