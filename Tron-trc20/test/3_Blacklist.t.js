const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');
const TB_coin = artifacts.require('TB_coin');

// contract('blacklist test', async function (deployer) {
//     let instance
//     let proxy
//     let instance
    
//     beforeEach(async () => {
//         instance = await UUPSTRC20ExampleV1.deployed();
//         proxy = await UUPSProxy.deployed(instance.address,"0x");
//         instance = await UUPSTRC20ExampleV1.at(proxy.address);
//       });

//     it('set & remove blacklist & unable to transfer when in blacklist', async () => {
//         await instance.mint(deployer[3],100,{from: deployer[0]})
//         await instance.addBlackList(deployer[3],{from: deployer[0]})
//         assert.equal(await instance.getBlackListStatus(deployer[3]),true);
//         try
//         {
//           await instance.transfer(deployer[0],100,{from: deployer[3]})
//         }
//             catch(error)
//         {
//             assert.include(error.message, 'revert', 'Expected revert error');
//         }
//         let balance_d=await instance.balanceOf(deployer[3])
//         assert.equal(balance_d.toNumber(),100);
//         await instance.removeBlackList(deployer[3],{from: deployer[0]})
//         assert.equal(await instance.getBlackListStatus(deployer[3]),false);
//         await instance.burn(deployer[3],100,{from: deployer[0]})
//       });      
// });

contract('blacklist test', async function (deployer) {
  let instance
  
  beforeEach(async () => {
      instance = await TB_coin.deployed();
    });

  it('set & remove blacklist & unable to transfer when in blacklist', async () => {
      await instance.mint(deployer[3],100,{from: deployer[0]})
      await instance.addBlackList(deployer[3],{from: deployer[0]})
      assert.equal(await instance.getBlackListStatus(deployer[3]),true);
      try
      {
        await instance.transfer(deployer[0],100,{from: deployer[3]})
      }
          catch(error)
      {
          assert.include(error.message, 'revert', 'Expected revert error');
      }
      let balance_d=await instance.balanceOf(deployer[3])
      assert.equal(balance_d.toNumber(),100);
      await instance.removeBlackList(deployer[3],{from: deployer[0]})
      assert.equal(await instance.getBlackListStatus(deployer[3]),false);
      await instance.burn(deployer[3],100,{from: deployer[0]})
    });      
});