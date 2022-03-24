//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract SimpleStorage {
    uint256 num;

    function set(uint256 _num) public {
        num = _num;
    }

    function get() public view returns (uint256) {
      return num;
    }
}
