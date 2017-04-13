#!/bin/sh

if [ -s ./.uachieve.run ]; then
   echo 
   echo SERVER ALREADY STARTED
   echo 
   echo if you think this is in error, examine the below listed processes and delete the ./.uachieve.run file
   echo _________________________
   ps -ef | grep 'uachieve.daemon'
   echo ________________________
   echo 
else
   APP_CLASSPATH=../config:../context:../bin/lib:../bin/lib/*:../usr/lib:../usr/lib/*:

   echo 'Starting u.achieve 4.0 Server'
   nohup java -server -Xms640m -Xmx640m -XX:MaxPermSize=128m -XX:NewSize=128m -XX:MaxNewSize=128m -classpath $APP_CLASSPATH uachieve.daemon.DaemonController &
   echo $! > ./.uachieve.run
fi
