pragma solidity ^0.7.0;

// Import Vault interface, error messages, and library for decoding join/exit data.
import "@balancer-labs/v2-interfaces/contracts/solidity-utils/helpers/BalancerErrors.sol";
import "@balancer-labs/v2-interfaces/contracts/solidity-utils/openzeppelin/IERC20.sol";
import "@balancer-labs/v2-interfaces/contracts/pool-weighted/WeightedPoolUserData.sol";
import "@balancer-labs/v2-interfaces/contracts/vault/IVault.sol";
import "@balancer-labs/v2-interfaces/contracts/vault/IAsset.sol";

// Import ERC20Helpers for `_asIAsset`
import "@balancer-labs/v2-solidity-utils/contracts/helpers/ERC20Helpers.sol";

interface IWeightedPool{
}

contract JoinBalancerPool {
    IVault private constant vault = "0xBA12222222228d8Ba445958a75a0704d566BF2C8";
    IERC20 public underlyingToken = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    //Address of weightedPool
    address weightedPool =  ;
 
    uint public amount = 1000000000000000000;

    function joinBalancerPool(bytes32 poolId, address sender, address recipient, uint256[] memory amountsIn, uint256 minBptAmountOut) external {
        (IERC20[] memory tokens, , ) = vault.getPoolTokens(poolId);

        // Use BalancerErrors to validate input
        _require(amountsIn.length == tokens.length, Errors.INPUT_LENGTH_MISMATCH);

        // Encode the userData for a multi-token join
        bytes memory userData = abi.encode(WeightedPoolUserData.JoinKind.EXACT_TOKENS_IN_FOR_BPT_OUT, amountsIn, minBptAmountOut);

        IVault.JoinPoolRequest memory request = IVault.JoinPoolRequest({
            assets: _asIAsset(tokens),
            maxAmountsIn: amountsIn,
            userData: userData,
            fromInternalBalance: false
        });

        // Call the Vault to join the pool
        vault.joinPool(poolId, sender, recipient, request);
    }

    function joinBalancerPool(bytes32 poolId, address sender, address recipient, uint256[] memory amountsIn, uint256 minBptAmountOut) external {
        (IERC20[] memory tokens, , ) = vault.getPoolTokens(poolId);

        // Use BalancerErrors to validate input
        _require(amountsIn.length == tokens.length, Errors.INPUT_LENGTH_MISMATCH);

        // Encode the userData for a multi-token join
        bytes memory userData = abi.encode(WeightedPoolUserData.JoinKind.EXACT_TOKENS_IN_FOR_BPT_OUT, amountsIn, minBptAmountOut);

        IVault.JoinPoolRequest memory request = IVault.JoinPoolRequest({
            assets: _asIAsset(tokens),
            maxAmountsIn: amountsIn,
            userData: userData,
            fromInternalBalance: false
        });

        // Call the Vault to join the pool
        vault.joinPool(poolId, sender, recipient, request);
    }

    function returnData(bytes32 poolId) public view returns(IERC20[] memory){
        (IERC20[] memory tokens, , ) = vault.getPoolTokens(poolId);
    }
    
     function exitBalancerPool(bytes32 poolId, address sender, address recipient, uint256 minAmountOut) external {
        (IERC20[] memory tokens, , ) = vault.getPoolTokens(poolId);

        uint256 bptAmountIn = IWeightedPool(weightedPool).balanceOf(address(this));
        // Encode the userData for a multi-token join
        bytes memory userData = abi.encode(WeightedPoolUserData.ExitKind.EXACT_BPT_IN_FOR_TOKENS_OUT, bptAmountIn);

        IVault.JoinPoolRequest memory request = IVault.JoinPoolRequest({
            assets: _asIAsset(tokens),
            maxAmountsIn: minAmountOut,
            userData: userData,
            fromInternalBalance: false
        });

        // Call the Vault to join the pool
        vault.ExitPool(poolId, sender, recipient, request);
    }

    function weightCheck() public view returns(uint Balance){
        uint Balance;
        Balance = IWeightedPool(weightedpool).balanceOf(address(this));
        return balance;
    }

}
