// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract DeployCrowdfunding is Script {
    function run() public {
        vm.startBroadcast();

        new Crowdfunding();

        vm.stopBroadcast();
    }
}