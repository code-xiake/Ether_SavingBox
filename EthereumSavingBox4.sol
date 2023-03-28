// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/security/ReentrancyGuard.sol";

contract SavingBox is ReentrancyGuard {
    address owner;
    uint256 withdrawalLimit;
    
    constructor() {
        owner = 0xa1B94ef0f24d7F4fd02285EFcb9202E6C6EC655B;
        withdrawalLimit = 0;
    }
    
    receive() external payable {}
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function setWithdrawalLimit(uint256 _limit) public {
        require(msg.sender == owner, "Only the owner can set the withdrawal limit.");
        withdrawalLimit = _limit;
    }
    
    function withdraw(uint256 _amount) public nonReentrant payable {
        require(msg.sender == owner, "Only the owner can withdraw.");
        require(getBalance() >= _amount && (_amount <= withdrawalLimit || withdrawalLimit == 0), "Insufficient balance to withdraw or withdrawal limit exceeded.");
        payable(owner).transfer(_amount);
    }
}
