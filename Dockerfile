FROM ubuntu:xenial

RUN apt-get update \
     && apt-get install -y wget \
     && rm -rf /var/lib/apt/lists/* 

ARG BINARY="geth-linux-amd64-1.9.10-58cf5686.tar.gz"
RUN wget "https://gethstore.blob.core.windows.net/builds/$BINARY"
RUN tar -xzvf $BINARY --strip 1
RUN rm $BINARY

ADD ./genesis.json ./genesis.json

RUN mkdir ~/.ethash

COPY datadir /datadir
COPY testpassword ./testpassword
RUN ./geth makedag 2 ~/.ethash
CMD exec ./geth --datadir datadir --unlock 0 --password testpassword --rpc -rpcapi eth,web3,personal,admin --rpccorsdomain '*' --mine --minerthreads 1 --allow-insecure-unlock --port 30303 --rpcaddr "0.0.0.0" --rpcport 8545 --verbosity 6 --networkid 185

EXPOSE 8545
EXPOSE 30303


