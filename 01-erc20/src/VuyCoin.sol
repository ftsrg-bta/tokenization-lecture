// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract VuyCoin is ERC20 {
    constructor(uint256 initialSupply) ERC20("VuyCoin", "VUY") {
        _mint(msg.sender, initialSupply);
    }
}
