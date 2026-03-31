<div align="center">

<br/>

# 💸 ERC-20 Tax Token

### Automatic transfer fee — every transaction funds the treasury.

An ERC-20 token that charges a configurable percentage on every transfer,
automatically routing fees to a designated treasury wallet.

<br/>

[![Solidity](https://img.shields.io/badge/Solidity-0.8.28-363636?style=for-the-badge&logo=solidity&logoColor=white)](https://soliditylang.org/)
[![Hardhat](https://img.shields.io/badge/Hardhat-3.x-f7df1e?style=for-the-badge)](https://hardhat.org/)
[![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-5.x-4e5ee4?style=for-the-badge&logo=openzeppelin&logoColor=white)](https://openzeppelin.com/)
[![Tests](https://img.shields.io/badge/Tests-7%2F7%20passing-brightgreen?style=for-the-badge)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-c792ea?style=for-the-badge)](LICENSE)

<br/>

> Part of the [Solidity Portfolio](https://github.com/HEO-80/solidity-portfolio) by HEO-80

</div>

---

## 📋 Overview

| Property | Value |
|----------|-------|
| Token Standard | ERC-20 |
| Tax Range | 0% – 25% (configurable) |
| Max Supply | 1,000,000 tokens |
| Tax Exemptions | Mint, burn, treasury transfers |
| Access Control | Ownable (OpenZeppelin) |

---

## ⚙️ How it works

Every transfer is intercepted at the `_update` level and split:
```
User sends 1,000 tokens →
├── 950 tokens → Recipient (95%)
└──  50 tokens → Treasury  (5%)
```

Minting and burning are **never taxed**.

---

## 🚀 Quickstart
```bash
git clone https://github.com/HEO-80/erc20-tax-token.git
cd erc20-tax-token
npm install
npx hardhat build
npx hardhat test
```

---

## 📁 Project Structure
```
erc20-tax-token/
├── contracts/
│   └── TaxToken.sol        # Main contract
├── test/
│   └── TaxToken.test.js    # 7 tests
├── README.md
├── STEPS.md                # Setup commands
├── EXPLANATION.md          # How it works in detail
└── EXAMPLE.md              # Real-world use case
```

---

## 🧪 Tests

| Test | Status |
|------|--------|
| Initial supply assigned to owner | ✅ |
| Tax charged on transfers | ✅ |
| Owner can change tax percent | ✅ |
| Cannot exceed MAX_TAX (25%) | ✅ |
| Owner can change treasury wallet | ✅ |
| Non-owner cannot change tax | ✅ |
| No tax on mint | ✅ |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Solidity 0.8.28 | Smart contract language |
| Hardhat 3 | Development environment |
| OpenZeppelin 5 | ERC20 + Ownable base contracts |
| Mocha + Chai | Test framework |

---

## 👤 Author

**Héctor Oviedo** — Full Stack Developer & DeFi Researcher

[![GitHub](https://img.shields.io/badge/GitHub-HEO--80-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/HEO-80)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-hectorob-0077b5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/hectorob)

---

<div align="center">

*Tested. Documented. Ready to deploy.*


</div>