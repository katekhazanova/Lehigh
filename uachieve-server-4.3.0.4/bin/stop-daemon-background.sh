#!/bin/sh

read pid < ./.uachieve.run
echo 'Stopping u.achieve 4.0 Server'

kill $pid
rm ./.uachieve.run
