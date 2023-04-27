// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract IDO is Ownable {
uint256 public startDateTime; 
uint256 public endDateTime; 
uint256 public cap; 
address[] public whitelist; 
mapping(address => uint256) public contributions; 
address payable private owner_;

IUniswapV2Router02 public router; 

constructor(
    uint256 _startDateTime,
    uint256 _endDateTime,
    uint256 _cap,
    address[] memory _whitelist,
    address payable _owner,
    address _routerAddress
) {
    startDateTime = _startDateTime;
    endDateTime = _endDateTime;
    cap = _cap;
    whitelist = _whitelist;
    owner_ = _owner;
    router = IUniswapV2Router02(_routerAddress); // initialize the Uniswap router contract
}

/**
 * @dev Function to fund the IDO
 */
function fundIDO() external payable {
    require(block.timestamp >= startDateTime, "IDO: not started yet");
    require(block.timestamp <= endDateTime, "IDO: already ended");
    require(contributions[msg.sender] + msg.value <= cap, "IDO: cap reached");

    // check if the sender is whitelisted
    bool isWhitelisted = false;
    for (uint256 i = 0; i < whitelist.length; i++) {
        if (msg.sender == whitelist[i]) {
            isWhitelisted = true;
            break;
        }
    }
    require(isWhitelisted, "IDO: sender not whitelisted");

    contributions[msg.sender] += msg.value;
    if (contributions[msg.sender] >= cap) {
        // remove the sender from the whitelist if they reach the cap
        for (uint256 i = 0; i < whitelist.length; i++) {
            if (msg.sender == whitelist[i]) {
                whitelist[i] = whitelist[whitelist.length - 1];
                whitelist.pop();
                break;
            }
        }
    }

    // transfer the ETH to the owner
    (bool success, ) = owner_.call{value: msg.value}("");
    require(success, "IDO: transfer failed");
}
}