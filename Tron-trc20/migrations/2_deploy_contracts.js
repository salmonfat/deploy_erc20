// /*---------------trc20 uups proxy contract + logic contract-----------------*/
// const UUPSProxy = artifacts.require("./TronUUPSProxy");
// const UUPSTRC20ExampleV1 = artifacts.require("./UUPSTRC20ExampleV1");
// const web3ABI = require('web3-eth-abi');
// module.exports = async function (deployer) {
//   await deployer.deploy(UUPSTRC20ExampleV1);
//   const data = web3ABI.encodeFunctionCall({
//     name: 'initialize',
//     type: 'function',
//     inputs: [
//       {
//         type: 'string',
//         name: 'name'
//       },
//       {
//         type: 'string',
//         name: 'symbol'
//       }
//     ]
//     },['Trc20 UUPS', "TUUPS"]);
//   await deployer.deploy(UUPSProxy, UUPSTRC20ExampleV1.address, data);
// }

// /*---------------trc20 contract-----------------*/
// const UUPSTRC20ExampleV1 = artifacts.require("./UUPSTRC20ExampleV1");
// module.exports = async function (deployer) {
//     await deployer.deploy(UUPSTRC20ExampleV1);
//     const trc20 = await UUPSTRC20ExampleV1.deployed();
//     trc20.initialize("Trc20 Logic", "TL");
// }
