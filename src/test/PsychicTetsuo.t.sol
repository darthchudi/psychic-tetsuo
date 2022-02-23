// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import {PsychicTetsuo} from "../PsychicTetsuo.sol";
import "openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";


contract PsychicTetsuoTest is DSTest, ERC721Holder {
    PsychicTetsuo public psychicTetsuo; 

    function setUp() public {
        psychicTetsuo = new PsychicTetsuo();
    }

    function testMetadata() public {
        assertEq(psychicTetsuo.name(), "Psychic Tetsuo");
        assertEq(psychicTetsuo.symbol(), "PSYCH");
    }

    function testMint() public {
       uint256 tokenId = psychicTetsuo.mint("ipfs://");
        assertEq(uint(tokenId), 1);
    }

    function testFailMintMoreThanOneSongPerWallet() public {
        // first mint
       psychicTetsuo.mint("ipfs://");
        
        // attempt to mint again from the same wallet
        psychicTetsuo.mint("ipfs://");
    }
}