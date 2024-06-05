pragma solidity ^0.8.26;


contract ERC20ExampleV1Storage {
    string public version;
    bool public paused;
    mapping (address => bool) public blackList;
}