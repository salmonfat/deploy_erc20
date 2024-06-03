// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "./Pausable.sol";
import "./BlackList.sol";
import "./ERC20.sol";


contract ERC20ExampleV1 is ERC20, Pausable, BlackList{
    error InvaildAmount(address target, uint256 amount);

    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);

    bool public _initialized;
    uint8 public _initializedVersion;
    
    function initialize(
        string memory name_,
        string memory symbol_) external  {
        require(!_initialized && _initializedVersion == 0, "Contract instance has already been initialized");

        // set erc20 name and symbol
        _name = name_;
        _symbol = symbol_;

        // set admin owner
        if (msg.sender == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(msg.sender);

        // set paused to false
        paused = false;

        // set initialized to true
        _initialized = true;

        // set initialized version
        _initializedVersion = 1;
    }

    // 當用户存入时，mint等量的ERC20代幣
    function mint(address to, uint amount) public whenNotPaused onlyOwner isNotBlackListed(to) {
        if(!(amount > 0)) {
            revert InvaildAmount(to, amount);
        }

        _mint(to, amount);
        emit Mint(to, amount);
    }

    // 當用戶提款用户，burn等量ERC20代幣
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

    function version() public pure returns (string memory) {
        return "v0.0.1";
    }


}