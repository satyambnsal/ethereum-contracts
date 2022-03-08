// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  // const Greeter = await hre.ethers.getContractFactory("Greeter");
  // const greeter = await Greeter.deploy("Hello, Hardhat!");

  // await greeter.deployed();

  // console.log("Greeter deployed to:", greeter.address);

  const proposalNames = [
    "Yes.",
    "No.",
    "Restricted Access",
    "No Opinion"
  ].map(p => ethers.utils.formatBytes32String(p));
  // console.log(proposalNames);
  // const BallotV2 = await hre.ethers.getContractFactory("BallotV2");
  // const ballotV2 = await BallotV2.deploy(proposalNames)

  // await ballotV2.deployed();

  // console.log("Ballot deployed to:", ballotV2.address);

  // const GameItem = await hre.ethers.getContractFactory("GameItem");
  // const gameItem = await GameItem.deploy();
  // await gameItem.deployed();

  // console.log("GameItem deployed to:", gameItem.address);

  const GameItems = await hre.ethers.getContractFactory("GameItems");
  const gameItems = await GameItems.deploy();
  await gameItems.deployed();

  console.log("GameItems deployed to:", gameItems.address);

  // const initialSupply = 10 ** 6
  // const Rupay = await hre.ethers.getContractFactory("Rupay");
  // const rupay = await Rupay.deploy(initialSupply);
  // await rupay.deployed();
  // console.log("Rupay deployed to:", rupay.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
