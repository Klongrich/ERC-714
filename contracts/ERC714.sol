pragma solidity =0.7.4;

import "./SafeMath.sol";
import "./IERC714.sol";

//abstract for now until everything on Interface is impleneted.
abstract contract ERC714 is IERC714 {
    using SafeMath for uint256;

    address owner;
    
    string public override name = "Kyle Coin";
    string public override symbol = "KYLE";

    uint256 public override totalSupply;
    bool public mintingFinished = false;
    
    mapping (address => uint256) private _balances;

    event Mint(address indexed to, uint256 amount);
    event MintFinished();

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

    function approve(address _spender, uint256 _value) override public returns (bool) {
        require(_spender != address(0));
        require(_value <= _balances[_spender]);

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function mint(address _receiver, uint256 _amount) internal isMinting{
        //Check for valid transactions before sending. 

        totalSupply = totalSupply.add(_amount);
        _balances[_receiver].add(_amount);

        //Need to add check to update mintingFinished once totalSupply is reached

    }

    function transferOwnership(address newOwner) public onlyOwner {
        //Check is vaild

        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

}