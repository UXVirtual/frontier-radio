#!/usr/bin/env bash

echo "Installing ffmpeg from source. This may take several hours..."
echo
sudo apt-get install cmake cmake-curses-gui build-essential yasm
git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-nonfree --enable-ffplay
make -j4
sudo make install
rm ffmpeg
echo
echo "ffmpeg installed"
echo
echo "Installing PiFM"
wget http://omattos.com/pifm.tar.gz
tar -xvf pifm.tar.gz
rm pifm.tar.gz
echo
echo "PiFM installed"
echo
echo "Setting up Frontier Radio service..."