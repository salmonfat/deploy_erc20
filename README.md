# Script



 modify .env.example to .env
```
SEPOLIA_RPC_URL=[YOUR_SEPOLIA_RPC_URL]
OWNER_PRIVATE_KEY=[YOUR_PRIVATE_KEY]
ETHERSCAN_API_KEY=[YOUR_ETHERSCAN_API_KEY]
```
    
execute forge script to deploy contract on Sepolia testnet
```
forge script script/ERC20NewScript.s.sol:Erc20NewScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```