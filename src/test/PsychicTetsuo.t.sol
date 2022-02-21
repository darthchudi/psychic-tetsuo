// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import {PsychicTetsuo} from "../PsychicTetsuo.sol";

contract PsychicTetsuoTest is DSTest {
    PsychicTetsuo public psychicTetsuo; 

    function setup() public {
        psychicTetsuo = new PsychicTetsuo();
    }

    function testMetadata() public {
        assertEq(psychicTetsuo.name(), "Psychic Tetsuo");
        assertEq(psychicTetsuo.symbol(), "PSYCH");
    }

    function testMint() public {
       uint256 tokenId = psychicTetsuo.mint("");
        assertEq(uint(tokenId), uint(1));
    }
}