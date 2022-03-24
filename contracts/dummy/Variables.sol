//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Variables {
    string public text = "Satyam Bansal";
    uint256 public num = 1994;

    event TakeIt(uint256 ts, address sender);

    function doSomething() public {
        uint256 i = 256;
        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
        emit TakeIt(timestamp, sender);
    }
}
