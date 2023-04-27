// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Router02.sol";

contract IDO {
    // IDO details
    uint256 public startDateTime; 
    uint256 public endDateTime;
    uint256 public cap; 
    address[] public whitelist; 
    address public owner; 
    
    // Uniswap router
    IUniswapV2Router02 public router;

    constructor(uint256 _startDateTime, uint256 _endDateTime, uint256 _cap, address[] memory _whitelist, address _owner, address _routerAddress) {
        startDateTime = _startDateTime;
        endDateTime = _endDateTime;
        cap = _cap;
        whitelist = _whitelist;
        owner = _owner;
        router = IUniswapV2Router02(_routerAddress);
    }

    /**
     * @dev Creates the IDO and sells tokens to participants.
     */
    function createIDO() external {
        // Check if IDO has started
        require(block.timestamp >= startDateTime, "IDO: not started yet");

        // Check if IDO has ended
        require(block.timestamp <= endDateTime, "IDO: already ended");

        // Check if IDO cap has been reached
        require(address(this).balance <= cap, "IDO: cap reached");

        // Check if participant is authorized to participate in the IDO
        require(isAuthorized(msg.sender), "IDO: not authorized");

        // TODO: Implement IDO logic
        
        // Transfer ownership of remaining tokens to owner
        selfdestruct(payable(owner));
    }

    /**
     * @dev Checks whether a participant is authorized to participate in the IDO.
     * @param _participant The address of the participant.
     */
    function isAuthorized(address _participant) public view returns (bool) {
        for (uint256 i = 0; i < whitelist.length; i++) {
            if (whitelist[i] == _participant) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Updates the cap of the IDO.
     * @param _cap The new cap.
     */
    function updateCap(uint256 _cap) external {
        require(msg.sender == owner, "IDO: not authorized");
        cap = _cap;
    }

    /**
     * @dev Updates the whitelist of the IDO.
     * @param _whitelist The new whitelist.
     */
    function updateWhitelist(address[] memory _whitelist) external {
        require(msg.sender == owner, "IDO: not authorized");
        whitelist = _whitelist;
    }
}
