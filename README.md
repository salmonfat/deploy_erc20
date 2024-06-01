# 執行腳本

``` shell
forge script script/ERC20.s.sol                                                                                                                     
```

# 合約發布

## 配置環境變量

 modify .env.example to .env
```
SEPOLIA_RPC_URL=[YOUR_SEPOLIA_RPC_URL]
OWNER_PRIVATE_KEY=[YOUR_PRIVATE_KEY]
ETHERSCAN_API_KEY=[YOUR_ETHERSCAN_API_KEY]
```

* SEPOLIA_RPC_URL: 在alchemy上創建帳號取得api key, 網址: https://www.alchemy.com
* OWNER_PRIVATE_KEY: 在錢包中可以取得私鑰
* ETHERSCAN_API_KEY: 在etherscan上創建帳號取得api key, 網址: https://etherscan.io

## 執行發布腳本

execute forge script to deploy contract on Sepolia testnet
``` shell
# 先把 .env 讀到 shell 裡面, 否則命令行吃不到
export $(grep -v '^#' .env | xargs)
# 執行合約發布腳本
forge script script/ERC20NewScript.s.sol:Erc20NewScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```