// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinProcessing {
    mapping(address => uint256) public balances;

    event Deposit(address indexed _from, uint256 _amount);
    event Withdraw(address indexed _to, uint256 _amount);

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
        emit Withdraw(msg.sender, _amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
