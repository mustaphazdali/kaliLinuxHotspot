#!/bin/bash

#COLORS
gr="\e[1;32m"
rd="\e[1;31m"
or="\e[1;33m"
bl="\e[34m"
rt="\e[0m"
dl="\r\033[0K"

#Rseting after breaking up
trap end SIGINT

end () {
# Stop
# Disable NAT
echo -ne "$or[*]$rt Didabling NAT..."
sudo iptables -D POSTROUTING -t nat -o eth0 -j MASQUERADE
echo -e "$dl$gr[+]$rt NAT Disabled."

# Disable routing
echo -ne "$or[*]$rt Disabling routing..."
sudo sysctl net.ipv4.ip_forward=0
echo -e "$dl$or[+]$rt Routing disabled."

# Disable DHCP/DNS server
echo -ne "$or[*]$rt Disabling DHCP/DNS server"
sudo service dnsmasq stop
sudo service hostapd stop
echo -e "$dl$gr[+]$rt DHCP/DNS disabled."
exit
}

# Start
# Configure IP address for WLAN
echo -ne "$or[*]$rt Config IP address for WLAM"
sudo ifconfig wlan0 192.168.100.1
echo -e "$dl$gr[+]$rt Successful Configurinf WLAN IP"

# Start DHCP/DNS server
echo -ne "$or[*]$rt Strting DHCP/SND Server ..."
sudo service dnsmasq restart
echo -e "$dl$gr[+]$rt DHCP/DNS STARTED."

# Enable routing
echo -ne "$or[*]$rt Enabling routing... "
echo -e "$dl$gr[+] `sudo sysctl net.ipv4.ip_forward=1` $rt"
echo -e "$dl$gr[+]$rt Routing Enabled."

# Enable NAT
echo -ne "$or[*]$rt Enabling NAT..."
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
echo -e "$dl$gr[+]$rt NAT Enabeld."

# Run access point daemon
echo -e "$bl[!] Status:$rt"
echo -nee "$or[*]$rt Runing AP daemon... "
sudo hostapd -B -f /tmp/APlog.txt /etc/hostapd.conf
while true
do
	res=$(sudo tail -n 1 /tmp/APlog.txt)
	if [[ $res =~ "failed" ]]
	then
		echo -e "$bl[!]$rt Restarting hostapd !!"
		sudo kill `pgrep hostapd`
		sleep 1
		sudo hostapd -B -f /tmp/APlog.txt /etc/hostapd.conf
	else
		echo -ne "$dl$gr[+]$rt AP Started."
		sleep 1
	fi
done
