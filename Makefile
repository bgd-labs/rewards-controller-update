# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes --via-ir
test   :; forge test -vvv

# utils
download :; cast etherscan-source --chain ${chain} -d etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md

# Deploy payloads
deploy-polygon :;  forge script script/PayloadDeployment.s.sol:DeployPolygon --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-avalanche :;  forge script script/PayloadDeployment.s.sol:DeployAvalanche --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-optimism :;  forge script script/PayloadDeployment.s.sol:DeployOptimism --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-arbitrum :;  forge script script/PayloadDeployment.s.sol:DeployArbitrum --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-fantom :;  forge script script/PayloadDeployment.s.sol:DeployFantom --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-harmony :;  forge script script/PayloadDeployment.s.sol:DeployHarmony --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

# Deploy proposal
deploy-proposal :;  forge script script/ProposalDeployment.s.sol:ProposalDeployment --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

diff:
	@echo "downloading source from etherscan"
	@make download chain=${chain} address=${address}
	@make git-diff before='./etherscan/${chain}_${address}' after='./src/' out=${chain}_${address}

diff-all:
	@make diff chain=optimism address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=avalanche address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=polygon address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=arbitrum address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789
	@make diff chain=fantom address=0xaad324f7e4Dd50C6b105820f8a877eE2DCBFA789

