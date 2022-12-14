// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library DeployL1Proposal {
  function _deployL1Proposal(address polygonPayload, bytes32 ipfsHash)
    internal
    returns (uint256 proposalId)
  {
    require(polygonPayload != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](1);
    targets[0] = AaveGovernanceV2.CROSSCHAIN_FORWARDER_POLYGON;

    uint256[] memory values = new uint256[](1);
    values[0] = 0;

    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';

    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(polygonPayload);

    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    return
      AaveGovernanceV2.GOV.create(
        IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
        targets,
        values,
        signatures,
        calldatas,
        withDelegatecalls,
        ipfsHash
      );
  }
}

// TODO: enter correct addresses
contract CreateProposal is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1Proposal._deployL1Proposal(0xf50a080aC535e531EC33cC05b227E910De2fb1fA, bytes32(0));
    vm.stopBroadcast();
  }
}
