ANVIL ?= anvil
ANVIL_FLAGS =

FORGE ?= forge
FORGE_FLAGS =

CAST ?= cast
CAST_FLAGS =

JQ ?= jq
JQ_FLAGS =

CONTRACT_NAME = AMM
DEPLOY_SCRIPT = script/${CONTRACT_NAME}.s.sol
RPC_URL = localhost:8545

PK = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
ACCOUNT = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

BROADCAST_JSON = broadcast/${CONTRACT_NAME}.s.sol/31337/run-latest.json
CONTRACT_ADDRESS_FILE = .deployed-address


default:
	@echo 'Please choose a target explicitly from the following:'
	@echo '  info        - Print configuration information'
	@echo '  node        - Start as local Anvil node'
	@echo '  deploy      - Deploy the contract to the local node'
	@echo '  swap        - Execute a token swap of 1 token A for B'
	@echo '  swap-large  - Execute a token swap of 80 token A for B'

info: ${CONTRACT_ADDRESS_FILE}
	@echo '=== Accounts ==='
	@echo 'ACCOUNT @ ${ACCOUNT} (private key: ${PK})'
	@echo
	@echo '=== Tokens ==='
	@echo "TOKEN A @ "$$( \
	    ${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    "tokenA()(address)" \
	)""
	@echo "TOKEN B @ "$$( \
	    ${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    "tokenB()(address)" \
	)""


node:
	${ANVIL} ${ANVIL_FLAGS}

deploy:
	${FORGE} ${FORGE_FLAGS} script ${DEPLOY_SCRIPT} \
	    --private-key ${PK} \
	    --broadcast \
	    --rpc-url ${RPC_URL}
	${JQ} ${JQ_FLAGS} \
	    -r 'first(.transactions[] | select(.contractName == "${CONTRACT_NAME}") | .contractAddress)' \
	    ${BROADCAST_JSON} >${CONTRACT_ADDRESS_FILE}
	@echo "Deployed ${CONTRACT_NAME} at $$(cat ${CONTRACT_ADDRESS_FILE})"


reserves: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'reserveA()(uint)'
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'reserveB()(uint)'


swap: ${CONTRACT_ADDRESS_FILE}
	@echo 'Swapping 1 token A for token B'
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'swap(uint256,address)' \
	    1 "$$( \
		${CAST} ${CAST_FLAGS} \
		call $$(cat ${CONTRACT_ADDRESS_FILE}) \
		'tokenA()(address)' \
	    )" \
	    --private-key ${PK}

swap-large: ${CONTRACT_ADDRESS_FILE}
	@echo 'Swapping 80 token A for token B'
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'swap(uint256,address)' \
	    80 "$$( \
		${CAST} ${CAST_FLAGS} \
		call $$(cat ${CONTRACT_ADDRESS_FILE}) \
		'tokenA()(address)' \
	    )" \
	    --private-key ${PK}


${CONTRACT_ADDRESS_FILE}:
	@echo 'Please deploy the contract first using the deploy target' >&2
	@false

.PHONY: default node deploy reserves swap swap-large
