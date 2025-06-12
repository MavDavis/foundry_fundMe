// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/Fundme.sol";
contract FundMeTest  is Test{
         FundMe fundMe;
    function setUp() public {
         fundMe = new FundMe();
    }
    function testDemo() public {
        assertEq(number, 2);
    }
}