# ERC-20 Demo — VuyCoin

A minimal ERC-20 token (`VuyCoin`, symbol `VUY`) deployed to a local [Anvil](https://book.getfoundry.sh/anvil/) chain using [Foundry](https://book.getfoundry.sh/).

The deployer (Alice) receives the entire initial supply of 1000 VUY on deployment.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (`forge`, `cast`, `anvil`)
- `jq`

## Quick start

```sh
# Terminal 1 — start local node
make node

# Terminal 2 — deploy and interact
make deploy
make balance-alice
make transfer
make balance-bob
```

## Make targets

| Target          | Description                                              |
|-----------------|----------------------------------------------------------|
| `info`          | Print configured accounts and keys                       |
| `node`          | Start a local Anvil node on `localhost:8545`             |
| `deploy`        | Deploy `VuyCoin` and save its address to `.deployed-address` |
| `balance-alice` | Query Alice's VUY balance                                |
| `balance-bob`   | Query Bob's VUY balance                                  |
| `transfer`      | Transfer 10 VUY from Alice to Bob                        |

Targets that interact with the contract require `make deploy` to have been run first.

## Accounts (Anvil defaults)

| Name    | Address                                      |
|---------|----------------------------------------------|
| Alice * | `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` |
| Bob     | `0x70997970C51812dc3A010C7d01b50e0d17dc79C8` |

\* Alice deploys the contract and receives the initial supply.
