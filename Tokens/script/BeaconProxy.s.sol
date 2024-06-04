pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {ERC20ExampleV1} from "src/ERC20ExampleV1.sol";
import {BeaconProxyExample} from "src/proxy/BeaconProxy.sol";
import {UpgradeableBeaconExample} from "src/proxy/UpgradeableBeacon.sol";

contract BeaconProxyScript is Script{
    BeaconProxyExample beaconProxy;
    BeaconProxyExample beaconProxy2;
    UpgradeableBeaconExample upgradeableBeacon;
    ERC20ExampleV1 erc20;
    address sender;

    function run() public {
        uint256 ownerPK = vm.envUint("OWNER_PRIVATE_KEY");

        vm.startBroadcast(ownerPK);
        
        erc20 = new ERC20ExampleV1();
        upgradeableBeacon = new UpgradeableBeaconExample(
            address(erc20), 
            msg.sender);
        beaconProxy = new BeaconProxyExample(
            address(upgradeableBeacon), 
            abi.encodeWithSelector(
                erc20.initialize.selector, 
                "BeaconProxy Example Token", 
                "BPET"));

        beaconProxy2 = new BeaconProxyExample(
            address(upgradeableBeacon), 
            abi.encodeWithSelector(
                erc20.initialize.selector, 
                "BeaconProxy Example Token2", 
                "BPET2"));
        console.log("BeaconProxy address: ", address(beaconProxy));
        console.log("BeaconProxy2 address: ", address(beaconProxy2));
        console.log("UpgradeableBeacon address: ", address(upgradeableBeacon));
        console.log("ERC20Example address: ", address(erc20));

        sender = msg.sender;
        vm.stopBroadcast();
    }
}