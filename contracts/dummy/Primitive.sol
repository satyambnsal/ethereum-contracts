//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Primitive {
    bool public foo = true;

    uint8 public rank = 99;
    uint256 public accNo = 53267989;
    uint256 public pincode = 476229;

    int8 public civilScore = -89;
    int256 public randomNo = 8982829;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5; //  [10110101]
    bytes1 b = 0x56; //  [01010110]

    // Default values
    // Unassigned variables have a default value
    bool public defaultBoo; // false
    uint256 public defaultUint; // 0
    int256 public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}
