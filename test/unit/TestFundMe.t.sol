//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant Send_Val = 0.1 ether; //10e18
    uint256 constant Start_Bal = 10 ether;

    function setUp() external {
        //us -> FundMeTest -> FundMe
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, Start_Bal);
    }

    function testMinDollar() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerisMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersion() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert(); //asser(This tx fails/reverts)
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundMe.fund{value: Send_Val}();

        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, Send_Val);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        fundMe.fund{value: Send_Val}();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: Send_Val}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
        //Arrange
        uint256 startingOwnerBal = fundMe.getOwner().balance;
        uint256 startingFundMeBal = address(fundMe).balance;

        //Act
        vm.prank(fundMe.getOwner()); //Okay, now the owner is calling
        fundMe.withdraw();

        //Assert
        uint256 endingOwnerBal = fundMe.getOwner().balance;
        uint256 endingFundMeBal = address(fundMe).balance;
        assertEq(endingFundMeBal, 0);
        assertEq(startingFundMeBal + startingOwnerBal, endingOwnerBal);
    }

    function testWithdrawFromMultipleFunders() public funded {
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIdx = 1;
        for (uint160 i = startingFunderIdx; i < numberOfFunders; i++) {
            //vm.prank(new Add.) -> (new Add.) -> fund the fundMe
            hoax(address(i), Send_Val);
            fundMe.fund{value: Send_Val}();
        }

        uint256 startingOwnerBal = fundMe.getOwner().balance;
        uint256 startingFundMeBal = address(fundMe).balance;

        //Act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBal + startingOwnerBal == fundMe.getOwner().balance);
    }

    function testWithdrawFromMultipleFundersCheaper() public funded {
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIdx = 1;
        for (uint160 i = startingFunderIdx; i < numberOfFunders; i++) {
            //vm.prank(new Add.) -> (new Add.) -> fund the fundMe
            hoax(address(i), Send_Val);
            fundMe.fund{value: Send_Val}();
        }

        uint256 startingOwnerBal = fundMe.getOwner().balance;
        uint256 startingFundMeBal = address(fundMe).balance;

        //Act
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBal + startingOwnerBal == fundMe.getOwner().balance);
    }
}
