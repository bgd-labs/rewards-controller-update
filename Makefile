# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes --via-ir
test   :; forge test -vvv

# utils
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md

# Deploy payloads
deploy-polygon :; forge script scripts/PayloadDeployment.s.sol:DeployPolygon --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-avalanche :; forge script scripts/PayloadDeployment.s.sol:DeployAvalanche --rpc-url avalanche --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-optimism :; forge script scripts/PayloadDeployment.s.sol:DeployOptimism --rpc-url optimism --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arbitrum :; forge script scripts/PayloadDeployment.s.sol:DeployArbitrum --rpc-url arbitrum --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-fantom :; forge script scripts/PayloadDeployment.s.sol:DeployFantom --rpc-url fantom --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-harmony :; forge script scripts/PayloadDeployment.s.sol:DeployHarmony --rpc-url harmony --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

emit-calldata :; forge script scripts/PayloadDeployment.s.sol:EmitCalldata -vvvv --sig "run(address)" -- ${rewardControllerImpl}

# Deploy proposal
create-proposal :; forge script scripts/CreateProposal.s.sol:CreateProposal --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

diff:
	@echo "downloading source from etherscan"
# @make download chain=${chain} address=${address}
	forge flatten ./src/etherscan/${chain}_${address}/RewardsController/@aave/periphery-v3/contracts/rewards/RewardsController.sol --output ./src/etherscan/${chain}_${address}/Flattened.sol
	@make git-diff before='./src/etherscan/${chain}_${address}/Flattened.sol' after='./src/Flattened.sol' out=${chain}_${address}

diff-all:
	forge flatten ./lib/aave-v3-periphery/contracts/rewards/RewardsController.sol  --output ./src/Flattened.sol
	@make diff chain=optimism address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=avalanche address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=polygon address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=arbitrum address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=fantom address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	rm ./src/Flattened.sol
