#!/bin/bash

SHELL_PWD="$(cd "$(dirname "$0")"&&pwd -P)"
cd ${SHELL_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`

sudo apt install openvpn

./sh/inst-rsa.sh
./sh/init-rsa.sh

cd ~/EasyRSA-${EASYRSA_VERSION}/
./easyrsa build-ca nopass
cd ${SHELL_PWD}

./sh/gen-req.sh -s
./sh/sign-req.sh -s
./sh/set-key.sh -s
./sh/gen-req.sh -c
./sh/sign-req.sh -c
./sh/set-key.sh -c

sudo ./sh/gen-ovpn.sh
sudo ./sh/init-sv.sh

rm -rf ~/EasyRSA-${EASYRSA_VERSION}