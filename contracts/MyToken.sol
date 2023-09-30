// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    uint128 private price = 600;

    constructor(string memory _name, string memory _symbol) ERC20("TobiasPerel", "TP") {    }

    event TransferToken (address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Sell(address indexed from, uint256 value);

    function totalSuply() public view returns (uint256) {
        return totalSupply() ; 
    }
    function balancOf(address account) public view returns (uint256) {
        return balanceOf(account);
    }
    function getName() public view returns (string memory) {
        return name();
    }
    function getSymbol() public view returns (string memory) {
        return symbol();
    }
    function getPrice() public view returns (uint128) {
        return price;
    }
    
    function transferToken(address to, uint256 value ) public returns (bool) {
        require(balanceOf(msg.sender) >= value, "ERC20: transfer amount exceeds balance");
        _transfer(msg.sender, to, value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function mint(address to, uint256 amount) external onlyOwner returns (bool){
        _mint(to, amount);
        emit Mint(to, amount);
        return true;
    }
    function sell(uint256 amount) external returns (bool){  
        require(balanceOf(msg.sender) >= amount, "ERC20: transfer amount exceeds balance");
        _burn(msg.sender, amount);
        emit Sell(msg.sender, amount);
        payable(msg.sender).transfer(amount * price;);
        return true;
    }
    function close() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
        selfdestruct(payable(owner()));
    }
    receive() external payable {   }
    fallback() external payable {
        payable(address(this)).transfer(msg.value);
    }
}
