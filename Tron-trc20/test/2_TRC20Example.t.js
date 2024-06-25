const UUPSProxy = artifacts.require('TronUUPSProxy');
const UUPSTRC20ExampleV1 = artifacts.require('UUPSTRC20ExampleV1');
const TB_coin = artifacts.require('TB_coin');

// contract('TRC20 function test', async function (deployer) {
//     let instance
//     let proxy
//     let instance
    
//     beforeEach(async () => {
//         instance = await UUPSTRC20ExampleV1.deployed();
//         proxy = await UUPSProxy.deployed(instance.address,"0x");
//         instance = await UUPSTRC20ExampleV1.at(proxy.address);
//       });

//     it('check mint & burn', async () => {
//         let total_supply 
//         let balance
//         total_supply =await instance.totalSupply()
//         assert.equal(total_supply.toNumber(),0);
//         await instance.mint(deployer[0],100,{from: deployer[0]})
//         total_supply =await instance.totalSupply()
//         balance=await instance.balanceOf(deployer[0])
//         assert.equal(total_supply.toNumber(),100);
//         assert.equal(balance.toNumber(),100);
//         await instance.burn(deployer[0],100,{from: deployer[0]})
//         total_supply =await instance.totalSupply()
//         balance=await instance.balanceOf(deployer[0])
//         assert.equal(total_supply.toNumber(),0);
//         assert.equal(balance.toNumber(),0);
//       });

//     it('check transfer', async () => {
//         let balance_a
//         let balance_b
//         await instance.mint(deployer[0],100,{from: deployer[0]})
//         await instance.transfer(deployer[1],50,{from: deployer[0]})
//         balance_a=await instance.balanceOf(deployer[0])
//         balance_b=await instance.balanceOf(deployer[1])
//         assert.equal(balance_a.toNumber(),50);
//         assert.equal(balance_b.toNumber(),50);
//       }); 
      
//     it('approve & transferFrom', async () => {
//         let balance_a
//         let balance_c
//         let allowence
//         await instance.approve(deployer[1],100,{from: deployer[0]})
//         allowence=await instance.allowance(deployer[0],deployer[1])
//         assert.equal(allowence.toNumber(),100);
//         await instance.transferFrom(deployer[0],deployer[2],50,{from: deployer[1]})
//         allowence=await instance.allowance(deployer[0],deployer[1])
//         balance_a=await instance.balanceOf(deployer[0])
//         balance_c=await instance.balanceOf(deployer[2])
//         assert.equal(allowence.toNumber(),50);
//         assert.equal(balance_a.toNumber(),0);
//         assert.equal(balance_c.toNumber(),50);
//       });
      
//     it('not owner mint & burn', async () => {
//         let balance_b
//         try
//         {
//             await instance.mint(deployer[1],100,{from: deployer[1]})
//         }
//             catch(error)
//         {
//             assert.include(error.message, 'revert', 'Expected revert error');
//         }
//         balance_b=await instance.balanceOf(deployer[1])
//         assert.equal(balance_b.toNumber(),50);
//         try
//         {
//             await instance.burn(deployer[1],50,{from: deployer[1]})
//         }
//             catch(error)
//         {
//             assert.include(error.message, 'revert', 'Expected revert error');
//         }
//         balance_b=await instance.balanceOf(deployer[1])
//         assert.equal(balance_b.toNumber(),50);
//       }); 

//     it('no allowence transferFrom', async () => {
//         let balance_a
//         let balance_c
//         try
//         {
//             await instance.transferFrom(deployer[2],deployer[0],50,{from: deployer[0]})
//         }
//             catch(error)
//         {
//             assert.include(error.message, 'revert', 'Expected revert error');
//         }
//         balance_a=await instance.balanceOf(deployer[0])
//         balance_c=await instance.balanceOf(deployer[2])
//         assert.equal(balance_a.toNumber(),0);
//         assert.equal(balance_c.toNumber(),50);
//       });
// });

contract('TRC20 function test', async function (deployer) {
    let instance
    
    beforeEach(async () => {
        instance = await TB_coin.deployed();
      });

    it('check mint & burn', async () => {
        let total_supply 
        let balance
        total_supply =await instance.totalSupply()
        assert.equal(total_supply.toNumber(),0);
        await instance.mint(deployer[0],100,{from: deployer[0]})
        total_supply =await instance.totalSupply()
        balance=await instance.balanceOf(deployer[0])
        assert.equal(total_supply.toNumber(),100);
        assert.equal(balance.toNumber(),100);
        await instance.burn(deployer[0],100,{from: deployer[0]})
        total_supply =await instance.totalSupply()
        balance=await instance.balanceOf(deployer[0])
        assert.equal(total_supply.toNumber(),0);
        assert.equal(balance.toNumber(),0);
      });

    it('check transfer', async () => {
        let balance_a
        let balance_b
        await instance.mint(deployer[0],100,{from: deployer[0]})
        await instance.transfer(deployer[1],50,{from: deployer[0]})
        balance_a=await instance.balanceOf(deployer[0])
        balance_b=await instance.balanceOf(deployer[1])
        assert.equal(balance_a.toNumber(),50);
        assert.equal(balance_b.toNumber(),50);
      }); 
      
    it('approve & transferFrom', async () => {
        let balance_a
        let balance_c
        let allowence
        await instance.approve(deployer[1],100,{from: deployer[0]})
        allowence=await instance.allowance(deployer[0],deployer[1])
        assert.equal(allowence.toNumber(),100);
        await instance.transferFrom(deployer[0],deployer[2],50,{from: deployer[1]})
        allowence=await instance.allowance(deployer[0],deployer[1])
        balance_a=await instance.balanceOf(deployer[0])
        balance_c=await instance.balanceOf(deployer[2])
        assert.equal(allowence.toNumber(),50);
        assert.equal(balance_a.toNumber(),0);
        assert.equal(balance_c.toNumber(),50);
      });
      
    it('not owner mint & burn', async () => {
        let balance_b
        try
        {
            await instance.mint(deployer[1],100,{from: deployer[1]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_b=await instance.balanceOf(deployer[1])
        assert.equal(balance_b.toNumber(),50);
        try
        {
            await instance.burn(deployer[1],50,{from: deployer[1]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_b=await instance.balanceOf(deployer[1])
        assert.equal(balance_b.toNumber(),50);
      }); 

    it('no allowence transferFrom', async () => {
        let balance_a
        let balance_c
        try
        {
            await instance.transferFrom(deployer[2],deployer[0],50,{from: deployer[0]})
        }
            catch(error)
        {
            assert.include(error.message, 'revert', 'Expected revert error');
        }
        balance_a=await instance.balanceOf(deployer[0])
        balance_c=await instance.balanceOf(deployer[2])
        assert.equal(balance_a.toNumber(),0);
        assert.equal(balance_c.toNumber(),50);
      });
});