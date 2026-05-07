ANVIL ?= anvil
ANVIL_FLAGS =

FORGE ?= forge
FORGE_FLAGS =

CAST ?= cast
CAST_FLAGS =

JQ ?= jq
JQ_FLAGS =

CONTRACT_NAME = CompliantVuy
DEPLOY_SCRIPT = script/${CONTRACT_NAME}.s.sol
RPC_URL = localhost:8545

PK_ISSUER = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
ISSUER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

PK_ALICE = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
ALICE = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

PK_MALLORY = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a
MALLORY = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

BROADCAST_JSON = broadcast/${CONTRACT_NAME}.s.sol/31337/run-latest.json
CONTRACT_ADDRESS_FILE = .deployed-address


default:
	@echo 'Please choose a target explicitly from the following:'
	@echo '  info             - Print configuration information'
	@echo '  node             - Start as local Anvil node'
	@echo '  deploy           - Deploy the contract to the local node'
	@echo "  balance-issuer   - Query issuer's balance"
	@echo "  balance-alice    - Query Alice's balance"
	@echo "  balance-mallory  - Query Mallory's balance"
	@echo '  transfer-alice   - Transfer 10 tokens from issuer to Alice'
	@echo '  transfer-mallory - Transfer 10 tokens from issuer to Mallory'
	@echo '  transfer-between - Transfer 2 tokens from Alice to Mallory'
	@echo '  register-alice   - Whitelist alice'

info:
	@echo '=== Accounts ==='
	@echo 'ISSUER @ ${ISSUER} (private key: ${PK_ISSUER})'
	@echo 'ALICE @ ${ALICE} (private key: ${PK_ALICE})'
	@echo 'MALLORy @ ${MALLORY} (private key: ${PK_MALLORY})'


node:
	${ANVIL} ${ANVIL_FLAGS}

deploy:
	${FORGE} ${FORGE_FLAGS} script ${DEPLOY_SCRIPT} \
	    --private-key ${PK_ISSUER} \
	    --broadcast \
	    --rpc-url ${RPC_URL}
	${JQ} ${JQ_FLAGS} \
	    -r 'first(.transactions[] | select(.contractName == "${CONTRACT_NAME}") | .contractAddress)' \
	    ${BROADCAST_JSON} >${CONTRACT_ADDRESS_FILE}
	@echo "Deployed ${CONTRACT_NAME} at $$(cat ${CONTRACT_ADDRESS_FILE})"


balance-issuer: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'balanceOf(address)(uint)' \
	    ${ISSUER}

balance-alice: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'balanceOf(address)(uint)' \
	    ${ALICE}

balance-mallory: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    call $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'balanceOf(address)(uint)' \
	    ${MALLORY}

register-alice: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'registerIdentity(address)' \
	    ${ALICE} \
	    --private-key ${PK_ISSUER}

transfer-alice: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'transfer(address,uint256)' \
	    ${ALICE} 10 \
	    --private-key ${PK_ISSUER}

transfer-mallory: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'transfer(address,uint256)' \
	    ${MALLORY} 10 \
	    --private-key ${PK_ISSUER}

transfer-between: ${CONTRACT_ADDRESS_FILE}
	${CAST} ${CAST_FLAGS} \
	    send $$(cat ${CONTRACT_ADDRESS_FILE}) \
	    'transfer(address,uint256)' \
	    ${MALLORY} 2 \
	    --private-key ${PK_ALICE}


${CONTRACT_ADDRESS_FILE}:
	@echo 'Please deploy the contract first using the deploy target' >&2
	@false

.PHONY: default node deploy
.PHONY: balance-issuer balance-alice balance-mallory
.PHONY: transfer-alice transfer-mallory transfer-between
