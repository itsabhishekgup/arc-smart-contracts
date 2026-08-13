// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BuilderNFT} from "../src/BuilderNFT.sol";

contract DeployBuilderNFT is Script {
    function run() public {
        vm.startBroadcast();

        new BuilderNFT();

        vm.stopBroadcast();
    }
}
