#!/bin/bash

# openssl enc -base64 <<< 'Hello, World!'
# openssl enc -base64 -d <<< SGVsbG8sIFdvcmxkIQo=

ps=$(openssl enc -base64 -d <<< ajMxNDE1OTI2Cg==)

( sleep 2
echo "joeky888,"
sleep 2
printf "\r"
sleep 2
echo "${ps}"
sleep 2
printf "\r"
sleep 2
printf "\r"
sleep 2
printf "G\r"
sleep 2
printf "y\r"
sleep 2
printf "\r\r"
sleep 2 ) | telnet ptt.cc 443
