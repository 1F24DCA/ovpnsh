#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`

wget -P . https://github.com/OpenVPN/easy-rsa/releases/download/v${EASYRSA_VERSION}/EasyRSA-${EASYRSA_VERSION}.tgz

tar xvf EasyRSA-${EASYRSA_VERSION}.tgz -C ~
rm EasyRSA-${EASYRSA_VERSION}.tgz