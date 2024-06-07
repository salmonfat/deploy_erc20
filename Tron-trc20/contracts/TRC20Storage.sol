// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TRC20ExampleV1Storage {
    string internal version;
    bool internal paused;
    mapping (address => bool) internal blackList;
}