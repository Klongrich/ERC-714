const Token = artifacts.require("ERC714");

module.exports = function (deployer) {
  deployer.deploy(Token);
};
