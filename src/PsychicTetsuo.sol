// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/utils/Counters.sol";

// PsychicTetsuoEP is an ERC721 token for Tetsuo's psychic powers project.
contract PsychicTetsuo is ERC721URIStorage {
    // Owner of the project
    address payable public owner;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    uint _maxMintableSongs = 5;
    uint _maxMintableSongsPerWallet = 1;

    constructor() ERC721("Psychic Tetsuo", "PSYCH"){
        owner = payable(msg.sender);
    }

    /**
    * @dev Emitted when a new token is minted.
    */
    event Mint(address indexed to, uint256 indexed tokenId);

    /**
    * @dev Mints a new token representing a song in the EP
    */
    function mint(string memory tokenURI) payable public returns (uint256) {
        require(_tokenIds.current() < _maxMintableSongs, "All songs have been minted");
        require(balanceOf(msg.sender) < _maxMintableSongsPerWallet, "You have already minted the maximum number of songs allowed for each wallet");

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        emit Mint(msg.sender, tokenId);

        return tokenId;
    }
}
