// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ownable.sol";

abstract contract Pausable is Ownable {
    bool public paused;

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