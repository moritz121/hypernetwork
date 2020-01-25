#!/bin/bash

./stop.sh

docker rm $(docker ps -a -q)

./firstTime.sh

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b mychannel.block

composer network install -a ~/Desktop/nuclearhyperledger/dist/nuclearhyperledger.bna -c PeerAdmin@org1

composer card delete -c admin@nuclearhyperledger

rm wallet/admin@nuclearhyperledger.card

composer network start -c PeerAdmin@org1 -n nuclearhyperledger -V 0.0.1 -o -A admin -C temp/admin-pub.pem -K temp/admin-priv.pem -f wallet/admin@nuclearhyperledger.card

composer card import -f wallet/admin@nuclearhyperledger.card 

composer-rest-server -c admin@nuclearhyperledger

