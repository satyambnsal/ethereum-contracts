//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Immutables {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_LUCKY_NO;

    constructor(uint256 _luckyNo) {
        MY_ADDRESS = msg.sender;
        MY_LUCKY_NO = _luckyNo;
    }
}
