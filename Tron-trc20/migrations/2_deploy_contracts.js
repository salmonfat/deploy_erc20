const UUPSProxy = artifacts.require("./TronUUPSProxy");
const UUPSTRC20ExampleV1 = artifacts.require("./UUPSTRC20ExampleV1");
const web3ABI = require('web3-eth-abi');
module.exports = async function (deployer) {
  await deployer.deploy(UUPSTRC20ExampleV1);
  const data = web3ABI.encodeFunctionCall({
    name: 'initialize',
    type: 'function',
    inputs: [
      {
        type: 'string',
        name: 'name'
      },
      {
        type: 'string',
        name: 'symbol'
      }
    ]
    },['Trc20 UUPS', "TUUPS"]);
  await deployer.deploy(UUPSProxy, UUPSTRC20ExampleV1.address, data);
}

