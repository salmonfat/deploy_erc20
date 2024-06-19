const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');

contract('init test', async function (deployer) {
    let instance
    let proxy
    let proxyContract
    
    beforeEach(async () => {
        instance = await UUPSTRC20ExampleV1.deployed();
        proxy = await UUPSProxy.deployed(instance.address,"0x");
        proxyContract = await UUPSTRC20ExampleV1.at(proxy.address);
      });

    it('check init', async () => {
        assert.equal(await proxyContract.decimals(),6);
        assert.equal(await proxyContract._name(),'TB coin');
        assert.equal(await proxyContract.symbol(),"TB");
      });      
});