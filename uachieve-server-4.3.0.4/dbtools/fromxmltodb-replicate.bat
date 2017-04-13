call classpath.bat

java -Xms64m -Xmx256m -classpath "%APP_CLASSPATH%" redlantern.dbtools.ToolsReplicateMain writeFromFile %*