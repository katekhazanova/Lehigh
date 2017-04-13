APP_CLASSPATH=../config:../context:../bin/lib:../bin/lib/*:../usr/lib:../usr/lib/*:

java -server -Xms640m -Xmx640m -XX:MaxPermSize=128m -XX:NewSize=128m -XX:MaxNewSize=128m -classpath $APP_CLASSPATH uachieve.daemon.TestRequestReader "$@"
