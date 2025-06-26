// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import{DeployFundMe} from "../script/DeployFundMe.s.sol";
import {FundMe} from "../src/Fundme.sol";
contract FundMeTest  is Test{
        address USER = makeAddr("user");
        uint256 constant STARTING_BALANCE = 10 ether; 
        uint256 constant SEND_VALUE = 1 ether;
         FundMe fundMe;
    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }
    function testMinimumDollarIsFive() public view{
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }
    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(),msg.sender);
    }
    function testIfAgregatorV3InterfaceVersionIsCorrect() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
    function testFunctionFailsWithoutEnoughFunds()public{
        vm.expectRevert();
        fundMe.fund();        
    }
    function testFundFunctionUpdatesFundedDataStructure() public  {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddessToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
    function testAddsFunderToArray() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address[] funders = fundMe.getFunder();
        assertEq(funders[0], USER);
    }
    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        vm.expectRevert("FundMe_NotOwner");
        fundMe.withdraw();
    }
}