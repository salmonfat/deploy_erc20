pragma solidity ^0.8.22;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract UpgradeableBeaconExample is UpgradeableBeacon {
    constructor(address implementation_, address initialOwner) UpgradeableBeacon(implementation_, initialOwner) {}
}