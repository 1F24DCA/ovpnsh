# ovpnsh
OpenVPN server build shell script for individual (need cloud service like AWS)

I referenced this site when make shell scripts:
https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-18-04

# Sorry
I'm not good at programming, so it's poor quality script  
It not have error-checking, so you have to backup before use this shell scripts (ovpnsh/sh/init-sv.sh will change your system files)

# Usage:
1. buy new server (I recommend cloud service like AWS Lightsail)  
&nbsp;- when you select OS, please select Ubuntu. my shell script only works in Ubuntu  
&nbsp;- if you use any other firewall, you should open certain port you need  
2. download and put "ovpnsh" folder in home directory(~, /home/ubuntu, etc..) of your server  
&nbsp;- type "git clone https://github.com/1F24DCA/ovpnsh" in your bash shell to download, or you can use FTP
3. type "chmod -R +x ovpnsh" in your shell to make shell script executable  
4. type "nano ovpnsh/config.conf" or "vi ovpnsh/config.conf" and modify configs  
&nbsp;- you should change "SERVER_IP" to your Public IP of your server  
5. type "./ovpnsh/build.sh", and you can install OpenVPN server  
&nbsp;- when console require to type "yes", type "yes" and press enter.  
&nbsp;- when console require to type with default value (it displays [Default Value]), you can press enter to use default value.  
6. bring <CLIENT_NAME>.ovpn from home directory to your device(Windows, Android, etc)  
7. install OpenVPN client on your device, and use it with ovpn file  
