// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "src/ERC20Example.sol";

contract Erc20Script is Script {

    function setUp() view public {
        console.log("Setting up the script...");
    }

    function run() public {
        console.log("Running the script...");

        address randomAddr1 = vm.addr(1); 
        address randomAddr2 = vm.addr(2); 

        console.log("randomAddr1 is %s", randomAddr1);
        console.log("randomAddr2 is %s", randomAddr2);

        address sender = vm.addr(3); 
        console.log("sender is %s", sender);

        vm.startBroadcast(sender);

        Erc20Example erc20 = new Erc20Example("Erc Example Token", "EET");

        console.log("erc20 owner is %s", erc20.owner());

        erc20.addBlackList(randomAddr1);

        console.log("randomAddr1 is black? %s", erc20.getBlackListStatus(randomAddr1));
        console.log("randomAddr2 is black? %s", erc20.getBlackListStatus(randomAddr2));

        console.log("init EET is pause? %s", erc20.paused());

        erc20.pause();

        console.log("after pause EET is pause? %s", erc20.paused());

        erc20.unpause();

        console.log("after unpause EET is pause? %s", erc20.paused());
        vm.stopBroadcast();
    }
}
