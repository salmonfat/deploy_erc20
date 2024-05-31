// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Pausable.sol";
import "./BlackList.sol";


contract ERC20Example is ERC20, Pausable, BlackList {
    error InvaildAmount(address target, uint256 amount);

    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);

    constructor(
        string memory _name, 
        string memory _symbol) ERC20(_name, _symbol) Ownable(msg.sender) {
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


}