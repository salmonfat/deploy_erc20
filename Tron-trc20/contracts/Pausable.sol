// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./TRC20Storage.sol";

abstract contract Pausable is OwnableUpgradeable, TRC20ExampleV1Storage {

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