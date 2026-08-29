# Arc Smart Contracts

A growing collection of Solidity smart contracts built, tested, and deployed on **Arc Testnet** using **Foundry**.

This repository is part of my hands-on Web3 builder journey. Each project follows a repeatable workflow:

**Build → Test → Format → Deploy → Document → Commit**

---

## 🚀 Overview

The goal of this repository is to build practical smart-contract experience on Arc through multiple focused projects covering:

- Solidity development
- Foundry-based testing
- Deployment scripts
- Arc Testnet deployments
- Git/GitHub version control
- Technical documentation

The repository is intentionally evolving. New contracts and experiments will be added as the learning journey continues.

---

## 🧩 Current Projects

| Project | What it demonstrates | Status |
|---|---|---|
| **Storage** | State variables, setters and getters | ✅ Tested & Deployed |
| **Greeting** | State updates, reads and deployment workflow | ✅ Tested & Deployed |
| **MyToken** | Custom ERC-20-like token mechanics, mint, burn and transfer | ✅ Tested & Deployed |
| **BuilderNFT** | NFT-style ownership, minting, token URI and transfers | ✅ Tested & Deployed |
| **ArcEscrow** | Token-based escrow with deposit, release and refund flow | ✅ Tested & Deployed |

---

# 📦 Smart Contracts

## 1. Storage Contract

A beginner-friendly contract used to learn Solidity state management fundamentals.

### Features

- Store a number
- Update the stored number
- Read the stored number

### Status

- ✅ Developed
- ✅ Tested
- ✅ Built with Foundry
- ✅ Deployed on Arc Testnet

---

## 2. Greeting Contract

A simple contract for storing and updating a greeting message.

### Features

- Store a greeting
- Read the current greeting
- Update the greeting

### Contract Address

```text
0xF19155F26d26331C31C3D5B8E6bee68Aff1f9B2c5230
```

### Status

- ✅ Developed
- ✅ Tested
- ✅ Built
- ✅ Deployed on Arc Testnet

---

## 3. MyToken

A lightweight **ERC-20-like learning implementation** written directly in Solidity.

> This contract is intentionally educational and is not presented as a production-ready ERC-20 implementation.

### Features

- Token name and symbol
- 18 decimals
- Initial supply
- Balance tracking
- Token transfers
- Owner-only minting
- Token burning
- Transfer events

### Token Details

```text
Name:     Builder Token
Symbol:   BLD
Decimals: 18
```

### Contract Address

```text
0xd879C42148B85D33D85ea431a4015d41a3847185
```

### Status

- ✅ Developed
- ✅ Tests passed
- ✅ Built
- ✅ Deployed on Arc Testnet

---

## 4. BuilderNFT

A lightweight **ERC-721-style learning contract** for understanding NFT fundamentals.

> This is a custom educational implementation and is not intended to claim full ERC-721 standard compliance.

### Features

- NFT minting
- Token ownership tracking
- Token URI storage
- NFT transfers
- Owner-only minting
- Balance tracking
- Incrementing token IDs

### Contract Address

```text
0x527472c3dFA202aEfF206DC213AD9c6673E4345C
```

### Status

- ✅ Developed
- ✅ Tests passed
- ✅ Built
- ✅ Deployed on Arc Testnet

---

# 5. ArcEscrow

A practical token-based escrow contract designed to demonstrate how funds can be held by a smart contract and released or refunded according to predefined rules.

The contract uses three roles:

- **Depositor** — funds the escrow
- **Beneficiary** — receives funds on release
- **Arbiter** — can authorize a refund

### Escrow Flow

```text
Depositor
   │
   │ deposit()
   ▼
┌───────────────┐
│   ArcEscrow   │
│    Locked     │
└───────────────┘
   │         │
   │         │
release()   refund()
   │         │
   ▼         ▼
Beneficiary  Depositor
```

### Core Features

- ERC-20 token based deposits
- Single-deposit flow
- Beneficiary-controlled release
- Arbiter-controlled refund
- Deposit/release/refund events
- Role-based access checks
- Zero-address validation
- Duplicate-deposit protection
- Explicit token-transfer success checks

### Contract Address

```text
0xdB8A5392d3F5D6a28BDa2A9C09FcB20053a0575C
```

### Arc Testnet Configuration

```text
Network:   Arc Testnet
Chain ID:  5042002
RPC:       https://rpc.testnet.arc.network
USDC:      0x3600000000000000000000000000000000000000
```

### Deployment Status

- ✅ Contract developed
- ✅ Foundry tests passed
- ✅ Formatting/build completed
- ✅ Deployment simulation completed successfully
- ✅ Deployed on Arc Testnet
- ✅ On-chain execution completed successfully

### Deployment Gas

The successful deployment used approximately:

```text
0.021727503 USDC
```

---

# 🧪 Testing

This repository uses **Foundry** for compilation, formatting, and automated testing.

Run the full test suite:

```bash
forge test
```

Run tests with detailed traces:

```bash
forge test -vv
```

Format Solidity files:

```bash
forge fmt
```

Check formatting without modifying files:

```bash
forge fmt --check
```

Build the contracts:

```bash
forge build
```

---

# 🛠️ Project Structure

```text
arc-smart-contracts/
├── src/
│   ├── Storage.sol
│   ├── Greeting.sol
│   ├── MyToken.sol
│   ├── BuilderNFT.sol
│   └── ArcEscrow.sol
│
├── script/
│   ├── DeployStorage.s.sol
│   ├── DeployGreeting.s.sol
│   ├── DeployMyToken.s.sol
│   ├── DeployBuilderNFT.s.sol
│   └── DeployArcEscrow.s.sol
│
├── test/
│   ├── HelloArchitect.t.sol
│   ├── Greeting.t.sol
│   ├── MyToken.t.sol
│   ├── BuilderNFT.t.sol
│   └── ArcEscrow.t.sol
│
├── lib/
├── foundry.toml
├── .gitignore
└── README.md
```

---

# ⚙️ Local Development

## 1. Clone

```bash
git clone https://github.com/itsabhishekgup/arc-smart-contracts.git
cd arc-smart-contracts
```

## 2. Install Dependencies

```bash
forge install
```

## 3. Build

```bash
forge build
```

## 4. Run Tests

```bash
forge test
```

---

# 🌐 Arc Testnet

This repository currently targets **Arc Testnet**.

```text
Network:   Arc Testnet
Chain ID:  5042002
RPC URL:   https://rpc.testnet.arc.network
Explorer:  https://testnet.arcscan.app
```

---

# 🔐 Environment Variables

Deployment credentials remain local and must never be committed to GitHub.

Example:

```env
ARC_TESTNET_RPC_URL=https://rpc.testnet.arc.network
PRIVATE_KEY=YOUR_PRIVATE_KEY
```

ArcEscrow deployment configuration:

```env
ARC_USDC_ADDRESS=0x3600000000000000000000000000000000000000
ESCROW_BENEFICIARY=YOUR_PUBLIC_WALLET_ADDRESS
ESCROW_ARBITER=YOUR_PUBLIC_WALLET_ADDRESS
```

### Security Rule

**Never commit `PRIVATE_KEY` to GitHub.**

Keep `.env` local and make sure it is covered by `.gitignore`.

---

# 🚀 Deployment Workflow

The general Foundry deployment workflow used in this repository is:

```text
Write Contract
      ↓
Write Tests
      ↓
forge fmt
      ↓
forge test
      ↓
forge build
      ↓
Simulate Deployment
      ↓
Broadcast to Arc Testnet
      ↓
Record Contract Address
      ↓
Update README
      ↓
Commit & Push
```

Example ArcEscrow deployment:

```bash
forge script script/DeployArcEscrow.s.sol:DeployArcEscrow   --rpc-url "$ARC_TESTNET_RPC_URL"   --private-key "$PRIVATE_KEY"   --broadcast
```

---

# 📈 Learning Progress

### Completed

- ✅ Storage Contract
- ✅ Greeting Contract
- ✅ MyToken
- ✅ BuilderNFT
- ✅ ArcEscrow
- ✅ Foundry testing workflow
- ✅ Foundry formatting workflow
- ✅ Arc Testnet deployments
- ✅ GitHub version control

### Next Ideas

- ⏳ Counter Contract
- ⏳ Vault Contract
- ⏳ Voting Contract
- ⏳ MultiSig Wallet
- ⏳ More advanced token standards
- ⏳ Frontend integrations
- ⏳ End-to-end dApp workflows

---

# 🎯 Builder Goals

The long-term goal of this repository is to move from Solidity fundamentals toward practical, production-oriented Web3 development.

### Focus Areas

- Strengthen Solidity fundamentals
- Learn smart-contract security patterns
- Build practical on-chain applications
- Improve Foundry testing skills
- Deploy consistently on Arc
- Document every meaningful build
- Grow a public builder portfolio
- Connect contracts with usable frontend applications

---

# 📚 Development Philosophy

I am building this repository incrementally rather than trying to create everything at once.

Each project is intended to answer a practical question:

> **Can I build it, test it, deploy it, and explain how it works?**

That approach turns individual experiments into a visible development track.

---

# 👤 Author

**Abhishek Gupta**

### GitHub

https://github.com/itsabhishekgup

### X / Twitter

https://x.com/itsabhishekgup

### LinkedIn

https://www.linkedin.com/in/abhishek-gupta-882352301/

---

# ⭐ Repository Status

This repository is actively maintained as I continue building and learning on **Arc Testnet**.

New contracts, tests, deployment scripts, and experiments will be added as the project grows.

**Built with Solidity + Foundry + Arc Testnet.**
