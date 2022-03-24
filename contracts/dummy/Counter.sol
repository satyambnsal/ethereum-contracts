// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Counter {
    uint256 public counter = 0;

    function get() public view returns (uint256) {
        return counter;
    }

    function inc() public {
        counter = counter + 1;
    }

    function dec() public {
        counter = counter - 1;
    }
}
