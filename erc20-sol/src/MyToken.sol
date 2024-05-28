// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is Initializable, ERC20 {
    
    /// @dev Since we are using the standard non-upgradable implementation of ERC-20,
    /// we need to call the constructor of the logic contract here. We don't want to
    /// manage the name and symbol state variables in this contract, so we will hardcode
    /// their values in the getters provided below.
    constructor()
        ERC20("MyToken", "MTK")
    {
        _disableInitializers();
    }

    /// @dev Initializes the contract by minting 1M tokens to the deployer 
    function initialize() initializer public {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }

    /// @dev Permissionless minting function
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    /// @dev Getters for the name and symbol of the token, hardcoded to simplify things
    /// (we don't want to manage those state variables in this contract)
    function name() public view virtual override returns (string memory) {
        return "MyToken";
    }
    
    function symbol() public view virtual override returns (string memory) {
        return "MTK";
    }
}