/*---------------trc20 uups proxy contract + logic contract-----------------*/
// const UUPSProxy = artifacts.require("./TronUUPSProxy");
// const UUPSTRC20ExampleV1 = artifacts.require("./UUPSTRC20ExampleV1");
// const UUPSTRC20ExampleV2 = artifacts.require('./UUPSTRC20ExampleV2');
// const web3ABI = require('web3-eth-abi');
// module.exports = async function (deployer) {
//   await deployer.deploy(UUPSTRC20ExampleV1);
//   // await deployer.deploy(UUPSTRC20ExampleV2);
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
//     },['TB coin', "TB"]);
//   await deployer.deploy(UUPSProxy, UUPSTRC20ExampleV1.address, data);
// }

// /*---------------trc20 contract-----------------*/
// const UUPSTRC20ExampleV1 = artifacts.require("./UUPSTRC20ExampleV1");
// module.exports = async function (deployer) {
//     await deployer.deploy(UUPSTRC20ExampleV1);
//     const trc20 = await UUPSTRC20ExampleV1.deployed();
//     trc20.initialize("Trc20 Logic", "TL");
// }

// /*---------------trc20 contract no proxy-----------------*/
const TB_coin = artifacts.require("./TB_coin");
module.exports = async function (deployer) {
    await deployer.deploy(TB_coin,"TB coin","TB");
}