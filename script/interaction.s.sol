// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/Fundme.sol";
contract FundFundMe is Script{
    uint constant SEND_VALUE = 0.1 ether;
    function fundFundMeContract (address mostRecentDeployed) public{
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();

    }
    function run() external{
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMeContract(mostRecentDeployed);
    }
}
contract WithdrawFundMe is Script{}