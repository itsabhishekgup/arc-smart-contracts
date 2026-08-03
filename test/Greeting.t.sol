// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Greeting} from "../src/Greeting.sol";

contract GreetingTest is Test {
    Greeting greeting;

    function setUp() public {
        greeting = new Greeting();
    }

    function testInitialGreeting() public view {
        assertEq(greeting.getGreeting(), "Hello Arc!");
    }

    function testSetGreeting() public {
        greeting.setGreeting("Hello Builder!");
        assertEq(greeting.getGreeting(), "Hello Builder!");
    }
}