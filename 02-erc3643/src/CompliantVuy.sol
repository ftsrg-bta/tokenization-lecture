// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract CompliantVuy is ERC20, Ownable {
    mapping(address => bool) public identityRegistry;

    constructor(uint256 initialSupply) ERC20("CompliantVuy", "VUYC") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    function registerIdentity(address account) external onlyOwner {
        identityRegistry[account] = true;
    }

    function _update(address from, address to, uint256 value) internal override {
        if (from != address(0)) {
            require(identityRegistry[to], "Operation not allowed");
        }
        super._update(from, to, value);
    }
}
