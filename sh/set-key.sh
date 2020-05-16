#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`
CLIENT_NAME=`cat config.conf|grep CLIENT_NAME|sed -r 's/^CLIENT_NAME[[:space:]]*=[[:space:]]*(.*)$/\1/'`

if [ $1 == "-s" ] && [ $# == 1 ]; then
    ID="server"

    sudo cp ~/EasyRSA-${EASYRSA_VERSION}/pki/issued/${ID}.crt /etc/openvpn/
    sudo cp ~/EasyRSA-${EASYRSA_VERSION}/pki/ca.crt /etc/openvpn/

    cd ~/EasyRSA-${EASYRSA_VERSION}/
    ./easyrsa gen-dh

    openvpn --genkey --secret ta.key

    sudo cp ~/EasyRSA-${EASYRSA_VERSION}/ta.key /etc/openvpn/
    sudo cp ~/EasyRSA-${EASYRSA_VERSION}/pki/dh.pem /etc/openvpn/
elif [ $1 == "-c" ] && [ $# == 1 ]; then
    ID=${CLIENT_NAME}

    mkdir -p ${BASE_PWD}/keys
    cp ~/EasyRSA-${EASYRSA_VERSION}/pki/issued/${ID}.crt ${BASE_PWD}/keys/
    cp ~/EasyRSA-${EASYRSA_VERSION}/ta.key ${BASE_PWD}/keys/
    sudo cp /etc/openvpn/ca.crt ${BASE_PWD}/keys/
else
	echo "Usage: ./sv_set.sh -s|-c"
	return 1
fi