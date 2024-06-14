// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./BlackList.sol";
import "./Pausable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract TRC20ExampleV1 is ERC20Upgradeable, Pausable, BlackList{
    error InvaildAmount(address target, uint256 amount);
    
    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);
    
    function initialize(
        string memory name_,
        string memory symbol_) public initializer {
        // init ERC20
        __ERC20_init(name_, symbol_);

        // set admin owner
        __Ownable_init();

        // set paused to false
        paused = false;

        // set version
        version = "v0.0.1";
    }



    // when user deposit, mint the same amount of ERC20 token
    function mint(address to, uint amount) public whenNotPaused onlyOwner isNotBlackListed(to) {
        if(!(amount > 0)) {
            revert InvaildAmount(to, amount);
        }

        _mint(to, amount);
        emit Mint(to, amount);
    }

    // when user withdraw, burn the same amount of ERC20 token
    function burn(address to, uint amount) public whenNotPaused onlyOwner isNotBlackListed(to) {
        if(!(balanceOf(to) >= amount)) {
            revert InvaildAmount(to, amount);
        }

        _burn(to, amount);
        emit Burn(to, amount);
    }

    function transfer(address to, uint256 value) public override whenNotPaused isNotBlackListed(msg.sender) returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public override whenNotPaused isNotBlackListed(from) isNotBlackListed(to) returns (bool) {
        return super.transferFrom(from, to, value);
    }


}