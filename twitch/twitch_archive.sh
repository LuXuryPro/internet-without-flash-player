#!/bin/bash
#Usage ./twitch_api [archive video url]

id=$( echo $1 | sed 's/.*\/b\/\([0-9]*\)/\1/')
url="https://api.twitch.tv/api/videos/a$id"
json=$(curl --silent $url)
urls=$(echo $json | grep -Po '"url":.*?[^\\]",' | sed 's/"url":"//g' | sed 's/",//g')
printf "Files to play:\n$urls\n"
printf "$urls" | mplayer2 -cache 2048 -playlist -
