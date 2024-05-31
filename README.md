# Stylus workshop - Update Proxy from Solidity to Rust

This repo contains an example of a Proxy written in Solidity that updates its logic contract from an ERC-20 Solidity contract to an ERC-20 Rust contract.

The Proxy contract is based on the [TransparentUpgradableProxy](https://docs.openzeppelin.com/contracts/4.x/api/proxy#TransparentUpgradeableProxy) implementation of OpenZeppelin.

Note that instead of using the upgradeable ERC-20 contract, here we use a regular ERC-20 contract that is Initializable. We do this to simplify the storage layout of the Proxy contract, and have the ERC-20 state variables start at slot 0.

## Getting started

Follow the instructions in the [Stylus quickstart](https://docs.arbitrum.io/stylus/stylus-quickstart) to configure your development environment.

You'll also need [Foundry](https://github.com/foundry-rs/foundry) to build and deploy the Proxy and first ERC-20 contract.

## Project structure

Clone the project

```sh
git clone https://github.com/OffchainLabs/stylus-workshop-proxy.git
cd stylus-workshop-proxy
```

There are four directories inside:

- **proxy**: contains the Foundry project for the Proxy
- **erc20-sol**: contains the Foundry project for the first ERC-20 contract
- **erc20-rust**: contains the Stylus project for the updated ERC-20 contract
- **scripts**: contains scripts to deploy and update the logic contract of the Proxy, as well as others to test the updated ERC-20 contract

## Deploy your contracts

Rust and Solidity contracts are built and deployed differently.

### Rust contracts

For Rust projects, access the project folder and build and deploy the contract using the `cargo stylus` tool. Following is an example for the ERC-20 contract.

Access the `erc20-rust` folder

```sh
cd erc20-rust
```

Run the check tool

```sh
cargo stylus check
```

Deploy the contract

```sh
cargo stylus deploy --private-key 0x<your private key>
```

Note that it's generally better to use `--private-key-path` for security reasons.

See `cargo stylus deploy --help` for more information.

### Solidity contract

Access the `erc20-sol` folder

```sh
cd erc20-sol
```

Build the project

```sh
forge build
```

Deploy it

```sh
forge create --rpc-url https://stylusv2.arbitrum.io/rpc --private-key 0x<your private key> src/MyToken.sol:MyToken
```

See `forge create --help` for more information.

## Test script

The `scripts` folder contains several scripts that make individual calls to perform the most important actions:

1. [./scripts/deploy.sh](./scripts/deploy.sh) to deploy the Proxy and ERC-20 Solidity contract
2. [./scripts/updateLogic.sh](./scripts/updateLogic.sh) to update the logic contract of the Proxy, to the ERC-20 Rust contract
3. [./scripts/mintTokens.sh](./scripts/mintTokens.sh) to mint some ERC-20 tokens
4. [./scripts/getBalance.sh](./scripts/getBalance.sh) to obtain the balance of the minter
5. [./scripts/getTokenInformation.sh](./scripts/getTokenInformation.sh) to get the name, symbol and decimals of the token

Remember to set the environment variables in an `.env` file.

## How to run a local Stylus dev node

Instructions to setup a local Stylus dev node can be found [here](https://docs.arbitrum.io/stylus/how-tos/local-stylus-dev-node).

## How to get ETH for the Stylus testnet

The Stylus testnet is an L3 chain that settles to Arbitrum Sepolia. The usual way of obtaining ETH is to bridge it from Arbitrum Sepolia through the [Arbitrum Bridge](https://bridge.arbitrum.io/?destinationChain=stylus-testnet&sourceChain=arbitrum-sepolia). You can find a list of Arbitrum Sepolia faucets [here](https://docs.arbitrum.io/stylus/reference/testnet-information#faucets).

## Useful resources

- [Stylus quickstart](https://docs.arbitrum.io/stylus/stylus-quickstart)
- [Stylus by example](https://arbitrum-stylus-by-example.vercel.app/)
- [Awesome Stylus](https://github.com/OffchainLabs/awesome-stylus)
- [Counter program](https://github.com/OffchainLabs/stylus-workshop-counter)
- [Interactions between Rust and Solidity](https://github.com/OffchainLabs/stylus-workshop-rust-solidity/)
- [Telegram group](https://t.me/arbitrum_stylus)
- [Discord channel](https://discord.com/channels/585084330037084172/1146789176939909251)

## Stylus reference links

- [Stylus documentation](https://docs.arbitrum.io/stylus/stylus-gentle-introduction)
- [Stylus SDK](https://github.com/OffchainLabs/stylus-sdk-rs)
- [Cargo Stylus](https://github.com/OffchainLabs/cargo-stylus)

## Disclaimer

This code has **not** been audited and should **not** be used in a production environment.