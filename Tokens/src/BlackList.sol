pragma solidity ^0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BlackList is Ownable{
    mapping (address => bool) public blackList;

    event Blacklisted(address indexed target);
    event UnBlacklisted(address indexed target);

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