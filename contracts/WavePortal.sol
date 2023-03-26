// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    event NewWave(address indexed from, uint256 timestamp, string message);
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }
    Wave[] waves;

    constructor() payable{
        console.log("I AM SMART CONTRACT. POG.");
    }

    function wave(string memory _message) public {
        totalWaves+=1;
        console.log("%s has waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.002 ether;
        require (prizeAmount <= address(this).balance, "Insufficent funds in the contract");
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    
    function getTotalWaves() public view returns(uint) {
        console.log("Total waves count: %d", totalWaves);
        return totalWaves;
    }
}