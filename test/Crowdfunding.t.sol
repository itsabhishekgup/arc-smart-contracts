// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding crowdfunding;

    address creator = address(1);
    address contributor = address(2);
    address contributor2 = address(3);

    uint256 constant GOAL = 10 ether;
    uint256 constant DURATION = 7 days;

    function setUp() public {
        crowdfunding = new Crowdfunding();
    }

    function testCreateCampaign() public {
        vm.prank(creator);

        uint256 campaignId = crowdfunding.createCampaign("Build a DeFi App", GOAL, DURATION);

        assertEq(campaignId, 0);
        assertEq(crowdfunding.campaignCount(), 1);

        (address campaignCreator, string memory title, uint256 goal, uint256 deadline, uint256 raised, bool claimed) =
            crowdfunding.campaigns(campaignId);

        assertEq(campaignCreator, creator);
        assertEq(title, "Build a DeFi App");
        assertEq(goal, GOAL);
        assertEq(deadline, block.timestamp + DURATION);
        assertEq(raised, 0);
        assertFalse(claimed);
    }

    function testContribution() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Build a DeFi App", GOAL, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        (,,,, uint256 raised,) = crowdfunding.campaigns(campaignId);

        assertEq(raised, 5 ether);
        assertEq(crowdfunding.contributions(campaignId, contributor), 5 ether);
    }

    function testCreatorCanClaimAfterGoalReached() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Build a DeFi App", GOAL, DURATION);

        vm.deal(contributor, 10 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 10 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        uint256 creatorBalanceBefore = creator.balance;

        vm.prank(creator);
        crowdfunding.claimFunds(campaignId);

        assertEq(creator.balance, creatorBalanceBefore + 10 ether);

        (,,,,, bool claimed) = crowdfunding.campaigns(campaignId);
        assertTrue(claimed);
    }

    function testContributorCanRefundIfGoalFails() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Build a DeFi App", GOAL, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        uint256 contributorBalanceBefore = contributor.balance;

        vm.prank(contributor);
        crowdfunding.refund(campaignId);

        assertEq(contributor.balance, contributorBalanceBefore + 5 ether);
        assertEq(crowdfunding.contributions(campaignId, contributor), 0);
    }

    function testMultipleContributors() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Community Project", GOAL, DURATION);

        vm.deal(contributor, 5 ether);
        vm.deal(contributor2, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.prank(contributor2);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        (,,,, uint256 raised,) = crowdfunding.campaigns(campaignId);

        assertEq(raised, 10 ether);
        assertEq(crowdfunding.contributions(campaignId, contributor), 5 ether);
        assertEq(crowdfunding.contributions(campaignId, contributor2), 5 ether);
    }

    function testCannotContributeAfterDeadline() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Expired Campaign", GOAL, DURATION);

        vm.warp(block.timestamp + DURATION);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        vm.expectRevert("Campaign ended");
        crowdfunding.contribute{value: 1 ether}(campaignId);
    }

    function testCannotClaimBeforeDeadline() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Early Claim", 1 ether, DURATION);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 1 ether}(campaignId);

        vm.prank(creator);
        vm.expectRevert("Campaign still active");
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotClaimIfGoalNotReached() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Failed Campaign", GOAL, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(creator);
        vm.expectRevert("Goal not reached");
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotRefundBeforeDeadline() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Active Campaign", GOAL, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.prank(contributor);
        vm.expectRevert("Campaign still active");
        crowdfunding.refund(campaignId);
    }

    function testCannotRefundTwice() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Refund Test", GOAL, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(contributor);
        crowdfunding.refund(campaignId);

        vm.prank(contributor);
        vm.expectRevert("Nothing to refund");
        crowdfunding.refund(campaignId);
    }

    function testOnlyCreatorCanClaim() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Access Control", 1 ether, DURATION);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 1 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(contributor);
        vm.expectRevert("Only creator");
        crowdfunding.claimFunds(campaignId);
    }

    function testMultipleCampaigns() public {
        vm.startPrank(creator);

        uint256 campaign1 = crowdfunding.createCampaign("Campaign One", 1 ether, DURATION);

        uint256 campaign2 = crowdfunding.createCampaign("Campaign Two", 2 ether, DURATION);

        vm.stopPrank();

        assertEq(campaign1, 0);
        assertEq(campaign2, 1);
        assertEq(crowdfunding.campaignCount(), 2);
    }

    function testCannotCreateInvalidCampaign() public {
        vm.prank(creator);

        vm.expectRevert("Goal must be greater than zero");
        crowdfunding.createCampaign("Invalid Campaign", 0, DURATION);
    }

    function testCannotCreateCampaignWithZeroDuration() public {
        vm.prank(creator);

        vm.expectRevert("Duration must be greater than zero");

        crowdfunding.createCampaign("Invalid Duration", GOAL, 0);
    }

    function testCannotContributeToNonExistentCampaign() public {
        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        vm.expectRevert("Campaign does not exist");

        crowdfunding.contribute{value: 1 ether}(999);
    }

    function testCannotClaimFundsTwice() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Double Claim Protection", 1 ether, DURATION);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 1 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(creator);
        crowdfunding.claimFunds(campaignId);

        vm.prank(creator);
        vm.expectRevert("Funds already claimed");
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotRefundIfGoalReached() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Successful Campaign", 5 ether, DURATION);

        vm.deal(contributor, 5 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 5 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(contributor);
        vm.expectRevert("Goal was reached");
        crowdfunding.refund(campaignId);
    }

    function testCannotRefundNonExistentCampaign() public {
        vm.prank(contributor);
        vm.expectRevert("Campaign does not exist");

        crowdfunding.refund(999);
    }

    function testCannotContributeZero() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Zero Contribution", GOAL, DURATION);

        vm.prank(contributor);
        vm.expectRevert("Contribution must be greater than zero");
        crowdfunding.contribute{value: 0}(campaignId);
    }

    function testCannotCreateEmptyTitle() public {
        vm.prank(creator);

        vm.expectRevert("Title required");
        crowdfunding.createCampaign("", GOAL, DURATION);
    }

    function testCannotContributeAfterCampaignEnds() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Expired Campaign", GOAL, DURATION);

        vm.warp(block.timestamp + DURATION + 1);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        vm.expectRevert("Campaign ended");
        crowdfunding.contribute{value: 1 ether}(campaignId);
    }

    function testCannotClaimBeforeGoalIsReached() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("Incomplete Campaign", GOAL, DURATION);

        vm.deal(contributor, 1 ether);

        vm.prank(contributor);
        crowdfunding.contribute{value: 1 ether}(campaignId);

        vm.warp(block.timestamp + DURATION);

        vm.prank(creator);
        vm.expectRevert("Goal not reached");
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotRefundWithoutContribution() public {
        vm.prank(creator);
        uint256 campaignId = crowdfunding.createCampaign("No Contribution", GOAL, DURATION);

        vm.warp(block.timestamp + DURATION);

        vm.prank(contributor);
        vm.expectRevert("Nothing to refund");
        crowdfunding.refund(campaignId);
    }

    function testCannotClaimNonExistentCampaign() public {
        vm.prank(creator);
        vm.expectRevert("Campaign does not exist");
        crowdfunding.claimFunds(999);
    }
}
