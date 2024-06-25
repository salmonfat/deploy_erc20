const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');
const TB_coin = artifacts.require('TB_coin');

// contract('pausable test', async function (deployer) {
//     let instance
//     let proxy
//     let instance
    
//     beforeEach(async () => {
//         instance = await UUPSTRC20ExampleV1.deployed();
//         proxy = await UUPSProxy.deployed(instance.address,"0x");
//         instance = await UUPSTRC20ExampleV1.at(proxy.address);
//       });

//     it('set pause & unable to transaction', async () => {
//         await instance.pause({from: deployer[0]})
//         try
//         {
//             await instance.mint(deployer[0],100,{from: deployer[0]})
//         }
//             catch(error)
//         {
//             assert.include(error.message, 'revert', 'Expected revert error');
//         }
//         let balance =await instance.balanceOf(deployer[0])
//         assert.equal(balance.toNumber(),0)
//         await instance.unpause({from: deployer[0]})
//       });      
// });

contract('pausable test', async function (deployer) {
    let instance
    
    beforeEach(async () => {
        instance = await TB_coin.deployed();
      });

    it('set pause & unable to transaction', async () => {
        await instance.pause({from: deployer[0]})
        try
        {
            await instance.mint(deployer[0],100,{from: deployer[0]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        let balance =await instance.balanceOf(deployer[0])
        assert.equal(balance.toNumber(),0)
        await instance.unpause({from: deployer[0]})
      });      
});