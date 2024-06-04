// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {BeaconProxyScript} from "script/BeaconProxy.s.sol";
import {ERC20ExampleV1} from "src/ERC20ExampleV1.sol";
import {BeaconProxy} from "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

/// @custom:oz-upgrades-from src/ERC20ExampleV1.sol:ERC20ExampleV1
contract ERC20ExampleV2 is ERC20ExampleV1{
    function initializeV2() public initializer {
        version = "v0.0.2";
    }

    function hello() public pure returns (string memory) {
        return "hello";
    }
}

contract BeaconPrpxyTest is BeaconProxyScript, Test {

    ERC20ExampleV1 public client1_v1;
    ERC20ExampleV1 public client2_v1;
    ERC20ExampleV2 public client1_v2;
    ERC20ExampleV2 public client2_v2;


    function setUp() public {
        run();
        
        client1_v1 = ERC20ExampleV1(address(beaconProxy));
        client2_v1 = ERC20ExampleV1(address(beaconProxy2));
        assertEq(client1_v1.version(), "v0.0.1");
        assertEq(client2_v1.version(), "v0.0.1");
    }

    function testBeaconProxyUpdate() public {
        ERC20ExampleV2 newExample = new ERC20ExampleV2();
        vm.prank(sender);
        upgradeableBeacon.upgradeTo(address(newExample));

        client1_v2 = ERC20ExampleV2(address(beaconProxy));
        client2_v2 = ERC20ExampleV2(address(beaconProxy2));
        assertEq(client1_v2.hello(), "hello");
    }
}