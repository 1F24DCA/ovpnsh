#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_COUNTRY=`cat config.conf|grep EASYRSA_REQ_COUNTRY|sed -r 's/^EASYRSA_REQ_COUNTRY[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_PROVINCE=`cat config.conf|grep EASYRSA_REQ_PROVINCE|sed -r 's/^EASYRSA_REQ_PROVINCE[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_CITY=`cat config.conf|grep EASYRSA_REQ_CITY|sed -r 's/^EASYRSA_REQ_CITY[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_ORG=`cat config.conf|grep EASYRSA_REQ_ORG|sed -r 's/^EASYRSA_REQ_ORG[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_EMAIL=`cat config.conf|grep EASYRSA_REQ_EMAIL|sed -r 's/^EASYRSA_REQ_EMAIL[[:space:]]*=[[:space:]]*(.*)$/\1/'`
EASYRSA_REQ_OU=`cat config.conf|grep EASYRSA_REQ_OU|sed -r 's/^EASYRSA_REQ_OU[[:space:]]*=[[:space:]]*(.*)$/\1/'`

cp conf/vars vars.temp
sed -r "s/^(set_var EASYRSA_REQ_COUNTRY[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_COUNTRY\"/" vars.temp > vars.temp
sed -r "s/^(set_var EASYRSA_REQ_PROVINCE[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_PROVINCE\"/" vars.temp > vars.temp
sed -r "s/^(set_var EASYRSA_REQ_CITY[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_CITY\"/" vars.temp > vars.temp
sed -r "s/^(set_var EASYRSA_REQ_ORG[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_ORG\"/" vars.temp > vars.temp
sed -r "s/^(set_var EASYRSA_REQ_EMAIL[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_EMAIL\"/" vars.temp > vars.temp
sed -r "s/^(set_var EASYRSA_REQ_OU[[:space:]]*)\".*\"$/\1\"$EASYRSA_REQ_OU\"/" vars.temp > vars.temp
mv vars.temp ~/EasyRSA-${EASYRSA_VERSION}/vars

cd ~/EasyRSA-${EASYRSA_VERSION}/
./easyrsa init-pki