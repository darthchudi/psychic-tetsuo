// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import {PsychicTetsuo} from "../PsychicTetsuo.sol";
import "openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

interface CheatCodes {
  function prank(address) external;
  function expectRevert(bytes calldata) external;
}

contract PsychicTetsuoTest is DSTest, ERC721Holder {
    CheatCodes public cheats = CheatCodes(HEVM_ADDRESS);

    PsychicTetsuo public psychicTetsuo;

    function setUp() public {
        psychicTetsuo = new PsychicTetsuo();
    }

    function testMetadata() public {
        assertEq(psychicTetsuo.name(), "Psychic Tetsuo");
        assertEq(psychicTetsuo.symbol(), "PSYCH");
    }

    function testMint() public {
        uint256 tokenId = psychicTetsuo.mint("song-summer-love");
        assertEq(uint256(tokenId), 1);
    }

    function testMintWithInvalidSongName() public {
        cheats.expectRevert(bytes("Song doesn't exist in the project"));
        psychicTetsuo.mint("808s and heartbreak");
    }

    function testMintMoreThanOneSongPerWallet() public {
        psychicTetsuo.mint("song-23");

        // attempt to mint another song from the same wallet
        cheats.expectRevert(bytes("You have already minted the maximum number of songs allowed for each wallet"));

        psychicTetsuo.mint("song-time");
    }

    function testMintAlreadyMintedSongs() public {
        // first mint
        psychicTetsuo.mint("song-yellow-nails");

        // attempt to mint the same song again from a different wallet
        cheats.expectRevert(bytes("Song has already been minted"));
        cheats.prank(address(HEVM_ADDRESS));

        psychicTetsuo.mint("song-yellow-nails");
    }
}
