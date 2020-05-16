#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

SERVER_IP=`cat config.conf|grep SERVER_IP|sed -r 's/^SERVER_IP[[:space:]]*=[[:space:]]*(.*)$/\1/'`
PROTOCOL=`cat config.conf|grep PROTOCOL|sed -r 's/^PROTOCOL[[:space:]]*=[[:space:]]*(.*)$/\1/'`
PORT=`cat config.conf|grep PORT|sed -r 's/^PORT[[:space:]]*=[[:space:]]*(.*)$/\1/'`
CLIENT_NAME=`cat config.conf|grep CLIENT_NAME|sed -r 's/^CLIENT_NAME[[:space:]]*=[[:space:]]*(.*)$/\1/'`

cp ${BASE_PWD}/conf/base.conf base.conf.1.temp
sed -r "s/^proto.*$/proto $PROTOCOL/" base.conf.1.temp>base.conf.2.temp
sed -r "s/^remote .* .*$/remote $SERVER_IP $PORT/" base.conf.2.temp>base.conf.3.temp

KEY_DIR=${BASE_PWD}/keys
OUTPUT_DIR=${HOME}
BASE_CONFIG=${BASE_PWD}/base.conf.3.temp

cat ${BASE_CONFIG} \
    <(echo -e '\n<ca>\n') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '\n</ca>\n<cert>\n') \
    ${KEY_DIR}/${CLIENT_NAME}.crt \
    <(echo -e '\n</cert>\n<key>\n') \
    ${KEY_DIR}/${CLIENT_NAME}.key \
    <(echo -e '\n</key>\n<tls-auth>\n') \
    ${KEY_DIR}/ta.key \
    <(echo -e '\n</tls-auth>\n') \
    > ${OUTPUT_DIR}/${CLIENT_NAME}.ovpn

rm *.temp