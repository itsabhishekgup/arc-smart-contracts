// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/BuilderNFT.sol";

contract BuilderNFTTest is Test {
    BuilderNFT nft;

    address user1 = address(1);
    address user2 = address(2);

    function setUp() public {
        nft = new BuilderNFT();
    }

    function testInitialState() public view {
        assertEq(nft.name(), "Arc Builder NFT");
        assertEq(nft.symbol(), "ABNFT");
        assertEq(nft.nextTokenId(), 0);
    }

    function testMint() public {
        nft.mint(user1, "ipfs://builder-nft-1");

        assertEq(nft.ownerOf(0), user1);
        assertEq(nft.balanceOf(user1), 1);
        assertEq(nft.tokenURI(0), "ipfs://builder-nft-1");
        assertEq(nft.nextTokenId(), 1);
    }

    function testMultipleMints() public {
        nft.mint(user1, "ipfs://nft-1");
        nft.mint(user2, "ipfs://nft-2");

        assertEq(nft.ownerOf(0), user1);
        assertEq(nft.ownerOf(1), user2);
        assertEq(nft.balanceOf(user1), 1);
        assertEq(nft.balanceOf(user2), 1);
    }

    function testTransfer() public {
        nft.mint(user1, "ipfs://builder-nft-1");

        vm.prank(user1);
        nft.transferFrom(user1, user2, 0);

        assertEq(nft.ownerOf(0), user2);
        assertEq(nft.balanceOf(user1), 0);
        assertEq(nft.balanceOf(user2), 1);
    }

    function testOnlyOwnerCanMint() public {
        vm.prank(user1);

        vm.expectRevert("Only owner can mint");
        nft.mint(user1, "ipfs://unauthorized");
    }
}
