#!/bin/bash
sudo apt-get install ppp -y
sudo apt-get install usb-modeswitch -y
dir1=/etc/umtskeeper/
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
BASEDIR=$(dirname $0)
if [ ! -f $BASEDIR/$strConfFile ]
then
else
if [ ! -x $BASEDIR/$strConfFile ]
chmod +x $BASEDIR/$strConfFile
fi
$BASEDIR/$strConfFile
read -p "Use existing config file? (Y/N)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
fi
#add or replace line to/in rc.local
grep -q "umtskeeper" /etc/rc.local
if [[ $? -eq 0 ]]
then
sudo sed -i.bak "s|.*umtskeeper.*|${dir1}umtskeeper --sakisoperators \"USBINTERFACE='0' OTHER='USBMODEM' USBMODEM='$strUSBMODEM' APN='CUSTOM_APN' CUSTOM_APN='$strAPN' SIM_PIN='$strPIN' APN_USER='guest' APN_PASS='guest'\" --sakisswitches \"--sudo --console\" --devicename 'Huawei' --log --silent --monthstart 8 --nat 'no'|g" /etc/rc.local
else
sudo sed -i.bak "s|exit 0|${dir1}umtskeeper --sakisoperators \"USBINTERFACE='0' OTHER='USBMODEM' USBMODEM='$strUSBMODEM' APN='CUSTOM_APN' CUSTOM_APN='$strAPN' SIM_PIN='$strPIN' APN_USER='guest' APN_PASS='guest'\" --sakisswitches \"--sudo --console\" --devicename 'Huawei' --log --silent --monthstart 8 --nat 'no' \nexit 0|g" /etc/rc.local
fi
