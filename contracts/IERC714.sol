// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

interface IERC714 {
    /**
     *  @dev Returns the amount of tokens in existence.
        @param _limit total amount of ETH allowed raised
        @param _presalePrice price per token (eth / token) at inital price 
     */
    function totalSupply(uint256 _limit, uint256 _presalePrice)
        external
        view
        returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     * Returns a boolean value indicating whether the operation succeeded.
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     *  @dev Pays out set amount of ETH to team when the correct time is hit.
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
     *  @dev Pays out set amount of ETH to team when the correct time is hit.
        @param pay_out_time current unix stand time stamp. Checked against 
        block.timestamp + accurate time within the contract
        @param team address of the team that recieves payout
     */
    function pay_out_to_team(uint256 pay_out_time, address payable team)
        external;
}
