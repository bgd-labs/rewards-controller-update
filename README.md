# Rewards Controller Update <> Aave

This repository contains the proposal code to upgrade the RewardsController implementation to [3.0.1](https://github.com/aave/aave-v3-periphery/tree/feat/3.0.1). It contains a [generic payload](./src/contracts/UpgradeRewardsControllerPayload.sol) that can be used on all chains and be executed via governance or guardians.

## Addresses

- TBA

## Deployment

This repository contains two scripts.

1. `PayloadDeployment.sol` which contains multiple scripts which allow deploying a payload for a specific network.
2. `ProposalDeployment.sol` which contains a deploy script that will create the onchainProposals for all the networks controlled via governance(polygon, optimism).

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
