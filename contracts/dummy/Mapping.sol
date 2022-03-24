// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract ManageBalances {
    mapping(address => uint256) public balances;

    function setBalance(address _address, uint256 _balance) public {
        balances[_address] = _balance;
    }

    function getBalance(address _address) public view returns (uint256) {
        return balances[_address];
    }

    function deleteEntry(address _address) public {
        delete balances[_address];
    }
}
