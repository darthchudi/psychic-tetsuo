// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/utils/Counters.sol";

// PsychicTetsuoEP is an ERC721 token for Tetsuo's psychic powers project.
contract PsychicTetsuo is ERC721URIStorage {
    using Counters for Counters.Counter;

    // Owner of the project
    address payable public owner;

    // Contract state
    Counters.Counter private _tokenIds;
    mapping(string => string) private _tokenURIBySongID;
    mapping(string => bool) private _mintedSongs;

    // Token supply
    uint256 _maxMintableSongs = 5;
    uint256 _maxMintableSongsPerWallet = 1;

    constructor() ERC721("Psychic Tetsuo", "PSYCH") {
        owner = payable(msg.sender);

        _tokenURIBySongID["song-summer-love"] = "ipfs://";
        _tokenURIBySongID["song-23"] = "ipfs://";
        _tokenURIBySongID["song-yellow-nails"] = "ipfs://";
        _tokenURIBySongID["song-sunlight"] = "ipfs://";
        _tokenURIBySongID["song-time"] = "ipfs://";
    }

    /**
     * @dev Emitted when a new token is minted.
     */
    event Mint(address indexed to, uint256 indexed tokenId);

    /**
     * @dev Mints a new token representing a song in the EP
     */
    function mint(string memory songID) public payable returns (uint256) {
        require(
            _tokenIds.current() < _maxMintableSongs,
            "All songs have been minted"
        );
        require(
            balanceOf(msg.sender) < _maxMintableSongsPerWallet,
            "You have already minted the maximum number of songs allowed for each wallet"
        );

        // Get the token URI of the song
        string memory tokenURI = _tokenURIBySongID[songID];
        require(bytes(tokenURI).length != 0, "Song doesn't exist in the project");

        // assert that this song hasn't been minted already
        bool isMinted = _mintedSongs[songID];
        require(!isMinted, "Song has already been minted");

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        // mark the song as minted
        _mintedSongs[songID] = true;

        emit Mint(msg.sender, tokenId);

        return tokenId;
    }
}
