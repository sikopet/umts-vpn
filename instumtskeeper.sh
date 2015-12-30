#!/bin/bash

BASEDIR=$(dirname $0)
dir1=/etc/umtskeeper/
#include functions file
if [ ! -x $BASEDIR/functions ]
chmod +x $BASEDIR/functions
fi
$BASEDIR/functions 

sudo apt-get install ppp -y
sudo apt-get install usb-modeswitch -y
sudo mkdir /etc/umtskeeper
cd /etc/umtskeeper
sudo wget "http://zool33.uni-graz.at/petz/umtskeeper/src/umtskeeper.tar.gz"
sudo tar -xzvf ${dir1}umtskeeper.tar.gz
sudo rm ${dir1}umtskeeper.tar.gz
sudo chmod +x ${dir1}umtskeeper
 
sudo wget "http://downloads.sourceforge.net/project/vim-n4n0/sakis3g.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fvim-n4n0%2Ffiles%2F&ts=1363537696&use_mirror=tene~t" -O sakis3g.tar.gz
sudo tar -xzvf ${dir1}sakis3g.tar.gz
sudo rm ${dir1}sakis3g.tar.gz
sudo chmod +x ${dir1}sakis3g

#read manufacturer and device id from modem (now only for huwaei)
#CHANGE take care that the modem is already switched (usb-modeswitch)
strUSBMODEM="$(lsusb | awk '{if ($7 == "Huawei") print $6;}')"
#write manufacturer and id into array arrUSBMODEM
#IFS=':' read -r -a arrUSBMODEM <<< $strUSBMODEM #get variable with ${arrUSBMODEM[0]}

#check if config file exists
strConfFile=config.cfg
if [ ! -f $BASEDIR/$strConfFile ]
then
configfile
else
if [ ! -x $BASEDIR/$strConfFile ]
chmod +x $BASEDIR/$strConfFile
fi
$BASEDIR/$strConfFile
read -p "Use existing config file? (Y/N)" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  configfile
fi
writeRcLocal
