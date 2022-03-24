const hre = require("hardhat")

async function main() {
  const proxyAddress = process.env.OPENSEA_RINKEBY_PROXY_ADDRESS
  if (!proxyAddress) {
    throw new Error("OPENSEA_RINKEBY_PROXY_ADDRESS is not set")
  }

  const WeWereHere = await hre.ethers.getContractFactory("WeWereHere")
  const weWereHere = await WeWereHere.deploy(proxyAddress)

  await weWereHere.deployed()

  console.log(`WeWereHere deployed to: ${weWereHere.address}`)
}

main()
  .catch(error => {
    console.error(error)
    process.exit(0)
  })