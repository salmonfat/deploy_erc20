pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Erc20Example is ERC20, Pausable, BlackList {


    constructor(
        string memory _name, 
        string memory _symbol) ERC20(_name, _symbol) Ownable(msg.sender) {
    }


}