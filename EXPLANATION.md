# Explanation - ERC-20 Tax Token

## What is it?
An ERC-20 token that automatically charges a configurable percentage fee
on every transfer, sending it to a designated treasury wallet.

## How does it work?

### Tax mechanism
The contract overrides OpenZeppelin's internal `_update` function —
the core method called on every token movement. Instead of sending
the full amount to the recipient, it splits it:

- `taxAmount = amount * taxPercent / 100` → goes to treasury
- `sendAmount = amount - taxAmount` → goes to recipient

### Tax exemptions
No tax is charged when:
- Minting tokens (`from == address(0)`)
- Burning tokens (`to == address(0)`)
- Sending directly to treasury wallet

### Key parameters
| Parameter | Description | Limit |
|-----------|-------------|-------|
| `taxPercent` | Fee percentage per transfer | Max 25% |
| `treasury` | Wallet receiving the fees | Must be non-zero |
| `MAX_SUPPLY` | Maximum token supply | 1,000,000 tokens |

### Owner controls
- `setTax(uint256)` → change tax percentage anytime
- `setTreasury(address)` → redirect fees to new wallet

## Why override `_update` and not `transfer`?
Because `_update` is the single internal hook that handles ALL token
movements in OpenZeppelin v5 — transfers, mints and burns. Overriding
it ensures the tax logic is applied consistently everywhere without
duplicating code.

## Contract inheritance
```
TaxToken
├── ERC20 (OpenZeppelin) — standard token logic
└── Ownable (OpenZeppelin) — access control
```