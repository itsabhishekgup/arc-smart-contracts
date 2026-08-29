// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract ArcEscrow {
    IERC20 public immutable token;

    address public depositor;
    address public beneficiary;
    address public arbiter;

    uint256 public amount;
    bool public deposited;
    bool public completed;

    event Deposited(address indexed depositor, address indexed beneficiary, uint256 amount);

    event Released(address indexed beneficiary, uint256 amount);

    event Refunded(address indexed depositor, uint256 amount);

    constructor(address _token, address _beneficiary, address _arbiter) {
        require(_token != address(0), "Invalid token");
        require(_beneficiary != address(0), "Invalid beneficiary");
        require(_arbiter != address(0), "Invalid arbiter");

        token = IERC20(_token);
        depositor = msg.sender;
        beneficiary = _beneficiary;
        arbiter = _arbiter;
    }

    function deposit(uint256 _amount) external {
        require(msg.sender == depositor, "Only depositor");
        require(!deposited, "Already deposited");
        require(_amount > 0, "Amount must be greater than zero");

        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");

        amount = _amount;
        deposited = true;

        emit Deposited(depositor, beneficiary, _amount);
    }

    function release() external {
        require(msg.sender == beneficiary, "Only beneficiary");
        require(deposited, "Not deposited");
        require(!completed, "Already completed");

        completed = true;

        require(token.transfer(beneficiary, amount), "Transfer failed");

        emit Released(beneficiary, amount);
    }

    function refund() external {
        require(msg.sender == arbiter, "Only arbiter");
        require(deposited, "Not deposited");
        require(!completed, "Already completed");

        completed = true;

        require(token.transfer(depositor, amount), "Transfer failed");

        emit Refunded(depositor, amount);
    }
}
