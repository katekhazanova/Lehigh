/*
 * Copyright(c) 2013 CollegeSource Inc.  All Rights Reserved.
 * 
 * This software is the confidential and proprietary information of 
 * CollegeSource Inc.("Confidential Information").  You shall not 
 * disclose such Confidential Information and shall use it only in 
 * accordance with the terms of the license agreement you entered
 * into with CollegeSource Inc.
 * 
 */
package com.collegesource.interfaces.student.program;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This object represents of a grouping of Banner records, consisting of
 * dprogs, markers, and concentrations.
 * 
 * @author Zach Lewis
 */
public class DprogGroup 
{	
	private List<Map<String, Object>> list;

	public List<Map<String, Object>> getList() 
	{
		return list;
	}

	public void setList(List<Map<String, Object>> list) 
	{
		this.list = list;
	}
	
	public void addToList(Map<String, Object> map) 
	{
		if(list == null) 
		{
			list = new ArrayList<Map<String, Object>>();
		}
		
		list.add(map);
	}
	
	public void removeFromList(Map<String, Object> map)
	{
		List<Map<String, Object>> newList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> tempMap : list)
		{
			if (!tempMap.equals(map))
			{
				newList.add(tempMap);
			}
		}
		list = newList;
	}
	
	public void addAllToList(List<Map<String, Object>> addList)
	{
		list.addAll(addList);
	}
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		for(Map<String, Object> map : this.list) {
			sb.append(map + System.getProperty("line.separator"));
		}
		return sb.toString();
	}
}