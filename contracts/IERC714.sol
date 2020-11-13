// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "./IERC20.sol";

interface IERC714 is IERC20 {
    /**
     *  @dev Returns the amount of tokens in existence by multiplying _limit and _presalePrice.
        @param _limit total amount of ETH allowed raised
        @param _presalePrice price per token. If _presalePrice is 30 then for 1 ETH you would recieve
        30 tokens.
     */
    function totalSupply(uint256 _limit, uint256 _presalePrice)
        external
        view
        returns (uint256);

    /**
     * @dev Allows the sale of a large quainty of tokens between two large staker holders. This will
        allow larger stake holders to exit NOT on the normal market, This making smaller stake holders
        not subjected to the potential market movement from this transaction. Same approval / allowance
        checks should be put in place.
        @param _to address of the recipient.
        @param _from address of sender.
        @param value Amount of Tokens looking to be transfered.
     */
    function _whaleTransfer(
        address _to,
        address _from,
        uint256 value
    ) external returns (bool);

    /**
     *  @dev Creates token and issues amount of tokens to _to address. Must check to make sure amount
        requsted does not fall into "whale" status. As well as checking amount to limit. If limit is 
        reached, function _mint should become disabled and the pre-sale is then declared over.
        @param _to address of person purchasing the tokens.
        @param amount amount of eth that is being sent in exchange for tokens
        @param _limit The ETH hard cap of the presale
     */
    function _mint(
        address _to,
        uint256 amount,
        uint256 _limit
    ) external returns (bool);

    /**
     *  @dev Creates token and issues it a whale. whale status will be deterimed by total liqudity 
        to tokens held. If the person can move the market more that say 50% from a sell off, their 
        tokens must remained locked in the contract. This making it harder for one person to 
        manipulate the market. However, sybil attacks still have the potential to be thing. Just a 
        check to make it a harder
        @param _to address of person purchasing the tokens.
        @param amount amount of eth that is being sent in exchange for tokens
        @param _limit The ETH hard cap of the presale
     */
    function _mintWhale(
        address _to,
        uint256 amount,
        uint256 _limit
    ) external returns (bool);

    /**
     *  @dev Pays out set amount of ETH to team when the correct time is hit. Time can be incermented
        in terms of month. A variable that has "accurate time" should be kept within the function to 
        make sure pay_out_time passed is viable.
        @param pay_out_time current unix stand time stamp. Checked against 
        block.timestamp + accurate time within the contract
        @param team address of the team that recieves payout
     */
    function pay_out_to_team(uint256 pay_out_time, address payable team)
        external;
}
