//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Loop {
    uint256 public counter = 1;

    function loop() public {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }

            if (i == 5) {
                break;
            }
            counter *= i + 1;
        }
    }
}
