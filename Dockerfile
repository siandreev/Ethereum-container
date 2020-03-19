FROM ubuntu:xenial

RUN apt-get update && apt-get install --yes software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install --yes geth

COPY node1 home/datadir/node1
COPY node2 home/datadir/node2
COPY devnet.json home/datadir/devnet.json
COPY entrypoint.sh home/datadir/entrypoint.sh

RUN geth --datadir home/datadir/node1 init home/datadir/devnet.json
RUN geth --datadir home/datadir/node2 init home/datadir/devnet.json

EXPOSE 8541
EXPOSE 8542
EXPOSE 30311
EXPOSE 30312

ENTRYPOINT ["home/datadir/entrypoint.sh"]


