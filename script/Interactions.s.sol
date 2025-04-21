//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant Send_Val = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        console.log("Most recently deployed FundMe contract: %s", mostRecentlyDeployed);
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: Send_Val}();
        vm.stopBroadcast();   
        console.log("Funding FundMe contract with %s", Send_Val);
    }

    function run() external {
        //Looks inside broadcast folder based on chainId & picks most latest 
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}