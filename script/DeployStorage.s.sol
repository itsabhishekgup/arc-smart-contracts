// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Storage.sol";

contract DeployStorage is Script {
    function run() public {
        vm.startBroadcast();
        new Storage();
        vm.stopBroadcast();
    }
}
