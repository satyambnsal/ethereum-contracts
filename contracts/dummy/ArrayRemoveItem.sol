//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract ArrayRemoveItem {
    uint256[] public arr;

    function removeItem(uint256 _index) public {
        require(_index < arr.length, "Invalid index");

        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        removeItem(2);
        assert(arr.length == 4);
        assert(arr[0] == 1);
        assert(arr[1] == 20);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
    }
}
