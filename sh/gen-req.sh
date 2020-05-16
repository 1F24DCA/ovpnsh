#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`
CLIENT_NAME=`cat config.conf|grep CLIENT_NAME|sed -r 's/^CLIENT_NAME[[:space:]]*=[[:space:]]*(.*)$/\1/'`

if [ $1 == "-s" ] && [ $# == 1 ]; then
	ID="server"
elif [ $1 == "-c" ] && [ $# == 1 ]; then
	ID=${CLIENT_NAME}
else
	echo "Usage: ./sv_gen.sh -s|-c"
	return 1
fi

cd ~/EasyRSA-${EASYRSA_VERSION}/
./easyrsa gen-req ${ID} nopass

if [ $1 == "-s" ]; then
	sudo cp ~/EasyRSA-${EASYRSA_VERSION}/pki/private/${ID}.key /etc/openvpn/
elif [ $1 == "-c" ]; then
	mkdir -p ${BASE_PWD}/keys
	cp ~/EasyRSA-${EASYRSA_VERSION}/pki/private/${ID}.key ${BASE_PWD}/keys/
fi
cp ~/EasyRSA-${EASYRSA_VERSION}/pki/reqs/${ID}.req ${BASE_PWD}/