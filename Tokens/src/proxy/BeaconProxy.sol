pragma solidity ^0.8.22;

import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract BeaconProxyExample is BeaconProxy{

   constructor(address _beacon, bytes memory _data) BeaconProxy(_beacon, _data) {}
}