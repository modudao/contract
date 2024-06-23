// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Faucet is OwnableUpgradeable {
    uint256 public constant CLAIM_AMOUNT = 11 ether;

    struct User {
        string nickname;
        address addr;
    }

    User[] public users;
    mapping(address => bool) private _claimed;
    mapping(address => string) private _addressToNickname;

    receive() external payable {}

    function initialize() external initializer {
        __Ownable_init(_msgSender());
    }

    // External Functions
    function distributeToUser(User memory user) public onlyOwner {
        require(
            address(this).balance >= CLAIM_AMOUNT,
            "Not enough ether in the faucet"
        );
        if (!_claimed[user.addr]) {
            _claimed[user.addr] = true;
            users.push(user);
            _addressToNickname[user.addr] = user.nickname;
            payable(user.addr).transfer(CLAIM_AMOUNT);
        }
    }

    function distributeToUsers(User[] memory newUsers) external onlyOwner {
        for (uint256 i = 0; i < newUsers.length; i++) {
            distributeToUser(newUsers[i]);
        }
    }

    function reset() external onlyOwner {
        for (uint256 i = 0; i < users.length; i++) {
            delete _claimed[users[i].addr];
            delete _addressToNickname[users[i].addr];
        }
        delete users;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // View Functions
    function getUsers() external view returns (User[] memory) {
        return users;
    }

    function getNickname(
        address userAddress
    ) external view returns (string memory) {
        return _addressToNickname[userAddress];
    }

    function isClaimed(address userAddress) external view returns (bool) {
        return _claimed[userAddress];
    }

    // Modifier
    modifier hasNotClaimed() {
        require(!_claimed[msg.sender], "You have already claimed your ether");
        _;
    }
}
