# AMM Demo — Constant-Product Automated Market Maker

A minimal constant-product AMM (`AMM`) paired with a generic mintable ERC-20 (`Token`), deployed to a local [Anvil](https://book.getfoundry.sh/anvil/) chain using [Foundry](https://book.getfoundry.sh/).

The deploy script creates two tokens (`Token A / TKNA` and `Token B / TKNB`), mints 1 000 000 of each to the deployer, and seeds the AMM with an initial liquidity of 100 TKNA and 200 000 TKNB (ratio 1 TKNA ≈ 2000 TKNB).

The AMM implements the constant-product formula **x · y = k** (no fees).

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (`forge`, `cast`, `anvil`)
- `jq`

## Quick start

```sh
# Terminal 1 — start local node
make node

# Terminal 2 — deploy and interact
make deploy
make reserves
make swap
make reserves
make swap-large
make reserves
```

## Make targets

| Target       | Description                                                         |
|--------------|---------------------------------------------------------------------|
| `info`       | Print configured account and token/AMM addresses                    |
| `node`       | Start a local Anvil node on `localhost:8545`                        |
| `deploy`     | Deploy tokens and AMM; save AMM address to `.deployed-address`      |
| `reserves`   | Query current `reserveA` and `reserveB` of the AMM                 |
| `swap`       | Swap 1 TKNA for TKNB (small swap, minimal price impact)             |
| `swap-large` | Swap 80 TKNA for TKNB (large swap, significant price impact)        |

Targets that interact with the contract require `make deploy` to have been run first.

## Account (Anvil default)

| Address                                      | Private key                                                          |
|----------------------------------------------|----------------------------------------------------------------------|
| `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` | `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` |

This account deploys all contracts, holds the initial token supply, and executes swaps.
