const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');

contract('TRC20 function test', async function (deployer) {
    let instance
    let proxy
    let proxyContract
    
    beforeEach(async () => {
        instance = await UUPSTRC20ExampleV1.deployed();
        proxy = await UUPSProxy.deployed(instance.address,"0x");
        proxyContract = await UUPSTRC20ExampleV1.at(proxy.address);
      });

    it('check mint & burn', async () => {
        let total_supply 
        let balance
        total_supply =await proxyContract.totalSupply()
        assert.equal(total_supply.toNumber(),0);
        await proxyContract.mint(deployer[0],100,{from: deployer[0]})
        total_supply =await proxyContract.totalSupply()
        balance=await proxyContract.balanceOf(deployer[0])
        assert.equal(total_supply.toNumber(),100);
        assert.equal(balance.toNumber(),100);
        await proxyContract.burn(deployer[0],100,{from: deployer[0]})
        total_supply =await proxyContract.totalSupply()
        balance=await proxyContract.balanceOf(deployer[0])
        assert.equal(total_supply.toNumber(),0);
        assert.equal(balance.toNumber(),0);
      });

    it('check transfer', async () => {
        let balance_a
        let balance_b
        await proxyContract.mint(deployer[0],100,{from: deployer[0]})
        await proxyContract.transfer(deployer[1],50,{from: deployer[0]})
        balance_a=await proxyContract.balanceOf(deployer[0])
        balance_b=await proxyContract.balanceOf(deployer[1])
        assert.equal(balance_a.toNumber(),50);
        assert.equal(balance_b.toNumber(),50);
      }); 
      
    it('approve & transferFrom', async () => {
        let balance_a
        let balance_c
        let allowence
        await proxyContract.approve(deployer[1],100,{from: deployer[0]})
        allowence=await proxyContract.allowance(deployer[0],deployer[1])
        assert.equal(allowence.toNumber(),100);
        await proxyContract.transferFrom(deployer[0],deployer[2],50,{from: deployer[1]})
        allowence=await proxyContract.allowance(deployer[0],deployer[1])
        balance_a=await proxyContract.balanceOf(deployer[0])
        balance_c=await proxyContract.balanceOf(deployer[2])
        assert.equal(allowence.toNumber(),50);
        assert.equal(balance_a.toNumber(),0);
        assert.equal(balance_c.toNumber(),50);
      });
      
    it('not owner mint & burn', async () => {
        let balance_b
        try
        {
            await proxyContract.mint(deployer[1],100,{from: deployer[1]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_b=await proxyContract.balanceOf(deployer[1])
        assert.equal(balance_b.toNumber(),50);
        try
        {
            await proxyContract.burn(deployer[1],50,{from: deployer[1]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_b=await proxyContract.balanceOf(deployer[1])
        assert.equal(balance_b.toNumber(),50);
      }); 

    it('no allowence transferFrom', async () => {
        let balance_a
        let balance_c
        try
        {
            await proxyContract.transferFrom(deployer[2],deployer[0],50,{from: deployer[0]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_a=await proxyContract.balanceOf(deployer[0])
        balance_c=await proxyContract.balanceOf(deployer[2])
        assert.equal(balance_a.toNumber(),0);
        assert.equal(balance_c.toNumber(),50);
      });
});