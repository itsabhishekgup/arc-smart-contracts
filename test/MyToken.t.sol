// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;

    function setUp() public {
        token = new MyToken(1000);
    }

    function testInitialSupply() public view {
        assertEq(token.totalSupply(), 1000 * 1e18);
    }

    function testTransfer() public {
        address user = address(1);

        token.transfer(user, 100 * 1e18);

        assertEq(token.balanceOf(user), 100 * 1e18);
    }

    function testMint() public {
        token.mint(address(2), 50 * 1e18);

        assertEq(token.balanceOf(address(2)), 50 * 1e18);
    }

    function testBurn() public {
        token.burn(100 * 1e18);

        assertEq(token.balanceOf(address(this)), 900 * 1e18);
    }
}
