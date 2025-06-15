// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {FundMe} from "../src/Fundme.sol";
import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
contract DeployFundMe is Script {
//     Counter public counter;

//     function setUp() public {}

    function run() public returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig();
        address priceFeed = helperConfig.activeNetworkConfig();
        console.log("Price Feed Address: ", priceFeed);
        vm.startBroadcast();

        FundMe fundMe = new FundMe(priceFeed);

        vm.stopBroadcast();
        return fundMe;
    }
}
