// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ERC721Tradable.sol";

contract WeWereHere is ERC721Tradable {
    constructor(address _proxyRegistryAddress)
        ERC721Tradable("WeWereHere", "WWH", _proxyRegistryAddress)
    {}

    function baseTokenURI() public pure override returns (string memory) {
        return "https://godfatherapi.herokuapp.com/api/token/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://godfatherapi.herokuapp.com/api/contracts/wewerehere";
    }
}
