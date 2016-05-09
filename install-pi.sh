#!/usr/bin/env bash

echo "Installing VLC"
sudo apt-get update
sudo apt-get -y --force-yes install vlc
echo "Setting up Frontier Radio service..."
sudo cp ./frontier.sh /etc/init.d/frontier
sudo update-rc.d frontier defaults