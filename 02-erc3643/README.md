# ERC-3643 Demo — CompliantVuy

A minimal ERC-20 token with built-in transfer compliance (`CompliantVuy`, symbol `VUYC`) deployed to a local [Anvil](https://book.getfoundry.sh/anvil/) chain using [Foundry](https://book.getfoundry.sh/).

The deployer (Issuer) receives the entire initial supply of 1000 VUYC on deployment. Transfers to non-whitelisted addresses are blocked — a recipient must first be registered via `registerIdentity` before they can receive tokens.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (`forge`, `cast`, `anvil`)
- `jq`

## Quick start

```sh
# Terminal 1 — start local node
make node

# Terminal 2 — deploy and interact
make deploy
make balance-issuer
make register-alice
make transfer-alice
make balance-alice
make transfer-mallory   # fails: Mallory is not whitelisted
```

## Make targets

| Target              | Description                                                        |
|---------------------|--------------------------------------------------------------------|
| `info`              | Print configured accounts and keys                                 |
| `node`              | Start a local Anvil node on `localhost:8545`                       |
| `deploy`            | Deploy `CompliantVuy` and save its address to `.deployed-address`  |
| `balance-issuer`    | Query Issuer's VUYC balance                                        |
| `balance-alice`     | Query Alice's VUYC balance                                         |
| `balance-mallory`   | Query Mallory's VUYC balance                                       |
| `register-alice`    | Whitelist Alice in the identity registry                           |
| `transfer-alice`    | Transfer 10 VUYC from Issuer to Alice                              |
| `transfer-mallory`  | Transfer 10 VUYC from Issuer to Mallory (reverts — not whitelisted)|
| `transfer-between`  | Transfer 2 VUYC from Alice to Mallory (reverts — not whitelisted)  |

Targets that interact with the contract require `make deploy` to have been run first.

## Accounts (Anvil defaults)

| Name      | Address                                      |
|-----------|----------------------------------------------|
| Issuer  * | `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` |
| Alice     | `0x70997970C51812dc3A010C7d01b50e0d17dc79C8` |
| Mallory   | `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC` |

\* Issuer deploys the contract, receives the initial supply, and manages the identity registry.
