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

## Addresses

- [Polygon:RewardsController](https://polygonscan.com/address/0x723a9d120ed2cd90ac550d779375f6178bfd86e3#code)
- [Polygon:UpgradeRewardsControllerPayload](https://polygonscan.com/address/0x6f02253c80A041a773efa35c98D4bc14A0f6EF9e)
- [Avalanche:RewardsController](https://snowtrace.io/address/0x723A9d120Ed2CD90AC550d779375F6178BFD86E3#code)
- [Optimism:RewardsController](https://optimistic.etherscan.io/address/0x723A9d120Ed2CD90AC550d779375F6178BFD86E3#code)
- [Arbitrum:RewardsController](https://arbiscan.io/address/0x723a9d120ed2cd90ac550d779375f6178bfd86e3#code)
- [Fantom:RewardsController](https://ftmscan.com/address/0x723a9d120ed2cd90ac550d779375f6178bfd86e3#code)
- [Harmony:RewardsController](https://explorer.harmony.one/address/0x5f5c02875a8e9b5a26fbd09040abcfdeb2aa6711?activeTab=7) harmony has a different address as it not supported on the `create2` factory that we rely on as it's enforcing EIP-155, also verification does not work properly

## Deployment

This repository contains two scripts.

1. `PayloadDeployment.sol` which contains multiple scripts which allow deploying a payload or implementation for a specific network.
2. `ProposalDeployment.sol` which contains a deploy script that will create the onchainProposal for polygon.

For generating the calldata on a specific network you can run `make emit-calldata rewardControllerImpl=newImplAddress`.

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
