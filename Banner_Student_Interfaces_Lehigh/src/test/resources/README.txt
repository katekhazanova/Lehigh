This is the Test directory for the StudentDataInterfaces.

----------customClassContext.xml----------
In the test version of the customClassContext.xml, you will need to define the beans that are explicitly called/needed by your Student Data Interfaces.
Any beans not needed will need to be removed/commented out.
The head of this file will need to be set to:
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	   xsi:schemaLocation="
	      http://www.springframework.org/schema/beans 
	      http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
	      http://www.springframework.org/schema/context 
	      http://www.springframework.org/schema/context/spring-context-3.2.xsd">

You will also need to make sure that these two lines are defined in this file:
	<import resource="classpath:studentQueries.xml" />
	<context:property-placeholder location="classpath:server.properties"/>


----------server.properties----------
You can copy the server.properties from the u.achieve Server, or just fill out the database parameters in the default.

----------studentQueries.xml----------
Copy your current version from src/main/resources into this directory.

----------Database Driver Jar----------
Make sure you place the database driver jar in src/test/lib and add it to the classpath