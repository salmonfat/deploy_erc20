pragma solidity ^0.8.26;


import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./ERC20Storage.sol";

abstract contract Pausable is OwnableUpgradeable, ERC20ExampleV1Storage {

    event Pause();
    event Unpause();

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused() {
        require(paused);
        _;
    }

    function pause() public onlyOwner whenNotPaused {
        paused = true;
        emit Pause();
    }

    function unpause() public onlyOwner whenPaused {
        paused = false;
        emit Unpause();
    }
}