#!/bin/bash
# This script will install all required stuff to run a BOKcoin (BOK) Masternode.
# BOK Repo : https://github.com/yas195/BOK
# !! THIS SCRIPT NEED TO RUN AS ROOT !!
######################################################################

clear
echo "*********** Welcome to the BOKcoin (bok) Masternode Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 16.04 !'
echo 'Clone & Compile the BOK Wallet also help you on first setup and sync'
echo '****************************************************************************'
sleep 3
echo '*** Step 1/3 ***'
echo '*** Installing packages & copying BOKcoin wallet ***'
sleep 2
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get -y update
sudo apt-get -y install build-essential libssl-dev libdb++-dev libboost-all-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev libgmp-dev autoconf autogen automake libtool libgmp3-dev
wget https://github.com/yas195/BOK/raw/master/bokcoind.tar.gz
tar xvzf bokcoind.tar.gz.1
rm bokcoind.tar.gz.1
chmod 755 bokcoind
mkdir Bokcoin
mv bokcoind Bokcoin/bokcoind
cd Bokcoin
sleep 1
echo '*** Done 1/3 ***'
sleep 1
echo '*** Step 2/3 ***'
echo '*** Starting & configuring the wallet ***'
sleep 2
./bokcoind -daemon
sleep 3
echo -n "Please Enter a STRONG Password or copy & paste the password generated for you above and Hit [ENTER]: "
read usrpas
echo -n "Please Enter your masternode genkey respond and Hit [ENTER]: "
read mngenkey
echo -n "Please Enter the IP address and port of your VPS (ex: 123.456.789.111:46996) and Hit [ENTER]: "
read ipaddress

echo -e "rpcuser=bokuser \nrpcpassword=$usrpas \nrpcallowip=127.0.0.1 \nlisten=1 \nserver=1 \ndaemon=1 \nstaking=0 \nmasternodeaddr=$ipaddress \nmasternode=1 \nmasternodeprivkey=$mngenkey \n" > ~/.bokcoin/bokcoin.conf

echo '*** Done 2/3 ***'
sleep 2
echo '*** Step 3/3 ***'
echo '*** Last Server Start also Wallet Sync ***'
echo 'After 1 minute you will see the 'getinfo' output from the RPC Server...'
./bokcoind -daemon
sleep 60
./bokcoind getinfo
sleep 2
echo 'Have fun with your Bokcoin Masternode!'
sleep 2
echo '*** Done 3/3 ***'
