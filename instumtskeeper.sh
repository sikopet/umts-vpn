#!/bin/bash
#sudo apt-get install ppp -y
#sudo apt-get install usb-modeswitch -y
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