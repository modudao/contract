// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

import "./interfaces/IFaucet.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MODUDAONFT is ERC721URIStorageUpgradeable, OwnableUpgradeable {
    uint256 public constant PRICE = 10 ether;
    address public constant FAUCET = 0xc85fcd35DCc28e2283354Cf4ED5D1f3299A90D18;
    string public constant METADATA_URL1 =
        "https://raw.githubusercontent.com/modudao/images/main/metadata1.json";
    string public constant METADATA_URL2 =
        "https://raw.githubusercontent.com/modudao/images/main/metadata2.json";
    string public constant METADATA_URL3 =
        "https://raw.githubusercontent.com/modudao/images/main/metadata3.json";
    string public constant METADATA_URL4 =
        "https://raw.githubusercontent.com/modudao/images/main/metadata4.json";

    uint256 public tokenCounter;
    string public matedataURI;

    mapping(address => bool) public hasPurchased;

    uint256[4] public votes;

    mapping(address => bool) public hasVoted;

    bool public hasVotedGovernance1;
    bool public hasVotedGovernance2;

    function initialize(
        string memory _name,
        string memory _symbol
    ) external initializer {
        __ERC721_init(_name, _symbol);
        __Ownable_init(_msgSender());

        matedataURI = "https://raw.githubusercontent.com/modudao/images/main/metadata.json";
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

            for (uint256 i = 0; i < 4; i++) {
                if (votes[i] > maxVotes) {
                    maxVotes = votes[i];
                    winningOptionIndex = i;
                }
            }

            if (winningOptionIndex == 0) {
                matedataURI = METADATA_URL1;
            } else if (winningOptionIndex == 1) {
                matedataURI = METADATA_URL2;
            } else if (winningOptionIndex == 2) {
                matedataURI = METADATA_URL3;
            } else if (winningOptionIndex == 3) {
                matedataURI = METADATA_URL4;
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
        
    }

    function resetNFT(uint256 tokenId, string memory newTokenURI) public {
        address nftOwner = ownerOf(tokenId);
        _burn(tokenId);

        matedataURI = newTokenURI;

        _safeMint(nftOwner, tokenId);
        _setTokenURI(tokenId, matedataURI);
    }

    // Manage Functions
    function reset() public {
        for (uint i = 0; i < tokenCounter; i++) {
            address nftOwner = ownerOf(i);
            if (nftOwner != address(0)) {
                _burn(i);
                delete hasPurchased[nftOwner];
            }
        }

        tokenCounter = 0;
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

    function getVotes() public view returns (uint256[4] memory) {
        return votes;
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
