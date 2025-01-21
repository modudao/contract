// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

import "./interfaces/IFaucet.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract RWANFTSeason4 is ERC721URIStorageUpgradeable, OwnableUpgradeable {
    uint256 public tokenCounter;
    string public matedataURI;

    address public constant FAUCET = 0x642662544F99E28E69FaD5ec175687aD168D34C0;

    function initialize(
        string memory _name,
        string memory _symbol
    ) external initializer {
        __ERC721_init(_name, _symbol);
        __Ownable_init(_msgSender());

        matedataURI = "https://raw.githubusercontent.com/modudao/images/main/season4/present-metadata.json";
    }

    // External Functions
    function mint() public {
        require(
            balanceOf(_msgSender()) == 0,
            "You have already receive a RWA NFT."
        );
        require(tokenCounter < 3, "TokenCounter must be less than 3.");

        _safeMint(msg.sender, tokenCounter);
        _setTokenURI(tokenCounter, matedataURI);
        tokenCounter++;
    }

    // Manage Functions
    function reset() public onlyOwner {
        for (uint i = 0; i < tokenCounter; i++) {
            address nftOwner = ownerOf(i);
            if (nftOwner != address(0)) _burn(i);
        }

        tokenCounter = 0;
    }

    function resetMeataURL() external onlyOwner {
        for (uint i = 0; i < tokenCounter; i++) {
            address nftOwner = ownerOf(i);
            _burn(i);

            _safeMint(nftOwner, i);
            _setTokenURI(i, matedataURI);
        }
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
