pragma solidity ^0.8.22;


contract ERC20ExampleV1Storage {
    string public version;
    bool public paused;
    mapping (address => bool) public blackList;
}