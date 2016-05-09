#!/usr/bin/env bash

echo "Installing VLC"
sudo apt-get update
sudo apt-get -y --force-yes install vlc
echo "Installing PiFM"
wget http://omattos.com/pifm.tar.gz
tar -xvf pifm.tar.gz
rm pifm.tar.gz
echo
echo "PiFM installed"
echo
echo "Setting up Frontier Radio service..."