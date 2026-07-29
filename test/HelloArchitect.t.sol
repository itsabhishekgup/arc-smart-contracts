// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/HelloArchitect.sol";

contract HelloArchitectTest is Test {
    HelloArchitect helloArchitect;

    function setUp() public {
        helloArchitect = new HelloArchitect();
    }

    function testInitialGreeting() public view {
        assertEq(helloArchitect.getGreeting(), "Hello Architect!");
    }

    function testSetGreeting() public {
        helloArchitect.setGreeting("Welcome to Arc Chain!");
        assertEq(helloArchitect.getGreeting(), "Welcome to Arc Chain!");
    }
}