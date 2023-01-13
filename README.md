# Rewards Controller Update <> Aave

This repository contains the proposal code to upgrade the RewardsController implementation to [3.0.1](https://github.com/aave/aave-v3-periphery/tree/feat/3.0.1). It contains a [generic payload](./src/contracts/UpgradeRewardsControllerPayload.sol) that can be used on all chains and be executed via governance or guardians.

The upgrade includes the following changes:

1. soften solidity versions to `^0.8.0` https://github.com/aave/aave-v3-periphery/pull/102
2. adding a getter to fetch the current index https://github.com/aave/aave-v3-periphery/pull/101
3. replacing totalSupply with totalScaledSupply on `setEmissionPerSecond` https://github.com/aave/aave-v3-periphery/pull/104
4. pumping revision from `1` to `2` https://github.com/aave/aave-v3-periphery/pull/107
5. fixing `getUserReward` to return correct rewards for users with 0 balance https://github.com/aave/aave-v3-periphery/pull/112
6. remove unnecessary `constructor` that sets state on a contract always used behind a proxy https://github.com/aave/aave-v3-periphery/pull/118
7. consistently uppercase license pragma `agpl`->`AGPL` https://github.com/aave/aave-v3-periphery/pull/120
8. improving documentation on various structs https://github.com/aave/aave-v3-periphery/pull/121
9. removing constructor of RewardsDistributor and RewardsController [here](https://github.com/aave/aave-v3-periphery/pull/118/files)

## Addresses

- [Polygon:RewardsController](https://polygonscan.com/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code)
- [Polygon:UpgradeRewardsControllerPayload](https://polygonscan.com/address/0xf50a080aC535e531EC33cC05b227E910De2fb1fA)
- [Avalanche:RewardsController](https://snowtrace.io/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code)
- [Optimism:RewardsController](https://optimistic.etherscan.io/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code)
- [Arbitrum:RewardsController](https://arbiscan.io/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code)
- [Fantom:RewardsController](https://ftmscan.com/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code) verification does not work properly
- [Harmony:RewardsController](https://explorer.harmony.one/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731?activeTab=7) verification does not work properly

## Deployment

This repository contains two scripts.

1. `PayloadDeployment.sol` which contains multiple scripts which allow deploying a payload or implementation for a specific network.
2. `ProposalDeployment.sol` which contains a deploy script that will create the onchainProposal for polygon.

For generating the calldata on a specific network you can run `make emit-calldata rewardControllerImpl=newImplAddress` which will yield `0x5dcc528c703c2c8634bed68d98c029c18f310e7f7ec0e5d6342c590190b3cb8b3ba545320000000000000000000000005f4d15d761528c57a5c30c43c1dab26fc5452731`for the impl `0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731`.

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for detailed instructions on how to install and use Foundry.
The template ships with sensible default so you can use default `foundry` commands without resorting to `MakeFile`.

### Setup

```sh
cp .env.example .env
forge install
```

### Test

```sh
forge test
```
