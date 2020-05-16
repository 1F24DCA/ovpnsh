#!/bin/bash

BASE_PWD="$(cd "$(dirname "$0")"/..&&pwd -P)"
cd ${BASE_PWD}

EASYRSA_VERSION=`cat config.conf|grep EASYRSA_VERSION|sed -r 's/^EASYRSA_VERSION[[:space:]]*=[[:space:]]*(.*)$/\1/'`
PROTOCOL=`cat config.conf|grep PROTOCOL|sed -r 's/^PROTOCOL[[:space:]]*=[[:space:]]*(.*)$/\1/'`
PORT=`cat config.conf|grep PORT|sed -r 's/^PORT[[:space:]]*=[[:space:]]*(.*)$/\1/'`

sudo cp ${BASE_PWD}/conf/server.conf server.conf.1.temp
sed -r "s/^proto.*$/proto $PROTOCOL/" server.conf.1.temp>server.conf.2.temp
sed -r "s/^port.*$/port $PORT/" server.conf.2.temp>server.conf.3.temp
sudo cp server.conf.3.temp /etc/openvpn/server.conf

sudo cp /etc/sysctl.conf sysctl.conf.1.temp
sed -r "s/^#net.ipv4.ip_forward=.*$/net.ipv4.ip_forward=1/" sysctl.conf.1.temp>sysctl.conf.2.temp
sudo cp sysctl.conf.2.temp /etc/sysctl.conf

sudo sysctl -p

CHECK_BEFORE_RULES=$(<(sudo cat /etc/ufw/before.rules|grep 'OPENVPN RULES'))
if [ "$CHECK_BEFORE_RULES" == "" ]; then
    ETHERNET_ID=`ip route|grep default|sed -r 's/^default via .* dev (.*) proto .*$/\1/'`

    sudo cp /etc/ufw/before.rules before.rules.temp
    echo -e '\n\n# START OPENVPN RULES'>>before.rules.temp
    echo -e '*nat'>>before.rules.temp
    echo -e ':POSTROUTING ACCEPT [0:0]'>>before.rules.temp
    echo -e "-A POSTROUTING -s 10.8.0.0/8 -o $ETHERNET_ID -j MASQUERADE">>before.rules.temp
    echo -e 'COMMIT'>>before.rules.temp
    echo -e '# END OPENVPN RULES\n\n'>>before.rules.temp
    sudo cp before.rules.temp /etc/ufw/before.rules
fi

sudo cp /etc/default/ufw ufw.1.temp
sudo sed -r "s/^DEFAULT_FORWARD_POLICY=\".*\"$/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/" ufw.1.temp>ufw.2.temp
sudo cp ufw.2.temp /etc/default/ufw

rm *.temp

sudo ufw allow ${PORT}/${PROTOCOL}
sudo ufw allow OpenSSH
sudo ufw disable
sudo ufw enable

sudo systemctl start openvpn@server
sudo systemctl enable openvpn@server
