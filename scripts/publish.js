const fs = require("fs")

const publishDirs = ["/Users/satyam/dump/dumb-web3-scaffold/packages/frontend/contracts"];

function publishContract(contractName, contract, address, networkName = "hardhat", deployVersion = "v1") {
  try {
    publishDirs.forEach((publishDir) => {
      const networkPublishDir = `${publishDir}/${networkName}/${deployVersion}/`
      if (!fs.existsSync(networkPublishDir)) {
        fs.mkdirSync(networkPublishDir, { recursive: true });
      }
      fs.writeFileSync(
        `${networkPublishDir}/${contractName}.address.ts`,
        `export const address = "${address}";`
      );
      fs.writeFileSync(
        `${networkPublishDir}/${contractName}.abi.ts`,
        `export const abi = ${JSON.stringify(contract.abi, null, 2)};`
      );
      fs.writeFileSync(
        `${networkPublishDir}/${contractName}.bytecode.js`,
        `export const bytecode = "${contract.bytecode}";`
      );
    });

    return true;
  } catch (e) {
    console.log("Failed to publish " + contractName + " to services.");
    console.log(e);
    return false;
  }
}

module.exports = {
  publishContract
}

