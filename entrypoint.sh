#!/bin/bash
    cd "$(dirname "$0")"
    ip=$(hostname -i)
    (geth --datadir node1 --nousb --unlock 0 --password node1/node1.password --rpc -rpcapi eth,web3,personal,admin --rpccorsdomain '*' --nat extip:`hostname -i` --maxpendpeers 4 --mine --minerthreads 1 --allow-insecure-unlock --port 30311 --rpcaddr "0.0.0.0" --rpcport 8541 --networkid 191 --miner.etherbase 0x073CFa4b6635b1A1B96F6363a9e499a8076B6107 --syncmode 'full' --ipcdisable &> node1.log &) 
    sleep 3
    full_enode1=$(geth --exec "admin.nodeInfo.enode" attach http://$ip:8541)
    enode1=$(expr substr $full_enode1 1 $(($(expr index $full_enode1 "@") - 1)))'@127.0.0.1:30311"'
    (geth --datadir node2 --nousb --unlock 0 --password node2/node2.password --rpc -rpcapi eth,web3,personal,admin --rpccorsdomain '*' --nat extip:`hostname -i`  --maxpendpeers 4 --mine --minerthreads 1 --allow-insecure-unlock --port 30312 --rpcaddr "0.0.0.0" --rpcport 8542 --networkid 191 --miner.etherbase 0x0Ce59225BCD447fEaEd698ED754D309febA5fC63 --syncmode 'full' --ipcdisable &> node2.log &)
    sleep 3
    $(geth --exec "admin.addPeer($enode1)" attach http://$ip:8542)  
    while ! ( ( grep -q 'number=3' ./node1.log ) && ( grep -q 'number=3' ./node2.log) )
	do
		sleep 2
		echo "Waiting for node..."
	done
    echo "The node is ready!"
    sleep infinity