pragma solidity ^0.8.22;

import {ERC20ExampleSetupTest} from "./ERC20ExampleSetup.t.sol";

contract PausableTest is ERC20ExampleSetupTest {
    function setUp() public override {
        super.setUp();
    }

    function testPause() public {
        vm.startPrank(owner);
        erc20Example.pause();
        assertTrue(erc20Example.paused());
        vm.stopPrank();
    }

    function testUnpause() public {
        vm.startPrank(owner);
        erc20Example.pause();
        assertTrue(erc20Example.paused());
        erc20Example.unpause();
        assertFalse(erc20Example.paused());
        vm.stopPrank();
    }
}