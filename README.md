## Ethereum-container
[See at docker hub](https://hub.docker.com/repository/docker/siandreev/ethereum-rpc-test)

This container is designed to deploy the Ethereum blockchain private network.
#### PoA-mining tag
Two connected work nodes in the PoA mode are launched in the container. This means that DAG generation is not needed.
- config of the first node:
```
port: 30311
rpc port: 8541
```
- config of the first account:
```
account address: "0x073cfa4b6635b1a1b96f6363a9e499a8076b6107"
password: "password1"
balance: 50 ETH
```

- config of the second node:
```
port: 30312
rpc port: 8542
```
- config of the second account:
```
account address: "0x0ce59225bcd447feaed698ed754d309feba5fc63"
password: "password2"
balance: 70 ETH
```

- How to run:
``` docker run -p 8541:8541 -p 8542:8542  siandreev/ethereum-rpc-test:PoA-mining```

#### There is also a smart contract for ERC20 tokens on the network
- parameters:
```
contract address: 0x70009254e451916fb5543d161768f489289384fb
decimals: 18
first account balance: 1000 tokens
second account balance: 200 tokens
```
"Decimals" means that one token can be divided into 10^18 parts. The balance and amount when sending transactions are indicated in units of measurement of the smallest parts of the token. For example, if we want to send 2 tokens, then we indicate the amount of
```
2 * 10 ** decimals
```
Also, for each transaction, a commission is written off to the owner of the contract (as in Tether USDT).
```
fee = amount / 10000
```
If amount < 10000 fee will be 0. 

- how to try some methods:
```
geth attach http://localhost:8541
> var erc20_coinContract = web3.eth.contract([{"inputs":[{"internalType":"uint256","name":"total","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"tokenOwner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"tokens","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"tokens","type":"uint256"}],"name":"Transfer","type":"event"},{"constant":true,"inputs":[{"internalType":"address","name":"holder","type":"address"},{"internalType":"address","name":"delegate","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"delegate","type":"address"},{"internalType":"uint256","name":"numTokens","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"tokenOwner","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"receiver","type":"address"},{"internalType":"uint256","name":"numTokens","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"holder","type":"address"},{"internalType":"address","name":"buyer","type":"address"},{"internalType":"uint256","name":"numTokens","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]);

> var contract = erc20_coinContract.at("0x70009254e451916fb5543d161768f489289384fb");

>contract.name()
ERC20_Coin

>contract.owner()
"0x073cfa4b6635b1a1b96f6363a9e499a8076b6107"

> contract.balanceOf("0x073cfa4b6635b1a1b96f6363a9e499a8076b6107")
1e+21

> contract.balanceOf("0x0ce59225bcd447feaed698ed754d309feba5fc63")
200000000000000000000

>contract.totalSupply()
1200

> contract.transfer.call("0x0ce59225bcd447feaed698ed754d309feba5fc63", 100000000000000000000, {from: "0x073cfa4b6635b1a1b96f6363a9e499a8076b6107"})

> contract.balanceOf("0x0ce59225bcd447feaed698ed754d309feba5fc63")
300000000000000000000

>contract.transfer("0x073cfa4b6635b1a1b96f6363a9e499a8076b6107", 100000000000000000000, {from: "0x0ce59225bcd447feaed698ed754d309feba5fc63"})

> contract.balanceOf("0x073cfa4b6635b1a1b96f6363a9e499a8076b6107")
1.00001e+21

>contract.balanceOf("0x0ce59225bcd447feaed698ed754d309feba5fc63")
199990000000000000000
```
The last transaction shows that the transfer fee was accrued to the contract holder.
