// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";
import {AMM} from "../src/AMM.sol";

contract AMMScript is Script {
    function run() external {
        vm.startBroadcast();

        Token tokenA = new Token("Token A", "TKNA");
        Token tokenB = new Token("Token B", "TKNB");
        AMM amm = new AMM(address(tokenA), address(tokenB));

        tokenA.mint(msg.sender, 1e6);
        tokenB.mint(msg.sender, 1e6);

        tokenA.approve(address(amm), type(uint256).max);
        tokenB.approve(address(amm), type(uint256).max);

        amm.addLiquidity(100, 200_000);

        console.log("TokenA:", address(tokenA));
        console.log("TokenB:", address(tokenB));
        console.log("AMM:   ", address(amm));

        vm.stopBroadcast();
    }
}
