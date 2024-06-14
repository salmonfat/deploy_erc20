// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract TronUpgradeableBeacon is UpgradeableBeacon {
    constructor(address _implementation) UpgradeableBeacon(_implementation) Ownable() {}
}