// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract HashStorage1000 {
    bytes32 public storedHash;

    function storeHash(string memory _input) public {
        bytes32 hash = keccak256(abi.encodePacked(_input));

        for (uint i = 0; i < 999; i++) {
            hash = keccak256(abi.encodePacked(hash));
        }

        storedHash = hash;
    }
}