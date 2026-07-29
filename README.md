# Arc Storage Contract

My first Solidity smart contract built on Arc Testnet using Foundry.

## About

Today I built a simple Storage contract as part of my Solidity learning journey.

This project can:

- Store a number
- Update the number
- Read the stored number

## What I did today

- Created my first Storage smart contract
- Wrote setter and getter functions
- Compiled the contract using Foundry
- Created a deployment script
- Successfully deployed it on Arc Testnet
- Learned how deployment works
- Uploaded the project to GitHub
- Secured the repository by ignoring .env and other sensitive files

## Files

- `src/Storage.sol` – Smart contract
- `script/DeployStorage.s.sol` – Deployment script
- `test/HelloArchitect.t.sol` – Test file

## Contract Address

Arc Testnet

0xB4515c287BA17aB346526574FA2c0E279396E4bd

## Commands

Build

```Bash
forge build
```
Deploy

```Bash
forge script script/DeployStorage.s.sol:DeployStorage \
--rpc-url $RPC_URL \
--private-key $PRIVATE_KEY \
--broadcast
```
## Next Goal

- Learn events
- Write better tests
- Build a Counter contract
- Build a Todo contract

---

This project is part of my Web3 and Solidity learning journey.