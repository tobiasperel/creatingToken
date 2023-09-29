// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyToken is ERC20, Ownable {

    mapping (address => uint256) private balances;
    uint128 private price = 600 ether / 10 ** 18;

    constructor(string memory _name, string memory _symbol) ERC20("TobiasPerel", "TP") {    }

    event TransferToken (address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Sell(address indexed from, uint256 value);

    function totalSuply() public view returns (uint256) {
        return totalSupply() ; 
    }
    function balancOf(address account) public view returns (uint256) {
        return balances[account];
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
        require(balances[msg.sender] >= value, "ERC20: transfer amount exceeds balance");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function mint(address to, uint256 amount) external onlyOwner returns (bool){
        _mint(to, amount);
        balances[to] += amount;
        emit Mint(to, amount);
        return true;
    }
    function sell(uint256 amount) external returns (bool){  
        require(balances[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");
        _burn(msg.sender, amount);
        uint256 weiAmount = amount * price;
        balances[msg.sender] -= amount;
        emit Sell(msg.sender, amount);
        payable(msg.sender).transfer(weiAmount);
        return true;
    }

    function close() external onlyOwner {
        uint256 _amount = address(this).balance;
        payable(msg.sender).transfer(_amount);
        selfdestruct(payable(owner()));
    }
    
    receive() external payable {    }
    fallback() external payable {
        payable(address(this)).transfer(msg.value);
    }
}