const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');

contract('blacklist test', async function (deployer) {
    let instance
    let proxy
    let proxyContract
    
    beforeEach(async () => {
        instance = await UUPSTRC20ExampleV1.deployed();
        proxy = await UUPSProxy.deployed(instance.address,"0x");
        proxyContract = await UUPSTRC20ExampleV1.at(proxy.address);
      });

    it('set & remove blacklist & unable to transfer when in blacklist', async () => {
        await proxyContract.mint(deployer[3],100,{from: deployer[0]})
        await proxyContract.addBlackList(deployer[3],{from: deployer[0]})
        assert.equal(await proxyContract.getBlackListStatus(deployer[3]),true);
        try
        {
          await proxyContract.transfer(deployer[0],100,{from: deployer[3]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        let balance_d=await proxyContract.balanceOf(deployer[3])
        assert.equal(balance_d.toNumber(),100);
        await proxyContract.removeBlackList(deployer[3],{from: deployer[0]})
        assert.equal(await proxyContract.getBlackListStatus(deployer[3]),false);
        await proxyContract.burn(deployer[3],100,{from: deployer[0]})
      });      
});