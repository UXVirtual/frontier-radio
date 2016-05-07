Frontier Radio
==============

Pirate radio station powered by PiFM running on Raspberry Pi Zero.

## Installation

1.  [Download NOOBS](https://www.raspberrypi.org/downloads/noobs/) and install the latest version of Rapbian on your 
    Pi. Included in the download are installation instructions on how to format and copy the install files to your SD
    card. At least an 8GB high-speed card are recommended.

2.  Log into the pi after install and set up your wireless network.

3.  Change the Pi settings to boot to the console only when the Pi is turned on.

4.  Change the `pi` user's password in Pi settings.

5. Clone this repository:

```
cd /home/pi
git clone https://github.com/HAZARDU5/frontier-radio.git
```

6. Run the install script:

```
cd /home/pi/frontier-radio
./install.sh
```

## Adding Music

Run the following command from your OSX or Linux computer to copy the contents of a folder containing mp3s to the pi:

```
rsync -a DIR pi@REMOTE_IP:/home/pi/Music
```

Where `DIR` is the path to the local folder containing mp3s, and `REMOTE_IP` is the IP address of the Pi. You can find
the IP address of your Pi by running `ifconfig` while logged into the Pi.

You will be asked for the `pi` user's password before `rsync` begins. Note that this won't remove any mp3s already 
present on the Pi.

## MP3 Playback

Run the following command to play back a track to test:

```
ffmpeg -i FILE.mp3 -f s16le -ar BITRATE -ac 2 - | sudo ./pifm - 88.1 BITRATE stereo
```

Where `BITRATE` is the bitrate of the mp3 track (typically this will be `44100`) and `FILE.mpe3` is the path to the file 
you wish to playback.