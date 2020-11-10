// SPDX-License-Identifier: MIT
pragma solidity =0.7.4;

import "./SafeMath.sol";
import "./IERC714.sol";

//abstract for now until everything on Interface is impleneted.
abstract contract ERC714 is IERC714 {
    using SafeMath for uint256;

    address owner; 
    
    string public name = "Kyle Coin";
    string public symbol = "KYLE";
    
    mapping (address => uint256) public balanceOf;
    
    uint public totalSupply = 7140000000;
    
    bool public mintingFinished = false;
    
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier isMinting() {
        require(!mintingFinished);
        _;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balanceOf[msg.sender]);
        require(to != address(0));

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
       // emit Transfer(msg.sender, to, value);
        return true;
  }

    function approve(address _spender, uint256 _value) public view returns (bool) {
        require(_spender != address(0));
        require(_value <= balanceOf[_spender]);

        // emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function mint(address _receiver, uint256 _amount) internal isMinting {
        //Check for valid transactions before sending. 

        totalSupply = totalSupply.add(_amount);
        balanceOf[_receiver].add(_amount);

        //Need to add check to update mintingFinished once totalSupply is reached

    }

    function transferOwnership(address newOwner) public onlyOwner {
        //Check is vaild

        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

}