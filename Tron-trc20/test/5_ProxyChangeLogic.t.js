const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');
const UUPSTRC20ExampleV2 = artifacts.require('UUPSTRC20ExampleV2');

contract('change logoc test', async function (deployer) {
    let instance
    let instance2
    let proxy
    let proxyContract
    
    beforeEach(async () => {
        instance = await UUPSTRC20ExampleV1.deployed();
        instance2 = await UUPSTRC20ExampleV2.deployed();
        proxy = await UUPSProxy.deployed(instance.address,"0x");
        proxyContract = await UUPSTRC20ExampleV1.at(proxy.address);
      });

    it('test change logic', async () => {
        try
        {
            await proxyContract.upgradeTo(instance2.address,{from: deployer[0]})
        }
            catch(error)
        {
            assert.include(error.message, 'REVERT', 'Expected revert error');
        }
        proxyContract = await UUPSTRC20ExampleV2.at(proxy.address);
        assert.equal(await proxyContract.hello(),"hello");
      });
      
});