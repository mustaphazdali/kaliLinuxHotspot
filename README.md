# linuxHotspot
Enabling hotspot for linux.
> I made this custom script to fix hostapd failure.
> It shows this message: "handle_probe_req: send failed".
> After little debugging, I found that the interface keeps down time to time.
> It required me to restart the hostapd server each time the interface down.
> So I create a loop to check if hostapd still running fine, if not the restart hostapd again.
> There may be another issues but this works fine for now :)

## Setup:
* Install requirement
  * `sudo apt install hostapd`
  * `sudo apt install dnsmasp`

- Copy **hostapd.conf** and **dnsmasq.conf** to ***/etc/*** folder
> Located as this:
> * /etc/hostapd.conf
> * /etc/dnsmasq.conf

## Start Hotspot:
* Make script executable:
  * `chmod +x startHotspot.sh`
* Then execute:
  * `./startHotspot.sh`

## Stop Hotspot
You can only press `Ctrl+C` to make it stop

## Troubleshooting
If any issue apears, make sure hostapd isn't running in the backgroud and execute `./startHostspor.sh` *again*
