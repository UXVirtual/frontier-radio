#!/usr/bin/env bash

currentType=""

if [ -f "/home/pi/frontier-radio" ] ;
    then
        rootFolder="/home/pi/frontier-radio"
    else
        rootFolder="./"
fi

cd "$rootFolder"

playRandomFile(){
    dir=$1

    file=$(ls -1 "$dir" | python -c "import sys; import random; print(random.choice(sys.stdin.readlines()).rstrip())")

    echo "Playing $file"

    if [ -f /Applications/VLC.app/Contents/MacOS/VLC ] ;
        then
            /Applications/VLC.app/Contents/MacOS/VLC --no-repeat --no-loop --play-and-exit -I rc "$dir/$file"
        else
            cvlc -A alsa,none --no-repeat --no-loop --play-and-exit --no-disable-screensaver --alsa-audio-device default "$dir/$file"
    fi

}

getNext(){

    types=("psa" "radioplay" "advert" "track" "goodbye")
    nextType=""

    if [ -n "$1" ] ;
        then
            nextType="$1"
        else
            rnd=$(python -c "from random import randint; print(randint(1,100))")

            #echo "Random number: $rnd"

            if [ "$rnd" -gt 0 ] && [ "$rnd" -lt 60 ] ;
                then
                    nextType="track"
            elif [ "$rnd" -gt 59 ] && [ "$rnd" -lt 70 ] ;
                then
                    nextType="radioplay"
            elif [ "$rnd" -gt 69 ] && [ "$rnd" -lt 75 ] ;
                then
                    nextType="psa"
            elif [ "$rnd" -gt 74 ] && [ "$rnd" -lt 101 ] ;
                then
                    nextType="advert"
            else
                nextType="goodbye"
            fi
    fi

    case "$nextType" in
        psa)
            currentType="psa"
            playRandomFile "$rootFolder/music/transition-psa" && playRandomFile "$rootFolder/music/psa" && getNext
            ;;
        radioplay)
            currentType="radioplay"
            playRandomFile "$rootFolder/music/goodbye" && playRandomFile "$rootFolder/music/radioplays" && getNext
            ;;
        advert)
            currentType="advert"
            playRandomFile "$rootFolder/music/transition-commercial" && playRandomFile "$rootFolder/music/adverts" && playRandomFile "$rootFolder/music/adverts" && getNext
            ;;
        track)
            currentType="track"
            playRandomFile "$rootFolder/music/transition-music" && playRandomFile "$rootFolder/music/tracks" && playRandomFile "$rootFolder/music/tracks" && playRandomFile "$rootFolder/music/tracks" && playRandomFile "$rootFolder/music/goodbye" && getNext
            ;;

        *)
            currentType="goodbye"
            playRandomFile "$rootFolder/music/goodbye" && getNext "track"
            ;;
    esac
}

getNext "goodbye"





