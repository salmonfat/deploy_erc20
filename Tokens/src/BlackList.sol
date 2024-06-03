// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "./Ownable.sol";

abstract contract BlackList is Ownable{
    error InvalidAddress(address target);

    event Blacklisted(address indexed target);
    event UnBlacklisted(address indexed target);

    mapping (address => bool) public blackList;
    
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