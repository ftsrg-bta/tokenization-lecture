// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {CompliantVuy} from "../src/CompliantVuy.sol";

contract CompliantVuyScript is Script {
    CompliantVuy public coin;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        coin = new CompliantVuy(1000);

        vm.stopBroadcast();
    }
}
