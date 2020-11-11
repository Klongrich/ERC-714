const Token = artifacts.require("./ERC714.sol");
const {
  expectRevert,
  time,
  BN,
  ether,
  balance,
} = require("@openzeppelin/test-helpers");
require("chai").use(require("chai-as-promised")).should();

contract(
  "Token",
  ([
    owner,
    team,
    personOne,
    personTwo,
    personThree,
    ErrorBetterOne,
    ErrorBetterTwo,
  ]) => {
    let token;

    before(async () => {
      token = await Token.deployed();
    });

    describe("deployment", async () => {
      it("deploys successfully", async () => {
        const address = await token.address;
        assert.notEqual(address, 0x0);
        assert.notEqual(address, "");
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
      });
    });

    describe("Error Handleing", async () => {
      let OverDeposit = web3.utils.toWei("40", "Ether");
      let NormalDeposit = web3.utils.toWei("1", "Ether");
      let Account_Balance;

      it("Handling Over deposit", async () => {
        await expectRevert(
          await token.mint({ from: personOne, value: OverDeposit }),
          "revert"
        );
      });

      it("Won't allow non team address to call payout", async () => {
        await expectRevert(
          await token.pay_out_to_team({ from: personOne }),
          "Caller is not team"
        );
      });

      it("Deposits succesfully", async () => {
        let balance;

        await token.mint({ from: personTwo, value: NormalDeposit });
        balance = await token.balanceOf(personTwo);
        console.log(web3.utils.fromWei(balance.toString()), ether);
      });

      it("Deposits Twice succesfully", async () => {
        let balance;

        await token.mint({ from: personTwo, value: NormalDeposit });
        balance = await token.balanceOf(personTwo);
        console.log(web3.utils.fromWei(balance.toString()), ether);
      });

      it("Will Transfer", async () => {
        let balance;
        let amount_to_transfer = web3.utils.toWei("3", "Ether");

        await token.transfer(personThree, amount_to_transfer, {
          from: personTwo,
        });
        balance = await token.balanceOf(personThree);
        console.log(web3.utils.fromWei(balance.toString()), ether);
      });

      it("Testing Payout", async () => {
        let res;
        let account_balance;

        res = await token.pay_out_to_team({ from: team });

        account_balance = await web3.eth.getBalance(team);

        console.log(account_balance / 1000000000000000000);
      });

      it("Testing Time", async () => {
        let time;

        time = await token.getTimeStamp();
        console.log(time.toString());
      });
    });
  }
);
