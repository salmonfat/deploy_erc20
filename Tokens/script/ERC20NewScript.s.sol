// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "src/ERC20Example.sol";

contract Erc20NewScript is Script {
    ERC20Example erc20;

    function run() public {

        uint256 ownerPK = vm.envUint("OWNER_PRIVATE_KEY");

        vm.startBroadcast(ownerPK);
        

        erc20 = new ERC20Example("Erc Example Token", "EET");

        vm.stopBroadcast();
    }
}
