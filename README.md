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

## 驗證合約

``` shell

# 若有 abi 要先取得 abi
abiConstruct=$(cast abi-encode "constructor(string,string)" "Erc Example Token" "EET")

forge verify-contract --chain-id 11155111 --etherscan-api-key $ETHERSCAN_API_KEY $DEPLOYED_CONTRACT_ADDRESS CONTRACT_PATH:CONTRACT_NAME
# example:
#     forge verify-contract --chain-id 11155111 --etherscan-api-key $ETHERSCAN_API_KEY 0xF999Bb94294b537cd423Cd61cda016482cd602A9 src/ERC20Example.sol:ERC20Example
#     forge verify-contract --chain-id 11155111 --etherscan-api-key $ETHERSCAN_API_KEY 0xF999Bb94294b537cd423Cd61cda016482cd602A9 src/ERC20Example.sol:ERC20Example --constructor-args $abiConstruct



forge verify-check --chain-id 11155111 <GUID> <your_etherscan_api_key>
# example:
#     forge verify-check --chain-id 11155111 8xec7ecrt5rqyhzjpmhizwffcsnt3hzebqra3arxcgapw168ny $ETHERSCAN_API_KEY
```


## Beacon Proxy Script
```
 forge script script/BeaconProxy.s.sol:BeaconProxyScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
 ```

 example contract address:
 * BeaconProxy address:  0x8467fAb05fC2C9e779636FA28f63bD4b9219D21C
 * BeaconProxy2 address:  0x6fDEeb588f4FdEf5090FC7DAaA22087aaD2F904c
 * UpgradeableBeacon address:  0x3890A2933e5B529B6074C5B8da564e043Ef7f224
 * ERC20Example address:  0x3AF582e97A2A776Accad692DffeB732ABA168ae2
