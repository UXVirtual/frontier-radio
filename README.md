Frontier Radio
==============

Pirate radio station powered by PiFM running on Raspberry Pi Zero.

## Installation on Raspberry Pi Raspbian

1.  [Download NOOBS](https://www.raspberrypi.org/downloads/noobs/) and install the latest version of Rapbian on your 
    Pi. Included in the download are installation instructions on how to format and copy the install files to your SD
    card. At least an 8GB high-speed card are recommended.

2.  Log into the pi after install and set up your wireless network.

3.  Change the Pi settings to boot to the console only when the Pi is turned on.

4.  Change the `pi` user's password in Pi settings.

5.  Clone this repository:

    ```
    cd /home/pi
    git clone https://github.com/HAZARDU5/frontier-radio.git
    ```

6.  Run the install script `install-pi.sh`. Note that this may take several minutes to complete. You will need an internet 
    connection to run the installer:

    ```
    cd /home/pi/frontier-radio
    ./install-pi.sh
    ```

### Forcing Output to a USB Sound Card on Raspberry Pi

If you're using Raspbian Jessie which is based on Debian 8 you can edit the `/usr/share/alsa/alsa.conf` file to set the 
priority of the card entry to use card 1.

```
defaults.ctl.card 1
defaults.pcm.card 1
```

Check the number of the card matches yours by inserting the USB sound card and running:

```
aplay -l
```

## Installation on OSX

1.  Download and install VLC into your `/Applications` folder.

2.  Run the install script `install-osx.sh`.

## Adding Music

Run the following command from your OSX or Linux computer to copy the contents of a folder containing mp3s to the pi:

```
rsync -a DIR pi@REMOTE_IP:/home/pi/frontier-radio/music/tracks
```

Where `DIR` is the path to the local folder containing mp3s, and `REMOTE_IP` is the IP address of the Pi. You can find
the IP address of your Pi by running `ifconfig` while logged into the Pi.

You will be asked for the `pi` user's password before `rsync` begins. Note that this won't remove any mp3s already 
present on the Pi.

You can also add other mp3s to the following folders to change the advertising / DJ announcements between songs:

*   `adverts` - Advertising typically 30 seconds to 1 minute long
*   `goodbye` - Segments announcing the radio station played when the radio station starts up or before a Radio Play begins
*   `psa` - Public service announcements
*   `radioplays` - Radio plays. Typically run between 2-10 minutes.
*   `tracks` - Music tracks
*   `transition-commercial` - DJ announcements before an advert begins.
*   `transition-music` - DJ announcements before a track begins.
*   `transition-psa` - DJ announcements before a public service announcement begins.

