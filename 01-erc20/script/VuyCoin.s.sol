// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {VuyCoin} from "../src/VuyCoin.sol";

contract VuyCoinScript is Script {
    VuyCoin public coin;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        coin = new VuyCoin(1000);

        vm.stopBroadcast();
    }
}
