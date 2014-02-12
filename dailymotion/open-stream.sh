#!/bin/bash

q=$2
rtmp_url=""
id=$(echo $1 | sed 's/.*video\/\([a-z0-9]*\)_.*/\1/')

while true
do
    rtmp_data=$(curl --silent "http://www.dailymotion.com/sequence/full/$id")
    url=$(echo $rtmp_data | grep -Po '"'$q'URL":.*?[^\\]",' | cut -d \" -f4 | sed -e 's/\\//g')
    if [[ -n "$url" ]]; then
        while [[ $rtmp_url != *?auth=* ]]; do
            rtmp_url=$(curl --silent $url)
        done
        mplayer2 "$rtmp_url" -cache 2048
    fi
    sleep 10
done

