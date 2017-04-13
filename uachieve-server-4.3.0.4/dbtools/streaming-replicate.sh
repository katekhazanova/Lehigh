APP_CLASSPATH=./config:../bin/lib:../bin/lib/*:../usr/*:../usr:../usr/lib/*:../usr/lib:
java -Xms64m -Xmx256m -classpath $APP_CLASSPATH redlantern.dbtools.ToolsReplicateMain streaming "$@"