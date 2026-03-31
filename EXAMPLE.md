# Example - ERC-20 Tax Token

## Real-world use case
A DeFi project launches its governance token and wants to
automatically fund its treasury on every transaction —
without requiring users to manually send fees.

## Scenario
- Project launches `PROJ` token with 5% transfer tax
- Treasury wallet accumulates fees automatically
- Team can adjust tax or redirect treasury anytime

## Deployment example
```solidity
TaxToken token = new TaxToken(
    "Project Token",  // name
    "PROJ",           // symbol
    500_000 * 1e18,   // initial supply: 500,000 tokens
    5,                // 5% tax per transfer
    0xTREASURY...     // treasury wallet
);
```

## Transfer example
```
User A sends 1,000 PROJ to User B:
├── 950 PROJ → User B (95%)
└──  50 PROJ → Treasury (5%)
```

## Who uses this pattern?
- **Safemoon-style tokens** — auto-liquidity and redistribution
- **DAO treasuries** — self-funding via transaction fees
- **Play-to-earn games** — marketplace fee collection
- **DeFi protocols** — protocol fee accumulation

## Adjusting tax over time
```solidity
// Reduce tax as project matures
token.setTax(2); // lower to 2%

// Redirect fees to new multisig
token.setTreasury(0xNEW_MULTISIG...);
```