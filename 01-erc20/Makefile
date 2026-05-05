ANVIL ?= anvil
ANVIL_FLAGS =

FORGE ?= forge
FORGE_FLAGS =

CAST ?= cast
CAST_FLAGS =

JQ ?= jq
JQ_FLAGS =

CONTRACT_NAME = VuyCoin
DEPLOY_SCRIPT = script/${CONTRACT_NAME}.s.sol
RPC_URL = localhost:8545

PK_ALICE = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
ALICE = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

PK_BOB = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
BOB = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

BROADCAST_JSON = broadcast/${CONTRACT_NAME}.s.sol/31337/run-latest.json
CONTRACT_ADDRESS_FILE = .deployed-address


default:
	@echo 'Please choose a target explicitly from the following:'
	@echo '  info           - Print configuration information'
	@echo '  node           - Start as local Anvil node'
	@echo '  deploy         - Deploy the contract to the local node'
	@echo "  balance-alice  - Query Alice's balance"
	@echo "  balance-bob    - Query Bob's balance"
	@echo '  transfer       - Transfer 10 tokens from Alice to Bob'

info:
	@echo '=== Accounts ==='
	@echo 'ALICE* @ ${ALICE} (private key: ${PK_ALICE})'
	@echo 'BOB @ ${BOB} (private key: ${PK_BOB})'


node:
	${ANVIL} ${ANVIL_FLAGS}

deploy:
	${FORGE} ${FORGE_FLAGS} script ${DEPLOY_SCRIPT} \
	    --private-key ${PK_ALICE} \
	    --broadcast \
	    --rpc-url ${RPC_URL}
	${JQ} ${JQ_FLAGS} \
	    -r 'first(.transactions[] | select(.contractName == "${CONTRACT_NAME}") | .contractAddress)' \
	    ${BROADCAST_JSON} >${CONTRACT_ADDRESS_FILE}
	@echo "Deployed ${CONTRACT_NAME} at $$(cat ${CONTRACT_ADDRESS_FILE})"


balance-alice: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'balanceOf(address)(uint)' \
	    ${ALICE}

balance-bob: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'balanceOf(address)(uint)' \
	    ${BOB}

transfer: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'transfer(address,uint256)' \
	    ${BOB} 10 \
	    --private-key ${PK_ALICE}


${CONTRACT_ADDRESS_FILE}:
	@echo 'Please deploy the contract first using the deploy target' >&2
	@false

.PHONY: default node deploy balance-alice balance-bob transfer
