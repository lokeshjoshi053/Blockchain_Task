// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract IDO is Ownable {
    /**
     * @dev Function to transfer funds to a specific address
     * @param _recipient The address to transfer funds to
     * @param _amount The amount to transfer
     */
    function transferIDOFund(address payable _recipient, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "IDO: insufficient funds");
        require(_recipient != address(0), "IDO: invalid recipient");

        _recipient.transfer(_amount);
    }
}
