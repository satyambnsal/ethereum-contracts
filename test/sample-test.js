const { expect } = require("chai");
const { ethers } = require("hardhat");
const { expectEvent, BN } = require("@openzeppelin/test-helpers");

describe.skip("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

describe.skip("Coin", function () {
  it("should be able to mint coins", async () => {
    const Coin = await ethers.getContractFactory("Coin");
    const coin = await Coin.deploy();
    await coin.deployed();

    const mintTx = await coin.mint(ethers.constants.AddressZero, 1008975);
    await mintTx.wait();

    console.log(mintTx);
    // console.log(coin.minter);
    // console.log(coin)
    const balance = await coin.balances(ethers.constants.AddressZero)
    expect(balance).to.equal(1008975);
  })
})

describe.skip("Ballot", function () {
  // Proposals related to Legality of Mariuana in India
  it("Should be able to create ballot", async () => {
    const proposalNames = [
      "Yes.",
      "No.",
      "Restricted Access",
      "No Opinion"
    ].map(p => ethers.utils.formatBytes32String(p));
    console.log(proposalNames);
    const Ballot = await ethers.getContractFactory("Ballot");
    const ballot = await Ballot.deploy(proposalNames)

    const accounts = (await ethers.getSigners()).map(account => account.address);
    console.log(accounts);

    for (let i = 1; i < accounts.length; i++) {
      const voteTx = await ballot.giveRightToVote(accounts[i]);
      await voteTx.wait();
      console.log(voteTx);
    }
  })
})


describe('GameItem', function () {

  let gameItem
  const tokenURI = "https://game.example/item-id-8u5h2m.json"

  beforeEach(async () => {
    const GameItem = await ethers.getContractFactory("GameItem");
    gameItem = await GameItem.deploy();
    await gameItem.deployed();
  })
  // console.log(accounts);
  it('Should be able to award item', async () => {
    const accounts = (await ethers.getSigners()).map(account => account.address);

    const tx = await gameItem.awardItem(accounts[1], tokenURI)
    await tx.wait()
    console.log(tx)

    // console.log({ acc1: accounts[0], acc2: accounts[2] })
    // expectEvent(tx, 'Transfer', {
    //   from: "0x0000000000000000000000000000000000000000",
    //   to: accounts[1],
    //   value: new BN(1)
    // })
    // const event = tx.logs
    // console.log(event)

    let tx1 = await gameItem.awardItem(accounts[1], "https://www.avc.json")
    tx1 = await gameItem.awardItem(accounts[3], "https://www.avc.json")
    tx1 = await gameItem.awardItem(accounts[1], "https://www.avc.json")
    tx1 = await gameItem.awardItem(accounts[3], "https://www.avc.json")
    tx1 = await gameItem.awardItem(accounts[1], "https://www.avc.json")


    // await tx1.wait()
    // console.log(tx1)
    // const data = parseInt(tx1.data)
    // console.log(data)

    const playerAddress = await gameItem.ownerOf(1)
    console.log(playerAddress)
    // expect(playerAddress).to.equal(accounts[0])
    const balance = await gameItem.balanceOf(accounts[1])

    const a = await gameItem.tokenOfOwnerByIndex(accounts[1], 2)
    console.log(a)
  })
})