#!/bin/bash
# This script will install all required stuff to run a BOKcoin (BOK) Masternode.
# BOK Repo : https://github.com/yas195/BOK
# !! THIS SCRIPT NEED TO RUN AS ROOT !!
######################################################################

clear
echo "******************복코인 마스터노드 설치 스크립트 입니다 *******************"
echo '이 스크립트는 우분투 16.04 64bit 에서 작동합니다 '
echo '****************************************************************************'
sleep 3
echo '*** 진행중 1/3 ***'
echo '*** 패키지 설치 및 복코인 지갑 설치 ***'
sleep 2
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get -y update
sudo apt-get -y install build-essential libssl-dev libdb++-dev libboost-all-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev libgmp-dev autoconf autogen automake libtool libgmp3-dev libdb4.8-dev libdb4.8++-dev
wget https://github.com/yas195/BOK/raw/master/bokcoind.tar.gz
tar xvzf bokcoind.tar.gz.1
rm bokcoind.tar.gz.1
chmod 755 bokcoind
mkdir bokcoin
mv bokcoind bokcoin/bokcoind
cd bokcoin
sleep 1
echo '*** 완료 1/3 ***'
sleep 1
echo '*** 진행중 2/3 ***'
echo '*** 복코인드 시작 및 종료, 설정 ***'
sleep 2
./bokcoind -daemon
sleep 3
echo -n "사용하고자 하는 rpc 패스워드를 입력해 주세요 입력후 [ENTER]: "
read usrpas
echo -n "당신이 생성한 masternode genkey 값을 입력해 주세요 입력후 [ENTER]: "
read mngenkey
echo -n "이 컴퓨터의 IP:46996 입력 (예: 123.456.789.111:46996) 입력후 [ENTER]: "
read ipaddress

echo -e "rpcuser=bokuser \nrpcpassword=$usrpas \nrpcallowip=127.0.0.1 \nlisten=1 \nserver=1 \ndaemon=1 \nstaking=0 \nmasternodeaddr=$ipaddress \nmasternode=1 \nmasternodeprivkey=$mngenkey \n" > ~/.bokcoin/bokcoin.conf
sleep 2
./bokcoind -stop
echo '*** 완료 2/3 ***'
sleep 3
echo '*** 단계 3/3 ***'
echo '*** 복코인드 시작 및 지갑 싱크 시작 ***'
echo '1분후 getinfo 정보가 출력될 것입니다...'
./bokcoind -daemon
sleep 60
./bokcoind getinfo
sleep 2
echo '복코인 마스터노드 설치완료'
sleep 2
echo '*** 완료 3/3 ***'
