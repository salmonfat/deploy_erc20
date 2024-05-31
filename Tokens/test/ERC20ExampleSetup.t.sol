pragma solidity ^0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Example} from "../src/ERC20Example.sol";
import {Erc20Script} from "../script/ERC20.s.sol";

contract ERC20ExampleSetupTest is Test, Erc20Script {
    bytes4 constant OwnableUnauthorizedAccount = bytes4(keccak256("OwnableUnauthorizedAccount(address)"));
    bytes4 constant InvaildAmount = bytes4(keccak256("InvaildAmount(address,uint256)"));
    bytes4 constant InvalidAddress = bytes4(keccak256("InvalidAddress(address)"));

    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);

    event Transfer(address indexed from, address indexed to, uint256 value);
    

    ERC20Example erc20Example;
    address owner; 
    address user1;
    // user2 is blacklisted
    address user2;
    address user3 = makeAddr("user3");

    function setUp() public virtual {
        run();
        erc20Example = erc20;
        owner = sender;
        user1 = randomAddr1;
        user2 = randomAddr2;
        assertNotEq(address(erc20Example), address(0));
        assertTrue(erc20Example.owner() == owner);
    }

}
