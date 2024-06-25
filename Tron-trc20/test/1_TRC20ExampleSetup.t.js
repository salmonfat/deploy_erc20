const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');
const TB_coin = artifacts.require('TB_coin');

contract('init test', async function (deployer) {
    let instance
    
    beforeEach(async () => {
        instance = await TB_coin.deployed();
      });

    it('check init', async () => {
        assert.equal(await instance.decimals(),6);
        assert.equal(await instance._name(),'TB coin');
        assert.equal(await instance.symbol(),"TB");
      });      
});