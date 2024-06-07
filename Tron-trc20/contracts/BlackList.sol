// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./TRC20Storage.sol";

abstract contract BlackList is OwnableUpgradeable, TRC20ExampleV1Storage{
    error InvalidAddress(address target);

    event Blacklisted(address indexed target);
    event UnBlacklisted(address indexed target);
    
    modifier isNotBlackListed(address _maker) {
        if(blackList[_maker]){
            revert InvalidAddress(_maker);
        }
        _;
    }

    function getBlackListStatus(address _maker) external view returns (bool) {
        return blackList[_maker];
    }

    function addBlackList (address _evilUser) public onlyOwner {
        blackList[_evilUser] = true;
        emit Blacklisted(_evilUser);
    }

    function removeBlackList (address _clearedUser) public onlyOwner {
        blackList[_clearedUser] = false;
        emit UnBlacklisted(_clearedUser);
    }

}