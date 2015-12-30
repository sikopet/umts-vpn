#!/bin/bash

BASEDIR=$(dirname $0)
RED='\033[0;31m'
NC='\033[0m' # No Color
dir1=/etc/umtskeeper/
#include functions file
if [ ! -x $BASEDIR/functions ]
then
chmod +x $BASEDIR/functions
fi
source $BASEDIR/functions 

read -p "Initial setup of UMTSKEEPER? (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ -d ${dir1} ]; then
  echo -e "${RED}WARNING!\n${NC}Are your sure? The folder ${dir1} does exist. If you continue all files in these folder will be overwritten."
  read -p "Proceed? (Y/N) " -n 1 -r
  echo ""
   if [[ $REPLY =~ ^[Yy]$ ]]; then
   baseSetup
   fi
  else
  baseSetup
  fi
fi
read -p "Write UMTSKEEPER in rc.local? (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
#read manufacturer and device id from modem (now only for huwaei)
#CHANGE take care that the modem is already switched (usb-modeswitch)
strUSBMODEM="$(lsusb | awk '{if ($7 == "Huawei") print $6;}')"
#write manufacturer and id into array arrUSBMODEM
#IFS=':' read -r -a arrUSBMODEM <<< $strUSBMODEM #get variable with ${arrUSBMODEM[0]}

#check if config file exists
strConfFile=config.cfg
if [ ! -f $BASEDIR/$strConfFile ]
then
source configfile
else
if [ ! -x $BASEDIR/$strConfFile ]
then
chmod +x $BASEDIR/$strConfFile
fi
$BASEDIR/$strConfFile
read -p "Use existing config file? (Y/N)" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  configfile
fi
writeRcLocal
fi
fi
read -p "Setting up NAT (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
setupNAT
fi
read -p "Add routes in IP Table (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
fi
read -p "Add routes in IP Table to roots Crontab (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
sudo crontab -l | { cat; echo "@reboot /sbin/iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE"; } | sudo crontab -
fi
read -p "Install and setup no-ip update client (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
rm noip-duc-linux.tar.gz
#CHANGE get it working with any version
cd no-ip-2.1.9-1
make
checkinstall
/usr/local/bin/noip2 -C   #(dash capital C, this will create the default config file)
fi
