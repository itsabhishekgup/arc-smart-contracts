# Arc Smart Contracts

A collection of smart contracts built on Arc Testnet using Solidity and Foundry as part of my Web3 builder journey.

---

## About

This repository documents my progress as I learn and build smart contracts on Arc Testnet. Every project includes source code, deployment scripts, tests, and GitHub commits to showcase consistent development.

My goal is to become a professional smart contract developer by building practical Web3 applications and improving with every project.

---

## Tech Stack

- Solidity
- Foundry
- Arc Testnet
- Git
- GitHub

---

# Smart Contracts

## ✅ Storage Contract

### Features

- Store a number
- Update the stored number
- Read the stored number

Status:

- ✅ Tested
- ✅ Built
- ✅ Deployed on Arc Testnet

---

## ✅ Greeting Contract

### Features

- Store a greeting message
- Read the greeting
- Update the greeting

Status:

- ✅ Tested
- ✅ Built
- ✅ Deployed on Arc Testnet

Contract Address
```
## 0xF19155F26d26331C31C3D5B8E6bee68Aff1f9B2c5230
```
---
# 🪙 MyToken Contract

A simple ERC20-like token built using Solidity and deployed on Arc Testnet.

## Features

- Mint initial supply
- Transfer tokens
- Mint new tokens (Owner only)
- Burn tokens
- Balance tracking

## Tech Stack

- Solidity ^0.8.20
- Foundry
- Arc Testnet

## Status

- ✅ Contract Developed
- ✅ Tests Passed
- ✅ Deployed on Arc Testnet

## Contract Address
```text
0xd879C42148B85D33D85ea431a4015d41a3847185
```
## 📁 Project Structure
```
arc-smart-contracts/
├── src/
│   ├── Storage.sol
│   └── Greeting.sol
│
├── script/
│   ├── DeployStorage.s.sol
│   └── DeployGreeting.s.sol
│
├── test/
│   ├── HelloArchitect.t.sol
│   └── Greeting.t.sol
│
├── README.md
└── foundry.toml
```
---

# Run Locally

Clone the repository

git clone https://github.com/itsabhishekgup/arc-smart-contracts.git
Enter the project

cd arc-smart-contracts
Install dependencies

forge install
Run tests

forge test
Build contracts

forge build
Deploy

forge create src/Greeting.sol:Greeting \
--rpc-url $ARC_TESTNET_RPC_URL \
--private-key $PRIVATE_KEY \
--broadcast

---

# Learning Progress

Completed

- ✅ Storage Contract
- ✅ Greeting Contract

Coming Next

- ⏳ Counter Contract
- ⏳ Escrow Contract
- ⏳ Vault Contract
- ⏳ ERC20 Token
- ⏳ ERC721 NFT
- ⏳ Lottery
- ⏳ MultiSig Wallet
- ⏳ Voting Contract

---

# Goals

- Learn Solidity fundamentals
- Build production-style smart contracts
- Master Foundry workflow
- Deploy contracts on Arc Testnet
- Maintain a professional GitHub portfolio

---

# Author

Abhishek Gupta

GitHub

https://github.com/itsabhishekgup

X (Twitter)

https://x.com/itsabhishekgup

LinkedIn

https://www.linkedin.com/in/abhishek-gupta-882352301/

---

⭐ This repository is actively maintained as I continue building and learning on Arc Testnet.
