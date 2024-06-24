// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IFaucet {
    struct User {
        string nickname;
        address addr;
    }

    // View Functions
    function getUsers() external view returns (User[] memory);

    function getNickname(
        address userAddress
    ) external view returns (string memory);

    function isClaimed(address userAddress) external view returns (bool);
}
