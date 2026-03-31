// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title TaxToken - ERC-20 con impuesto en transferencias
/// @author HEO-80
/// @notice Cada transferencia cobra un % que va a una wallet treasury
contract TaxToken is ERC20, Ownable {
    uint256 public taxPercent;
    address public treasury;

    uint256 public constant MAX_TAX = 25;
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10 ** 18;

    event TaxChanged(uint256 oldTax, uint256 newTax);
    event TreasuryChanged(address oldTreasury, address newTreasury);

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        uint256 _taxPercent,
        address _treasury
    ) ERC20(name, symbol) Ownable(msg.sender) {
        require(_taxPercent <= MAX_TAX, "Tax too high");
        require(_treasury != address(0), "Invalid treasury");
        require(initialSupply <= MAX_SUPPLY, "Exceeds max supply");

        taxPercent = _taxPercent;
        treasury = _treasury;

        _mint(msg.sender, initialSupply);
    }

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override {
        if (taxPercent > 0 && from != address(0) && to != address(0) && to != treasury) {
            uint256 taxAmount = (amount * taxPercent) / 100;
            uint256 sendAmount = amount - taxAmount;
            super._update(from, treasury, taxAmount);
            super._update(from, to, sendAmount);
        } else {
            super._update(from, to, amount);
        }
    }

    /// @notice Cambia el porcentaje de impuesto
    function setTax(uint256 _taxPercent) external onlyOwner {
        require(_taxPercent <= MAX_TAX, "Tax too high");
        emit TaxChanged(taxPercent, _taxPercent);
        taxPercent = _taxPercent;
    }

    /// @notice Cambia la wallet treasury
    function setTreasury(address _treasury) external onlyOwner {
        require(_treasury != address(0), "Invalid treasury");
        emit TreasuryChanged(treasury, _treasury);
        treasury = _treasury;
    }
}