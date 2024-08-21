// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract HashStorage {
    bytes32 public storedHash;

    function storeHash(string memory _input) public {
        storedHash = keccak256(abi.encodePacked(_input));
    }
}
