# Steps - ERC-20 Tax Token

## Setup
1. `npm init -y`
2. `npm pkg set type="module"`
3. `npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox-mocha-ethers`
4. `npm install @openzeppelin/contracts`
5. `npx hardhat --init` → Hardhat 3 → minimal
6. Add plugin to `hardhat.config.ts`:
```typescriptimport hardhatToolboxMochaEthers from "@nomicfoundation/hardhat-toolbox-mocha-ethers";
export default defineConfig({
plugins: [hardhatToolboxMochaEthers],
solidity: { version: "0.8.28" }
});

## Commands used
- `npx hardhat build` → Compile contracts
- `npx hardhat test` → Run test suite

## Result
✅ 7/7 tests passing
✅ Compiled with solc 0.8.28