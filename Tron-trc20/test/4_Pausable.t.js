const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');

contract('pausable test', async function (deployer) {
    let instance
    let proxy
    let proxyContract
    
    beforeEach(async () => {
        instance = await UUPSTRC20ExampleV1.deployed();
        proxy = await UUPSProxy.deployed(instance.address,"0x");
        proxyContract = await UUPSTRC20ExampleV1.at(proxy.address);
      });

    it('set pause & unable to transaction', async () => {
        await proxyContract.pause({from: deployer[0]})
        try
        {
            await proxyContract.mint(deployer[0],100,{from: deployer[0]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        let balance =await proxyContract.balanceOf(deployer[0])
        assert.equal(balance.toNumber(),0)
        await proxyContract.unpause({from: deployer[0]})
      });      
});