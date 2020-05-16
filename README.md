# ovpnsh
OpenVPN server build shell script for individual (need cloud service like AWS)

I referenced this site when make shell scripts:
https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-18-04

# Usage:
1. buy new server (I recommend cloud service like AWS Lightsail)
&nbsp;&nbsp;&nbsp;&nbsp;- when you select OS, please select Ubuntu. my shell script only works in Ubuntu
2. download and put "ovpnsh" folder in home directory(~, /home/ubuntu, etc..) of your server
3. type "chmod -R +x ovpnsh" in your shell to make shell script executable
4. type "nano ovpnsh/config.cfg" or "vi opensh/config.cfg" and modify configs
&nbsp;&nbsp;&nbsp;&nbsp;- you should change "SERVER_IP" to your Public IP of your server
5. type "./ovpnsh/build.sh", and you can install OpenVPN server
&nbsp;&nbsp;&nbsp;&nbsp;- when console require type "yes", type "yes" and press enter.
&nbsp;&nbsp;&nbsp;&nbsp;- when input is required, press enter to use default value.
6. bring <CLIENT_NAME>.ovpn from home directory to your device(Windows, Android, etc)
7. install OpenVPN client on your device, and use it with ovpn file
