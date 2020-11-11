const Token = artifacts.require("ERC714");

module.exports = function (deployer) {
  deployer.deploy(Token, "0x9795D52176e5DEa38D2b27B57A0b7480032a0E0c");
};
