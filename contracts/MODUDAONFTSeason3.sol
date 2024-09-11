// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

import "./interfaces/IFaucet.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MODUDAONFTSeason3 is ERC721URIStorageUpgradeable, OwnableUpgradeable {
    uint256 public constant PRICE = 10 ether;
    address public constant FAUCET = 0x382F00221de389998D09b79255728B72aFe97469;
    string public constant METADATA_URL1 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata1.json";
    string public constant METADATA_URL2 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata2.json";
    string public constant METADATA_URL3 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata3.json";
    string public constant METADATA_URL4 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata4.json";
    string public constant METADATA_URL5 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata5.json";
    string public constant METADATA_URL6 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata6.json";
    string public constant METADATA_URL7 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata7.json";
    string public constant METADATA_URL8 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata8.json";
    string public constant METADATA_URL9 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata9.json";
    string public constant METADATA_URL10 =
        "https://raw.githubusercontent.com/modudao/images/main/season3/metadata10.json";
    address public constant address1 =
        0x89688481eBdf3254808C37787A92ED3C7D2E7038;
    address public constant address2 =
        0xAE2FCf6c2fC13b55Cca5b1e940280AeF099a6dc9;
    address public constant address3 =
        0x20576daeA51a122ef676B0c44d94BD17Ec77CC48;
    address public constant address4 =
        0xf0470FE7598ffEA5a0549eBb71B43d8DD985E648;
    address public constant address5 =
        0xFBE0956e7fdD853289365b01Af2Ecdc429A4fA7D;
    address public constant address6 =
        0x2590590fFB9e4BEb2bbEFF744BfF2D641B2De909;
    address public constant address7 =
        0x28f16CC8d967a3BC97A406FB0Ca59482343bb45c;
    address public constant address8 =
        0x8F831f41b3E7b00199D6FA2b35eB0fCf46eB1974;
    address public constant address9 =
        0x2A58fAe09a8a9f1d572990E420C2A5D5696fC29F;
    address public constant address10 =
        0xA6bA95a6dd5Fb8311Fd7CfBCFDD62436E1B0c45E;

    uint256 public tokenCounter;
    string public matedataURI;

    mapping(address => bool) public hasPurchased;

    uint256[10] public votes;

    mapping(address => bool) public hasVoted;
    address public proposer;
    uint256 public proposerAmount;
    bool public hasVotedGovernance1;

    uint256 public participantCount;
    mapping(uint256 => address) public participants;
    mapping(address => bool) public hasJoined;
    address public winner;
    uint256 public winnerAmount;
    bool public hasVotedGovernance2;

    function initialize(
        string memory _name,
        string memory _symbol
    ) external initializer {
        __ERC721_init(_name, _symbol);
        __Ownable_init(_msgSender());

        matedataURI = "https://raw.githubusercontent.com/modudao/images/main/season3/metadata.json";
    }

    // External Functions
    function mint() public payable {
        require(
            !hasPurchased[msg.sender],
            "You have already purchased a Membership NFT."
        );
        require(msg.value == PRICE, "Klay value sent is not correct.");

        _safeMint(msg.sender, tokenCounter);
        _setTokenURI(tokenCounter, matedataURI);
        hasPurchased[msg.sender] = true;
        tokenCounter++;
    }

    function vote(uint256 option) external {
        require(
            balanceOf(_msgSender()) != 0,
            "You have already purchased a Membership NFT."
        );
        require(!hasVoted[msg.sender], "You have already voted");
        require(!hasVotedGovernance1, "Vote ended");

        votes[option]++;
        hasVoted[msg.sender] = true;

        if (_msgSender() == 0x236dAea11e6E18867981c6c0e549a9e2b7a63f31) {
            uint256 maxVotes = 0;
            uint256 winningOptionIndex = 0;

            for (uint256 i = 0; i < 10; i++) {
                if (votes[i] > maxVotes) {
                    maxVotes = votes[i];
                    winningOptionIndex = i;
                }
            }

            proposerAmount = address(this).balance / 2;
            if (winningOptionIndex == 0) {
                matedataURI = METADATA_URL1;
                payable(address1).transfer(proposerAmount);
                proposer = address1;
            } else if (winningOptionIndex == 1) {
                matedataURI = METADATA_URL2;
                payable(address2).transfer(proposerAmount);
                proposer = address2;
            } else if (winningOptionIndex == 2) {
                matedataURI = METADATA_URL3;
                payable(address3).transfer(proposerAmount);
                proposer = address3;
            } else if (winningOptionIndex == 3) {
                matedataURI = METADATA_URL4;
                payable(address4).transfer(proposerAmount);
                proposer = address4;
            } else if (winningOptionIndex == 4) {
                matedataURI = METADATA_URL5;
                payable(address5).transfer(proposerAmount);
                proposer = address5;
            } else if (winningOptionIndex == 5) {
                matedataURI = METADATA_URL6;
                payable(address6).transfer(proposerAmount);
                proposer = address6;
            } else if (winningOptionIndex == 6) {
                matedataURI = METADATA_URL7;
                payable(address7).transfer(proposerAmount);
                proposer = address7;
            } else if (winningOptionIndex == 7) {
                matedataURI = METADATA_URL8;
                payable(address8).transfer(proposerAmount);
                proposer = address8;
            } else if (winningOptionIndex == 8) {
                matedataURI = METADATA_URL9;
                payable(address9).transfer(proposerAmount);
                proposer = address9;
            } else if (winningOptionIndex == 9) {
                matedataURI = METADATA_URL10;
                payable(address10).transfer(proposerAmount);
                proposer = address10;
            }
            for (uint i = 0; i < tokenCounter; i++) {
                address nftOwner = ownerOf(i);
                _burn(i);

                _safeMint(nftOwner, i);
                _setTokenURI(i, matedataURI);
            }

            hasVotedGovernance1 = true;
        }
    }

    function join() external {
        require(
            balanceOf(_msgSender()) != 0,
            "You have already purchased a Membership NFT."
        );
        require(!hasJoined[_msgSender()], "You have already joined");
        require(!hasVotedGovernance2, "Join ended");

        participants[participantCount] = _msgSender();
        participantCount++;
        hasJoined[_msgSender()] = true;

        if (_msgSender() == 0x236dAea11e6E18867981c6c0e549a9e2b7a63f31) {
            for (uint i = 0; i < tokenCounter; i++) {
                address nftOwner = ownerOf(i);
                if (!hasJoined[nftOwner]) {
                    payable(nftOwner).transfer(5 ether);
                }
            }
            uint256 randomIndex = uint256(
                keccak256(abi.encodePacked(block.timestamp, participantCount))
            ) % participantCount;
            winner = participants[randomIndex];
            winnerAmount = address(this).balance;
            payable(winner).transfer(winnerAmount);

            hasVotedGovernance2 = true;
        }
    }

    // Manage Functions
    function reset() public onlyOwner {
        for (uint i = 0; i < tokenCounter; i++) {
            address nftOwner = ownerOf(i);
            if (nftOwner != address(0)) {
                _burn(i);
                delete hasPurchased[nftOwner];
            }
        }

        tokenCounter = 0;
    }

    function resetMeataURL() external onlyOwner {
        matedataURI = "https://raw.githubusercontent.com/modudao/images/main/season3/metadata.json";

        for (uint i = 0; i < tokenCounter; i++) {
            address nftOwner = ownerOf(i);
            _burn(i);

            _safeMint(nftOwner, i);
            _setTokenURI(i, matedataURI);
        }
    }

    function transferEther(address toAddress) public onlyOwner {
        payable(toAddress).transfer(address(this).balance / 2);
    }

    // View Functions
    function getUsers() external view returns (address[] memory) {
        address[] memory users = new address[](tokenCounter);
        for (uint i = 0; i < tokenCounter; i++) {
            users[i] = ownerOf(i);
        }
        return users;
    }

    function getUsersNickname() external view returns (string[] memory) {
        string[] memory usersNickname = new string[](tokenCounter);
        for (uint i = 0; i < tokenCounter; i++) {
            usersNickname[i] = IFaucet(FAUCET).getNickname(ownerOf(i));
        }
        return usersNickname;
    }

    function getVotes() public view returns (uint256[10] memory) {
        return votes;
    }

    function getProposerNickname() external view returns (string memory) {
        return IFaucet(FAUCET).getNickname(proposer);
    }

    function getWinnerNickname() external view returns (string memory) {
        return IFaucet(FAUCET).getNickname(winner);
    }

    // Disable Functions
    function safeTransferFrom(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override(ERC721Upgradeable, IERC721) {
        revert("safeTransferFrom function is disabled");
    }

    function transferFrom(
        address,
        address,
        uint256
    ) public virtual override(ERC721Upgradeable, IERC721) {
        revert("transferFrom function is disabled");
    }
}
