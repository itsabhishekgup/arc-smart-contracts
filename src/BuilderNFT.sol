// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BuilderNFT {
    string public name = "Arc Builder NFT";
    string public symbol = "ABNFT";

    address public owner;
    uint256 public nextTokenId;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    constructor() {
        owner = msg.sender;
    }

    function mint(address to, string memory uri) public returns (uint256) {
        require(msg.sender == owner, "Only owner can mint");
        require(to != address(0), "Invalid recipient");

        uint256 tokenId = nextTokenId;

        _owners[tokenId] = to;
        _balances[to] += 1;
        _tokenURIs[tokenId] = uri;

        nextTokenId += 1;

        emit Transfer(address(0), to, tokenId);

        return tokenId;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _owners[tokenId];
    }

    function balanceOf(address account) public view returns (uint256) {
        require(account != address(0), "Invalid address");
        return _balances[account];
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(to != address(0), "Invalid recipient");
        require(ownerOf(tokenId) == from, "Not token owner");
        require(msg.sender == from, "Not authorized");

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }
}
