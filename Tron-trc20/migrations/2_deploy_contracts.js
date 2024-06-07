const { deployBeacon, deployBeaconProxy } = require('@openzeppelin/truffle-upgrades');

const TRC20ExampleV1 = artifacts.require("./TRC20ExampleV1.sol");

module.exports = async function (deployer) {
  try {
    // Setup tronbox deployer
    deployer.trufflePlugin = true;
    const beacon = await deployBeacon(TRC20ExampleV1, { deployer });
    console.info('-Beacon deployed', beacon.address);
    const instance1 = await deployBeaconProxy(beacon, TRC20ExampleV1, ["Trc20 beacon","TB"], { deployer,  initializer: 'initialize'});
    console.info('-Deployed-1', instance1.address);
    const instance2 = await deployBeaconProxy(beacon, TRC20ExampleV1, ["Trc20 beacon22","TB22"], { deployer,  initializer: 'initialize'});
    console.info('-Deployed-2', instance2.address);

  } catch (error) {
    console.error('-Beacon: deploy box error', error);
  }
};