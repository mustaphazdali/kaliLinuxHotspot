# linuxHotspot
Enabling hotspot for linux

## Setup:
* Install requirement
  * sudo apt install hostapd
  * sudo apt install dnsmasp

- Copy **hostapd.conf** and **dnsmasq.conf** to ***/etc/*** folder
> Located as this:
> * /etc/hostapd.conf
> * /etc/dnsmasq.conf

## Start Hotspot:
* Make script executable:
  * chmod +x startHotspot.sh
* Then execute:
  * ./startHotspot.sh

## Stop Hotspot
You can only press Ctrl+C to make it stop

## Troubleshooting
If any issue apears, make sure hostapd isn't running in the backgroud and execute ./startHostspor.sh *again*
