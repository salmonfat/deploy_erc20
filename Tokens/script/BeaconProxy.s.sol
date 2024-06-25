pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {ERC20ExampleV1} from "src/ERC20ExampleV1.sol";
import {BeaconProxyExample} from "src/proxy/BeaconProxy.sol";
import {UpgradeableBeaconExample} from "src/proxy/UpgradeableBeacon.sol";
import {TB_coin} from "src/TB_coin.sol";

// contract BeaconProxyScript is Script{
//     BeaconProxyExample beaconProxy;
//     BeaconProxyExample beaconProxy2;
//     UpgradeableBeaconExample upgradeableBeacon;
//     ERC20ExampleV1 erc20;
//     address sender;

//     function run() public {
//         uint256 ownerPK = vm.envUint("OWNER_PRIVATE_KEY");
//         address owner = vm.addr(ownerPK);
//         vm.startBroadcast(ownerPK);
        
//         erc20 = new ERC20ExampleV1();
//         upgradeableBeacon = new UpgradeableBeaconExample(
//             address(erc20), 
//             owner);
//         beaconProxy = new BeaconProxyExample(
//             address(upgradeableBeacon), 
//             abi.encodeWithSelector(
//                 erc20.initialize.selector, 
//                 "TB coin", 
//                 "TB"));

//         // beaconProxy2 = new BeaconProxyExample(
//         //     address(upgradeableBeacon), 
//         //     abi.encodeWithSelector(
//         //         erc20.initialize.selector, 
//         //         "BeaconProxy Example Token2", 
//         //         "BPET2"));
//         console.log("BeaconProxy address: ", address(beaconProxy));
//         // console.log("BeaconProxy2 address: ", address(beaconProxy2));
//         console.log("UpgradeableBeacon address: ", address(upgradeableBeacon));
//         console.log("ERC20Example address: ", address(erc20));

//         sender = owner;
//         vm.stopBroadcast();
//     }
// }

contract BeaconProxyScript is Script{
    TB_coin erc20;
    address sender;

    function run() public {
        uint256 ownerPK = vm.envUint("OWNER_PRIVATE_KEY");
        address owner = vm.addr(ownerPK);
        vm.startBroadcast(ownerPK);
        
        erc20 = new TB_coin("TB coin", "TB");
        console.log("ERC20Example address: ", address(erc20));

        sender = owner;
        vm.stopBroadcast();
    }
}