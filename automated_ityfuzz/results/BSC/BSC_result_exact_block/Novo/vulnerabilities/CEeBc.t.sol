// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xEeBc161437FA948AAb99383142564160c92D2974,0xa0787daad6062349f63b7c228cbfd5d8a3db08f1,0x3463a663de4ccc59c8b21190f81027096f18cf2a,0x6Fb2020C236BBD5a7DDEb07E14c9298642253333,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D -c bsc --onchain-block-number 18225002 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x927a100bcb00553138c6cfa22a4d3a8dbe1156d7" to 0xf48f2b2d2a534e402487b3ee7c18c33aec0fe5e4
================ Trace ================
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0x927A100BCB00553138C6CFA22A4d3A8dbe1156D7.Stepping with return: 2830783234323532343234323432343932666664643234666630306666323330663235323464643230666329()
   │  │  └─ ← ()


 */

contract CEeBc is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 18225002);
    }

    function test() public {

    }

    // Stepping with return
    receive() external payable {}
}

