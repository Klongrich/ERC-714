import RouterABI from "./build/contracts/Router.json";

const Token = artifacts.require("ERC714");
var Router = require("web3-eth-contract");

// set provider for all later instances to use
Router.setProvider(
  "https://ropsten.infura.io/v3/90de6f047b6547e28b29b4b7176a5eea"
);

var router = new Router(
  RouterABI,
  "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D"
);

// Add liquidty paramters()

// address tokenA, //Address of ETH raised in smart contract
// address tokenB, //Address of ERC714 token to be added
// uint amountADesired,
// uint amountBDesired,
// uint amountAMin,
// uint amountBMin

router.methods._addLiquidity();

//Have to switch token to be lanuched on ropsten from either web3 wallet or local etheruem node.
//However I don't have much storage on this linux laptop so it kind of becomes a problem
//I'm far to lazy to update my distro.

module.exports = function (deployer) {
  deployer.deploy(Token, "0x9795D52176e5DEa38D2b27B57A0b7480032a0E0c");
};
