# Arc Storage Contract

A simple Storage smart contract built with Solidity and Foundry.

## Overview

This project demonstrates the basics of Solidity smart contract development on the Arc Testnet.

The contract allows users to:

- Store a number on-chain
- Update the stored number
- Read the current stored number

## Tech Stack

- Solidity
- Foundry
- Arc Testnet

## Project Structure

copy


arc-storage-contract/
├── src/
│   └── Storage.sol
├── script/
│   └── DeployStorage.s.sol
├── test/
│   └── HelloArchitect.t.sol
├── lib/
├── foundry.toml
└── README.md
## Smart Contract

### Storage.sol

State Variable

- uint256 public number

Functions

### setNumber(uint256 _number)

Updates the stored number.

### getNumber()

Returns the current stored number.

## Deployment

Network

- Arc Testnet

Contract Address

copy


0xB4515c287BA17aB346526574FA2c0E279396E4bd
## Build

Bash


forge build
## Deploy

Bash


forge script script/DeployStorage.s.sol:DeployStorage \
--rpc-url $RPC_URL \
--private-key $PRIVATE_KEY \
--broadcast
## Security

Sensitive files are excluded from Git tracking.

Ignored files include:

- .env
- broadcast/
- cache/
- out/

Never commit private keys or wallet secrets.

## Author

GitHub: https://github.com/itsabhishekgup