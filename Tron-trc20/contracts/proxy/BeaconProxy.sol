// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract TronBeaconProxy is BeaconProxy {
    constructor(address _beacon, bytes memory _data) BeaconProxy(_beacon, _data) {}
}