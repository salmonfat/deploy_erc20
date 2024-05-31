// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC20ExampleSetupTest} from "./ERC20ExampleSetup.t.sol";

contract BlackListTest is ERC20ExampleSetupTest {
    function setUp() public override {
        super.setUp();
    }

    function testAddBlackList() public {
        vm.startPrank(owner);
        erc20Example.addBlackList(user2);
        assertTrue(erc20Example.getBlackListStatus(user2));
        vm.stopPrank();
    }

    function testRemoveBlackList() public {
        vm.startPrank(owner);
        erc20Example.addBlackList(user2);
        assertTrue(erc20Example.getBlackListStatus(user2));
        erc20Example.removeBlackList(user2);
        assertFalse(erc20Example.getBlackListStatus(user2));
        vm.stopPrank();
    }

    function testGetBlackListStatus() public {
        vm.startPrank(owner);
        erc20Example.addBlackList(user2);
        assertTrue(erc20Example.getBlackListStatus(user2));
        vm.stopPrank();
    }
}