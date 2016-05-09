#!/usr/bin/env bash



#set the playback mode. Valid values are "output" for output via the 3.5mm jack or "pifm" for output on GPIO pin 4.
mode="output"
channel=107.0 #chanel for pifm output
bitrate=44100 #default bitrate of tracks

currentType=""

playRandomFile(){
    dir=$1
    files=($dir)

    # Seed random generator
    RANDOM=$$$(date +%s)

    file=${files[RANDOM % ${#files[@]}]}
    echo "Playing $file"

    if [ "$mode" == "pifm" ] ;
        then
            ffmpeg -i "$file" -f s16le -ar "$bitrate" -ac 2 - | sudo ./pifm - "$channel" "$bitrate" stereo
    fi

    if [ -f /Applications/VLC.app/Contents/MacOS/VLC ] ;
        then
            /Applications/VLC.app/Contents/MacOS/VLC --no-repeat --no-loop --play-and-exit -I rc "$file"
        else
            cvlc -A alsa,none --no-repeat --no-loop --play-and-exit --alsa-audio-device --no-disable-screensaver default "$file"
    fi
    #ffplay -autoexit -i "$file"
}

getNext(){

    types=("psa" "radioplay" "advert" "track" "goodbye")
    nextType=""


    if [ -n "$1" ] ;
        then
            nextType="$1"
        else
            # Seed random generator
            RANDOM=$$$(date +%s)

            rnd=$(( RANDOM % (100 - 1 + 1 ) + 1 ))

            #echo "Rnd: $rnd"

            #[[ -n $1 ]] && [[ -r $1 ]]

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


            #nextType=${types[$RANDOM % ${#types[@]} ]}
    fi

    case "$nextType" in
        psa)
            currentType="psa"
            playRandomFile "./music/transition-psa/*.mp3" && playRandomFile "./music/psa/*.mp3" && getNext
            ;;
        radioplay)
            currentType="radioplay"
            playRandomFile "./music/goodbye/*.mp3" && playRandomFile "./music/radioplays/*.mp3" && getNext
            ;;
        advert)
            currentType="advert"
            playRandomFile "./music/transition-commercial/*.mp3" && playRandomFile "./music/adverts/*.mp3" && playRandomFile "./music/adverts/*.mp3" && getNext
            ;;
        track)
            currentType="track"
            playRandomFile "./music/transition-music/*.mp3" && playRandomFile "./music/tracks/*.mp3" && playRandomFile "./music/tracks/*.mp3" && playRandomFile "./music/tracks/*.mp3" && playRandomFile "./music/goodbye/*.mp3" && getNext
            ;;

        *)
            currentType="goodbye"
            playRandomFile "./music/goodbye/*.mp3" && getNext "track"
            ;;
    esac
}

getNext "goodbye"





