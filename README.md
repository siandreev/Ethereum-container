## Ethereum-container
[See at docker hub](https://hub.docker.com/repository/docker/siandreev/ethereum-rpc-test)

This container is designed to expand the private network of the blocked Ethereum.

#### Fast-mining tag
The container is similar to the previous one, but the DAG is generated in advance, so the minning will start immediately, and you do not need to wait 6 minutes for this. Pay attention to the size of the image.
- config of the node:
```
port: 30303
rpc port: 8545
```
- config of the first account:
```
account address: "acfd9f1452e191fa39ff882e5fea428b999fb2af"
password: root
balance: 15 ETH
```
- config of the second account:
```
account address: "e327d116ef3260c47247861c8d6600d010efd7eb"
password: test
balance: 35 ETH
```
- how to run:
``` docker run -p 30303:30303 -p 8545:8545  siandreev/ethereum-rpc-test:fast-mining```
