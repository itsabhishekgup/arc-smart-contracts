// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    function run() public {
        vm.startBroadcast();

        new MyToken(1000);

        vm.stopBroadcast();
    }
}