// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/Fundme.sol";
contract FundMeTest  is Test{
         FundMe fundMe;
    function setUp() public {
         fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }
    function testOwnerIsMsgSender() public {
        console.log("msg.sender: ", msg.sender);
        console.log("i_owner: ", fundMe.i_owner());
        assertEq(fundMe.i_owner(),address(this));
    }
    function testIfAgregatorV3InterfaceVersionIsCorrect() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}