pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {ERC20ExampleV1} from "src/ERC20ExampleV1.sol";
import {DeployScript} from "script/Deploy.s.sol";
import {TB_Dollar} from "src/TB_coin.sol";

contract ERC20ExampleSetupTest is Test, DeployScript {
    bytes4 constant OwnableUnauthorizedAccount = bytes4(keccak256("OwnableUnauthorizedAccount(address)"));
    bytes4 constant InvaildAmount = bytes4(keccak256("InvaildAmount(address,uint256)"));
    bytes4 constant InvalidAddress = bytes4(keccak256("InvalidAddress(address)"));

    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);

    event Transfer(address indexed from, address indexed to, uint256 value);
    

    // ERC20ExampleV1 erc20Example;
    TB_Dollar erc20Example;
    
    address owner; 
    address user1;
    // user2 is blacklisted
    address user2;
    address user3;

    function setUp() public virtual {
        run();

        // erc20Example = ERC20ExampleV1(address(beaconProxy));
        erc20Example = TB_Dollar(address(erc20));
        owner = sender;
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        user3 = makeAddr("user3");
    }


}
