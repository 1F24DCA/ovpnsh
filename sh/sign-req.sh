#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`
CLIENT_NAME=`cat config.conf|grep CLIENT_NAME|sed -r 's/^CLIENT_NAME[[:space:]]*=[[:space:]]*(.*)$/\1/'`

if [ $1 == "-s" ] && [ $# == 1 ]; then
    TYPE="server"
	ID="server"
elif [ $1 == "-c" ] && [ $# == 1 ]; then
    TYPE="client"
	ID=${CLIENT_NAME}
else
	echo "Usage: ./ca_sign.sh -s|-c"
    return 1
fi

cd ~/EasyRSA-${EASYRSA_VERSION}/
./easyrsa sign-req ${TYPE} ${ID}

rm ${BASE_PWD}/${ID}.req