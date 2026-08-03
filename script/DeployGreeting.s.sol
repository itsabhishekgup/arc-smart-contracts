// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Greeting} from "../src/Greeting.sol";

contract DeployGreeting is Script {
    function run() public {
        vm.startBroadcast();

        new Greeting();

        vm.stopBroadcast();
    }
}
