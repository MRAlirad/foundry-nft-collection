// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNFT()  {}
    
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        
    }
}