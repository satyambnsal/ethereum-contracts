//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract EtherUnits {
    uint256 public oneWei = 1 wei;
    bool public isOneWei = oneWei == 1;

    uint256 public oneEther = 1 ether;
    bool public isOneEther = oneEther == 1e18;
}
