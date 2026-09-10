// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Crowdfunding {
    struct Campaign {
        address creator;
        string title;
        uint256 goal;
        uint256 deadline;
        uint256 raised;
        bool claimed;
    }

    uint256 public campaignCount;

    mapping(uint256 => Campaign) public campaigns;
    mapping(uint256 => mapping(address => uint256)) public contributions;

    event CampaignCreated(
        uint256 indexed campaignId, address indexed creator, string title, uint256 goal, uint256 deadline
    );

    event ContributionMade(uint256 indexed campaignId, address indexed contributor, uint256 amount);

    event FundsClaimed(uint256 indexed campaignId, address indexed creator, uint256 amount);

    event Refunded(uint256 indexed campaignId, address indexed contributor, uint256 amount);

    function createCampaign(string calldata _title, uint256 _goal, uint256 _duration) external returns (uint256) {
        require(bytes(_title).length > 0, "Title required");
        require(_goal > 0, "Goal must be greater than zero");
        require(_duration > 0, "Duration must be greater than zero");

        uint256 campaignId = campaignCount;

        campaigns[campaignId] = Campaign({
            creator: msg.sender,
            title: _title,
            goal: _goal,
            deadline: block.timestamp + _duration,
            raised: 0,
            claimed: false
        });

        campaignCount++;

        emit CampaignCreated(campaignId, msg.sender, _title, _goal, block.timestamp + _duration);

        return campaignId;
    }

    function contribute(uint256 _campaignId) external payable {
        Campaign storage campaign = campaigns[_campaignId];

        require(campaign.creator != address(0), "Campaign does not exist");
        require(block.timestamp < campaign.deadline, "Campaign ended");
        require(msg.value > 0, "Contribution must be greater than zero");

        campaign.raised += msg.value;
        contributions[_campaignId][msg.sender] += msg.value;

        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }

    function claimFunds(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];

        require(campaign.creator != address(0), "Campaign does not exist");
        require(msg.sender == campaign.creator, "Only creator");
        require(block.timestamp >= campaign.deadline, "Campaign still active");
        require(campaign.raised >= campaign.goal, "Goal not reached");
        require(!campaign.claimed, "Funds already claimed");

        campaign.claimed = true;

        uint256 amount = campaign.raised;

        (bool success,) = payable(campaign.creator).call{value: amount}("");
        require(success, "Transfer failed");

        emit FundsClaimed(_campaignId, campaign.creator, amount);
    }

    function refund(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];

        require(campaign.creator != address(0), "Campaign does not exist");
        require(block.timestamp >= campaign.deadline, "Campaign still active");
        require(campaign.raised < campaign.goal, "Goal was reached");

        uint256 amount = contributions[_campaignId][msg.sender];

        require(amount > 0, "Nothing to refund");

        contributions[_campaignId][msg.sender] = 0;

        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Refund failed");

        emit Refunded(_campaignId, msg.sender, amount);
    }
}
