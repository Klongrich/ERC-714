// SPDX-License-Identifier: MIT
pragma solidity =0.7.4; 

import "./SafeMath.sol";

contract ERC714 {
    using SafeMath for uint256;

    address owner; 
    address payable team;
    
    string public name = "Kyle Coin";
    string public symbol = "KYLE";
    uint8 public decimals = 18;

    mapping (address => uint256) public balanceOf;
    
    uint public totalSupply;
    //30 ETH limit for testing
    //1 ETH = 1000000000000000000
    uint public supplyLimit = 900000000000000000000;
    
    bool public payoutFinished = false;
    bool public mintingFinished = false;
    
    //30 coins for 1 ETH
    uint public price = 30;

    uint public pay_out_date = block.timestamp;
    
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
    
    constructor (address payable _team) payable {
        owner = msg.sender;
        team = _team;
    }
    
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert("Caller is not the owner");
        }
        _;
    }

    modifier onlyTeam() {
        if (msg.sender != team) {
            revert("Caller is not team");
        }
        _;
    }

    modifier IsPayingOut() {
        // Change 10 ether to what paramters should be
        // Will most likley create a standard / static choice. 
        if (address(this).balance < 10 ether) {
            payoutFinished = false;
        }
        _;
    }
    
    receive() external payable {
        //Gets value in wei when calling msg.value
        //Called when ether is sent directly to the address
    }
    
    //Create Coins
    //Supply limit is the total amount of tokens they are selling
    function mint() public payable returns (bool) {
        require(msg.sender != address(0));
        uint tokens_purchased;
        tokens_purchased = msg.value * price;
        require(tokens_purchased + totalSupply < supplyLimit);
        totalSupply = totalSupply += tokens_purchased;
        balanceOf[msg.sender] += tokens_purchased;
        return (true);
    }
    
    //Allow Transfer of Coins
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balanceOf[msg.sender]);
        require(to != address(0));

        balanceOf[msg.sender] = balanceOf[msg.sender] - value;
        balanceOf[to] = balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        
        return true;
    }
    
    // Add in time stamps that would lock funds
    // Function can only be called by team to release funds once time has passed.
    // 1 hour = 3600
    // 1 day = 86400
    // 1 month = 2629743
    function pay_out_to_team() public onlyTeam IsPayingOut {
        if (block.timestamp < pay_out_date) {
             team.transfer(1 ether);
             pay_out_date += 2629732; // one month
        }
         team.transfer(1 ether);
    }

    function getTimeStamp() public view returns (uint) {
        return (block.timestamp);
    }
  
    //Hopping there is a easier way to do this
    //I am considering doing it in the migrations part. 
    function send_to_uinswap() public returns (bool) {
          
    }
    
}