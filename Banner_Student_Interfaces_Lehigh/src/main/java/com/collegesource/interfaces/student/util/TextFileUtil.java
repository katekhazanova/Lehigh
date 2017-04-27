/*
 * Copyright (c) 2016 CollegeSource Inc.  All Rights Reserved.
 * 
 * This software is the confidential and proprietary information of 
 * CollegeSource Inc. ("Confidential Information").  You shall not 
 * disclose such Confidential Information and shall use it only in 
 * accordance with the terms of the license agreement you entered
 * into with CollegeSource Inc.
 * 
 */
package com.collegesource.interfaces.student.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;

import org.springframework.core.io.ClassPathResource;

/**
 * This utility class helps Student Interface projects pull text from files.
 * 
 * @author Zach Lewis
 */
public class TextFileUtil 
{
	public static String getText(ClassPathResource file)
	{
	    StringBuilder sb = new StringBuilder();
	    
	    try 
	    {
	    	BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream()));

	    	String line = "";	    	
			
			while((line = reader.readLine()) != null)
	        {
	            sb.append(line + "\n");
	        }

	        reader.close();
	    } 
	    catch(MalformedURLException e) 
	    {
	        e.printStackTrace();
	    }
	    catch(IOException e) 
	    {
	        e.printStackTrace();
	    }
		
	    return sb.toString();
	}
}