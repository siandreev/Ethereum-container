## Ethereum-container
[See at docker hub](https://hub.docker.com/repository/docker/siandreev/ethereum-rpc-test)

This container is designed to expand the private network of the blocked Ethereum.

#### PoA-mining tag
Two working nodes are launched in the container, interconnected by a bootnode in PoA mode. This means that DAG generation is not needed.
- config of the first node:
```
port: 30311
rpc port: 8541
```
- config of the first account:
```
account address: "0x073cfa4b6635b1a1b96f6363a9e499a8076b6107"
password: "password1"
balance: 904625697166532776746648320380374280103671755200316906558.261906867821325312 ETH
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
balance: 904625697166532776746648320380374280103671755200316906558.261906867821325312 ETH
```

- config of the  bootnode:
```
port: 30310
```

- How to run:
``` docker run -p 8541:8541 -p 8542:8542  siandreev/ethereum-rpc-test:PoA-mining```
