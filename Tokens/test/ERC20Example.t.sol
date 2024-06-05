// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {ERC20ExampleSetupTest} from "./ERC20ExampleSetup.t.sol";

contract ERC20ExampleTest is ERC20ExampleSetupTest {
    function setUp() public override {
        super.setUp();

        vm.prank(owner);
        erc20Example.addBlackList(user2);
        assertTrue(erc20Example.getBlackListStatus(user2));
    }

    function testTotalSupply() public view {
        uint256 totalSupply = erc20Example.totalSupply();
        assertTrue(totalSupply == 0);
    }

    function testMint() public {
        uint256 amount = 100;

        vm.startPrank(owner);
        // test Mint
        vm.expectEmit(true, true, false, false);
        emit Mint(user1, amount);
        erc20Example.mint(user1, amount);
        vm.stopPrank();
        assertEq(erc20Example.balanceOf(user1), amount);
        assertEq(erc20Example.totalSupply(), amount);
    }

    function testMintParameterAndModifier() public {
        address notOwner = makeAddr("notOwner");
        // test notOwner call Mint
        vm.startPrank(notOwner);
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount, notOwner));
        erc20Example.mint(notOwner, 100);
        vm.stopPrank();
        
        // test blackList
        vm.startPrank(owner);
        vm.expectRevert(abi.encodeWithSelector(InvalidAddress, user2));
        erc20Example.mint(user2, 100);

        // test amount
        vm.expectRevert(abi.encodeWithSelector(InvaildAmount, user1, 0));
        erc20Example.mint(user1, 0);

        // test paused
        erc20Example.pause();
        vm.expectRevert();
        erc20Example.mint(user1, 100);
        erc20Example.unpause();
        erc20Example.mint(user1, 100);
        assertEq(erc20Example.balanceOf(user1), 100);
        vm.stopPrank();
    }

    function testBurn() public {
        uint256 amount = 100;

        vm.startPrank(owner);
        erc20Example.mint(user1, amount);
        erc20Example.mint(user3, amount);

        assertEq(erc20Example.totalSupply(), amount + amount);
        assertEq(erc20Example.balanceOf(user1), amount);
        assertEq(erc20Example.balanceOf(user3), amount);

        // test Burn
        vm.expectEmit(true, true, false, false);
        emit Burn(user1, amount);
        erc20Example.burn(user1, amount);
        vm.stopPrank();

        assertEq(erc20Example.balanceOf(user1), 0);
        assertEq(erc20Example.balanceOf(user3), amount);
        assertEq(erc20Example.totalSupply(), amount);
    }

    function testBurnParameterAndModifier() public {
        address notOwner = makeAddr("notOwner");
        // test notOwner call burn
        vm.startPrank(notOwner);
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount, notOwner));
        erc20Example.burn(notOwner, 100);
        vm.stopPrank();

        // test blackList
        vm.startPrank(owner);
        vm.expectRevert(abi.encodeWithSelector(InvalidAddress, user2));
        erc20Example.burn(user2, 100);
        
        // mint first
        uint256 amount = 100;
        erc20Example.mint(user1, amount);
        assertEq(erc20Example.balanceOf(user1), amount);

        // test invaild amount
        vm.expectRevert(abi.encodeWithSelector(InvaildAmount, user1, amount + 10));
        erc20Example.burn(user1, amount + 10);

        // test paused
        erc20Example.pause();
        vm.expectRevert();
        erc20Example.burn(user1, amount);
        erc20Example.unpause();
        erc20Example.burn(user1, amount);
        assertEq(erc20Example.balanceOf(user1), 0);
        vm.stopPrank();
    }

    function testTransfer() public {
        uint256 amount = 100;
        // mint first
        vm.startPrank(owner);
        erc20Example.mint(user1, amount);
        assertEq(erc20Example.balanceOf(user1), amount);
        erc20Example.removeBlackList(user2);
        erc20Example.mint(user2, amount);
        erc20Example.addBlackList(user2);
        assertEq(erc20Example.balanceOf(user2), amount);
        vm.stopPrank();

        // test transfer 
        vm.startPrank(user1);
        vm.expectEmit(true, true, true, false);
        emit Transfer(user1, user3, amount);
        erc20Example.transfer(user3, amount);
        assertEq(erc20Example.balanceOf(user1), 0);
        assertEq(erc20Example.balanceOf(user3), amount);
        vm.stopPrank();
    }

    function testTransferModifier() public {
        uint256 amount = 100;
        // mint first
        vm.startPrank(owner);
        erc20Example.mint(user1, amount);
        assertEq(erc20Example.balanceOf(user1), amount);
        erc20Example.removeBlackList(user2);
        erc20Example.mint(user2, amount);
        erc20Example.addBlackList(user2);
        assertEq(erc20Example.balanceOf(user2), amount);
        vm.stopPrank();


        // test blackList
        vm.startPrank(user2);
        vm.expectRevert(abi.encodeWithSelector(InvalidAddress, user2));
        erc20Example.transfer(user1, amount);
        vm.stopPrank();

        // test paused
        vm.prank(owner);
        erc20Example.pause();

        vm.startPrank(user1);
        vm.expectRevert();
        erc20Example.transfer(user3, amount);
        vm.stopPrank();

        vm.prank(owner);
        erc20Example.unpause();

    }

    function testTransferFrom() public {
        uint256 amount = 100;
        // mint first
        vm.startPrank(owner);
        erc20Example.mint(user1, amount);
        assertEq(erc20Example.balanceOf(user1), amount);
        erc20Example.removeBlackList(user2);
        erc20Example.mint(user2, amount);
        erc20Example.addBlackList(user2);
        assertEq(erc20Example.balanceOf(user2), amount);
        vm.stopPrank();

        address spender = makeAddr("spender");

        vm.prank(user1);
        erc20Example.approve(spender, amount);

        // test transferFrom
        vm.startPrank(spender);
        vm.expectEmit(true, true, true, false);
        emit Transfer(user1, user3, amount);
        erc20Example.transferFrom(user1, user3, amount);
        assertEq(erc20Example.balanceOf(user1), 0);
        assertEq(erc20Example.balanceOf(user3), amount);
        vm.stopPrank();
    }

    function testTransferFromModifier() public {
        uint256 amount = 100;
        // mint first
        vm.startPrank(owner);
        erc20Example.mint(user1, amount);
        assertEq(erc20Example.balanceOf(user1), amount);
        erc20Example.removeBlackList(user2);
        erc20Example.mint(user2, amount);
        erc20Example.addBlackList(user2);
        assertEq(erc20Example.balanceOf(user2), amount);
        vm.stopPrank();

        address spender = makeAddr("spender");

        vm.prank(user1);
        erc20Example.approve(spender, amount);
        vm.prank(user2);
        erc20Example.approve(spender, amount);

        // test blackList
        vm.startPrank(spender);
        vm.expectRevert(abi.encodeWithSelector(InvalidAddress, user2));
        erc20Example.transferFrom(user2, user3, amount);
        vm.stopPrank();

        // test paused
        vm.prank(owner);
        erc20Example.pause();

        vm.startPrank(spender);
        vm.expectRevert();
        erc20Example.transferFrom(user1, user3, amount);
        vm.stopPrank();

        vm.prank(owner);
        erc20Example.unpause();
    }

}