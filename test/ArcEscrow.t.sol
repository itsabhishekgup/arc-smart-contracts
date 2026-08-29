// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ArcEscrow.sol";

contract MockUSDC {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Not approved");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}

contract ArcEscrowTest is Test {
    MockUSDC token;
    ArcEscrow escrow;

    address depositor = address(1);
    address beneficiary = address(2);
    address arbiter = address(3);

    uint256 constant DEPOSIT_AMOUNT = 100e6;

    function setUp() public {
        token = new MockUSDC();

        vm.prank(depositor);
        escrow = new ArcEscrow(address(token), beneficiary, arbiter);

        token.mint(depositor, DEPOSIT_AMOUNT);

        vm.prank(depositor);
        token.approve(address(escrow), DEPOSIT_AMOUNT);
    }

    function testDeposit() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        assertEq(escrow.amount(), DEPOSIT_AMOUNT);
        assertTrue(escrow.deposited());
        assertEq(token.balanceOf(address(escrow)), DEPOSIT_AMOUNT);
    }

    function testRelease() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        vm.prank(beneficiary);
        escrow.release();

        assertTrue(escrow.completed());
        assertEq(token.balanceOf(beneficiary), DEPOSIT_AMOUNT);
        assertEq(token.balanceOf(address(escrow)), 0);
    }

    function testRefund() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        vm.prank(arbiter);
        escrow.refund();

        assertTrue(escrow.completed());
        assertEq(token.balanceOf(depositor), DEPOSIT_AMOUNT);
        assertEq(token.balanceOf(address(escrow)), 0);
    }

    function testOnlyDepositorCanDeposit() public {
        vm.prank(beneficiary);

        vm.expectRevert("Only depositor");
        escrow.deposit(DEPOSIT_AMOUNT);
    }

    function testOnlyBeneficiaryCanRelease() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        vm.prank(depositor);

        vm.expectRevert("Only beneficiary");
        escrow.release();
    }

    function testOnlyArbiterCanRefund() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        vm.prank(beneficiary);

        vm.expectRevert("Only arbiter");
        escrow.refund();
    }

    function testCannotDepositTwice() public {
        vm.prank(depositor);
        escrow.deposit(DEPOSIT_AMOUNT);

        vm.prank(depositor);

        vm.expectRevert("Already deposited");
        escrow.deposit(DEPOSIT_AMOUNT);
    }
}
