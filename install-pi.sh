#!/usr/bin/env bash

echo "Installing VLC"
sudo apt-get update
sudo apt-get -y --force-yes install vlc
#echo "Setting up Frontier Radio service..."
#sudo cp ./frontier.sh /etc/init.d/frontier
#sudo update-rc.d frontier defaults
echo "Setting Frontier Radio to start on startup..."
echo "cd /home/pi/frontier-radio\n./player.sh >/dev/null 2>/dev/null &" > ~/.atreboot
chmod +x ~/.atreboot
(crontab -l 2>/dev/null; echo "@reboot /home/pi/.atreboot") | crontab -
