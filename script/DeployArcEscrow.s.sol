// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ArcEscrow} from "../src/ArcEscrow.sol";

contract DeployArcEscrow is Script {
    function run() public {
        address token = vm.envAddress("ARC_USDC_ADDRESS");
        address beneficiary = vm.envAddress("ESCROW_BENEFICIARY");
        address arbiter = vm.envAddress("ESCROW_ARBITER");

        vm.startBroadcast();

        new ArcEscrow(token, beneficiary, arbiter);

        vm.stopBroadcast();
    }
}
