// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Polygon, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony, AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {RewardsController} from '@aave/periphery-v3/contracts/rewards/RewardsController.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {UpgradeRewardsControllerPayload} from '../src/contracts/UpgradeRewardsControllerPayload.sol';
import {MockExecutor} from './MockExecutor.sol';
import {BaseTest, BaseTestGuardian} from './BaseTest.sol';

/**
 * Testing payload
 */
contract ProposalTestPolygon is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 34550201);
    _setUp(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER,
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );
  }
}

contract ProposalTestAvalanche is BaseTestGuardian {
  address constant A_USDC = 0x625E7708f30cA75bfd92586e17077590C60eb4cD;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 21309814);
    _setUp(
      AaveV3Avalanche.POOL_ADDRESSES_PROVIDER,
      AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Avalanche.ACL_ADMIN
    );
  }

  // the test for correctness is in peripery repo, so just cehcking it exists
  function test_getAssetIndex() public {
    _execute();

    RewardsController controller = RewardsController(_incentivesController);

    (uint256 indexOld, uint256 indexNew) = controller.getAssetIndex(
      A_USDC,
      controller.getRewardsList()[0]
    );
    emit log_uint(indexNew);
    assertGt(indexNew, indexOld);
    assertGt(indexNew, 228060399236938); // onchain index on block 21309812
  }
}

contract ProposalTestOptimism is BaseTestGuardian {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 43267312);
    _setUp(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Optimism.ACL_ADMIN
    );
  }
}

contract ProposalTestArbitrum is BaseTestGuardian {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 41929141);
    _setUp(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Arbitrum.ACL_ADMIN
    );
  }
}

contract ProposalTestFantom is BaseTestGuardian {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('fantom'), 51560600);
    _setUp(
      AaveV3Fantom.POOL_ADDRESSES_PROVIDER,
      AaveV3Fantom.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Fantom.ACL_ADMIN
    );
  }
}

contract ProposalTestHarmony is BaseTestGuardian {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('harmony'), 32871646);
    _setUp(
      AaveV3Harmony.POOL_ADDRESSES_PROVIDER,
      AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Harmony.ACL_ADMIN
    );
  }
}
