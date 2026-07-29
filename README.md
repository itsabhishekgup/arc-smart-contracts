# Arc Storage Contract

A simple storage smart contract built with Solidity and Foundry on the Arc Testnet.

## Overview

This project demonstrates a basic Solidity smart contract that stores and retrieves a number on-chain.

Features:

- Store a uint256 value
- Update the stored value
- Read the current stored value
- Deploy using Foundry
- Tested on Arc Testnet

## Technology

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
├── .gitignore
└── README.md
## Smart Contract

### State Variable

Solidity (Ethereum)


uint256 public number;
### Functions

#### setNumber(uint256 _number)

Stores a new number.

#### getNumber()

Returns the stored number.

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
## Repository Security

The following files and folders are excluded from Git:

- .env
- broadcast/
- cache/
- out/

Private keys and wallet secrets should never be committed.

## Future Improvements

- Unit tests
- Events
- Ownership
- Access control
- Gas optimization

## Author

GitHub

https://github.com/itsabhishekgup

---

Built with Solidity and Foundry.