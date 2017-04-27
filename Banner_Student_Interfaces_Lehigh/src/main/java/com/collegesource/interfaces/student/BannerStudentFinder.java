/*
 * Copyright (c) 2014 CollegeSource Inc. All Rights Reserved. This software is
 * the confidential and proprietary information of CollegeSource Inc. (
 * "Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the license
 * agreement you entered into with CollegeSource Inc.
 */
package com.collegesource.interfaces.student;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.CollectionUtils;

import com.collegesource.interfaces.student.dao.BannerDao;
import com.redlantern.interfaces.student.StudentFinder;

import uachieve.apis.student.StuDemo;
import uachieve.apis.student.StuDemoPK;
import uachieve.apis.student.StuMaster;

/**
 * Implementation of StudentFinder for a Banner SIS.
 * 
 * @author Vincent Turpin
 * @author neighborsj
 */
public class BannerStudentFinder implements StudentFinder
{
	private static final Logger	logger	= Logger.getLogger(BannerStudentFinder.class);

	private BannerDao			bannerDao;
	private String				studentInstidq;
	private String				studentInstid;

	private JdbcTemplate		jdbcTemplate;

	/**
	 * Find a student in Banner by name.
	 * 
	 * @param instidq
	 * @param instid
	 * @param firstName
	 * @param lastName
	 */
	@Override
	public List<StuMaster> findStudentByName(String instidq, String instid, String firstName, String lastName)
	{
		logger.debug(MessageFormat.format("Searching for student by firstName[{0}] and lastName[{1}]", firstName, lastName));
		List<Map<String, Object>> results = bannerDao.searchForStudentByName(firstName, lastName, logger);
		List<StuMaster> students = new ArrayList<StuMaster>();

		for (Map<String, Object> map : results)
		{
			students.add(createStudent(map));
		}

		return students;
	}

	/**
	 * Find a student in Banner by stuno.
	 * 
	 * @param instidq
	 * @param instid
	 * @param stuno
	 */
	@Override
	public StuMaster findStudentByStuno(String instidq, String instid, String stuno)
	{
		//Trim Values
		instidq = StringUtils.trimToEmpty(instidq);
		instid = StringUtils.trimToEmpty(instid);
		stuno = StringUtils.trimToEmpty(stuno);

		logger.debug(MessageFormat.format("Searching for student by stuno[{0}]", stuno));
		StuMaster sm = new StuMaster();
		List<Map<String, Object>> results = bannerDao.searchForStudentByStuno(stuno, logger);

		if (!CollectionUtils.isEmpty(results))
		{
			sm = createStudent(results.get(0));
			if (!findStudentInStuMaster(instidq, instid, stuno))
			{
				createStuMasterAndStuDemoRecord(sm);
			}
			else if (!validateStuDemo(sm))
			{
				updateStuDemoRecord(sm);
			}
		}
		return sm;
	}

	private void createStuMasterAndStuDemoRecord(StuMaster stuMaster)
	{
		logger.debug("Attempting to save StuMaster and StuDemo Record for student.");
		String insertStuMasterQuery = "Insert into Stu_Master(Instidq, Instid, Stuno) values ('" + stuMaster.getInstidq() + "','" + stuMaster.getInstid() + "','" + stuMaster.getStuno() + "')";

		try
		{
			//StuMaster Insert
			logger.debug("StuMasterQuery[" + insertStuMasterQuery + "]");
			int stuMasterResult = jdbcTemplate.update(insertStuMasterQuery);
			logger.debug("Inserted [" + stuMasterResult + "] Records");

			//Get IntSeqNo from StuMaster (Sequence PK)
			String intSeqNoQuery = "Select int_seq_no from Stu_Master where instidq = '" + stuMaster.getInstidq() + "' and instid = '" + stuMaster.getInstid() + "' and stuno = '" + stuMaster.getStuno() + "'";
			logger.debug("IntSeqNoQuery[" + intSeqNoQuery + "]");
			List<Map<String, Object>> results = jdbcTemplate.queryForList(intSeqNoQuery);
			logger.debug("Results[" + results + "], Getting First Result");

			//Set IntSeqNo to StuMaster Object
			stuMaster.setIntSeqNo(((BigDecimal) results.get(0).get("int_seq_no")).intValue());

			//StuDemo Insert
			String insertStuDemoQuery = "Insert into Stu_Demo (Stu_Mast_no, Source_Id, Stuname) values ('" + stuMaster.getIntSeqNo() + "','" + stuMaster.getInstid() + "','" + StringUtils.replace(stuMaster.getStuDemos().get(0).getStuname(), "'", "''")
					+ "')";
			int stuDemoResult = jdbcTemplate.update(insertStuDemoQuery);
			logger.debug("Inserted [" + stuDemoResult + "] Records");
		}
		catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}

	}

	private void updateStuDemoRecord(StuMaster stuMaster)
	{
		logger.debug("updateStuDemoRecord");
		String countQuery = "select count(*) from stu_demo where stu_mast_no = '" + stuMaster.getIntSeqNo() + "' and rtrim(source_id) = rtrim('" + stuMaster.getInstid() + "')";

		try
		{
			//See if Student Has a StuDemo Record
			logger.debug("CountQuery[" + countQuery + "]");
			int count = jdbcTemplate.queryForInt(countQuery);
			logger.debug("Record Count:" + count);
			if (count > 0)
			{
				//Has a Record, so Update it
				String updateQuery = "update stu_demo set stuname = '" + stuMaster.getStuDemos().get(0).getStuname() + "' where stu_mast_no = '" + stuMaster.getIntSeqNo() + "' and source_id = '" + stuMaster.getInstid() + "'";
				logger.debug("Attempting to update Student Demo Record[" + updateQuery + "]");
				int updateStuDemoResult = jdbcTemplate.update(updateQuery);
				logger.debug("Record Updated[" + updateStuDemoResult + "]");
			}
			else
			{
				//Does not have a Record, Insert it
				String insertQuery = "insert into stu_demo (stu_mast_no, source_id, stuname) values ('" + stuMaster.getIntSeqNo() + "','" + stuMaster.getInstid() + "','" + stuMaster.getStuDemos().get(0).getStuname() + "')";
				logger.debug("Attempting to insert Stu Demo Record[" + insertQuery + "]");
				int insertStuDemoResult = jdbcTemplate.update(insertQuery);
				logger.debug("Record Inserted[" + insertStuDemoResult + "]");
			}
		}
		catch (Exception e)
		{
			logger.error(e.getMessage());
		}
	}

	private boolean validateStuDemo(StuMaster stuMaster)
	{
		logger.debug("validatStuDemo");
		String intSeqNoQuery = "Select int_seq_no from Stu_Master where instidq = '" + stuMaster.getInstidq() + "' and instid = '" + stuMaster.getInstid() + "' and stuno = '" + stuMaster.getStuno() + "'";

		try
		{
			//Getting IntSeqNo From StuMaster (PK sequence number)
			logger.debug("intSeqNoQuery[" + intSeqNoQuery + "]");
			List<Map<String, Object>> results = jdbcTemplate.queryForList(intSeqNoQuery);
			logger.debug("Results [" + results + "], Grabbing First Record");

			//Set IntSeqNo on StuMaster Object
			stuMaster.setIntSeqNo(((BigDecimal) results.get(0).get("int_seq_no")).intValue());
			logger.debug("Student IntSeqNo[" + stuMaster.getIntSeqNo() + "]");

			//Get Student Name from StuDemo and Compare to What came back from Banner
			String stuNameQuery = "Select stuname from stu_demo where stu_mast_no = '" + stuMaster.getIntSeqNo() + "' and rtrim(source_id) = rtrim('" + stuMaster.getInstid() + "')";
			logger.debug("StuNameQuery[" + stuNameQuery + "]");
			String stuName = jdbcTemplate.queryForObject(stuNameQuery, String.class);
			logger.debug("Results[" + stuName + "]");

			return StringUtils.equalsIgnoreCase(stuMaster.getStuDemos().get(0).getStuname(), stuName);
		}
		catch (Exception e)
		{
			logger.error(e.getMessage());
			return false;
		}

	}

	private boolean findStudentInStuMaster(String instidq, String instid, String stuno)
	{
		logger.debug("findStudentInStuMaster");
		String query = "Select count(*) from Stu_Master where instidq = '" + instidq + "' and instid='" + instid + "' and stuno = '" + stuno + "'";
		int count = -1;

		try
		{
			logger.debug(MessageFormat.format("Searching for student record[Instidq: [{0}], Instid: [{1}], Stuno: [{2}]]: ", instidq, instid, stuno));
			logger.debug(query);
			count = jdbcTemplate.queryForInt(query);
			if (count > 0)
			{
				logger.debug(MessageFormat.format("Found student record[Instidq:{0}, Instid: {1}, Stuno: {2}]: ", instidq, instid, stuno));
				return true;
			}
			logger.debug(MessageFormat.format("Student not found in StuMaster. Count:{0}", count));
			return false;
		}
		catch (Exception e)
		{
			//Student doesn't exist inside of StuMaster. Try to create it.
			logger.debug("Student not found in StuMaster.");
			return false;
		}
	}

	/**
	 * Create a StuMaster object from the search results map.
	 * 
	 * @param map
	 */
	private StuMaster createStudent(Map<String, Object> map)
	{
		StuMaster stuMaster = new StuMaster();
		StuDemo stuDemo = new StuDemo();
		StuDemoPK stuDemoPk = new StuDemoPK();

		stuMaster.setInstid(studentInstid);
		stuMaster.setInstidq(studentInstidq);
		stuMaster.setStuno(StringUtils.trimToEmpty((String) map.get("spriden_id")));

		stuDemoPk.setSourceId(studentInstid);
		stuDemoPk.setStuMaster(stuMaster);

		String name = StringUtils.trimToEmpty(StringUtils.substring((String) map.get("stuname"), 0, 35));

		stuDemo.setStuname(name);
		stuDemo.setStuidq(studentInstidq);
		stuDemo.setComp_id(stuDemoPk);

		List<StuDemo> demoList = new ArrayList<StuDemo>();
		demoList.add(stuDemo);

		stuMaster.setStuDemos(demoList);
		logger.debug("Created StuMaster with Banner Records: " + stuMaster);
		logger.debug("Student Name[" + stuDemo.getStuname() + "]");
		return stuMaster;
	}

	/* Property Setters */

	public void setStudentInstidq(String studentInstidq)
	{
		this.studentInstidq = studentInstidq;
	}

	public void setStudentInstid(String studentInstid)
	{
		this.studentInstid = studentInstid;
	}

	public void setBannerDao(BannerDao bannerDao)
	{
		this.bannerDao = bannerDao;
	}

	public void setDatasource(DataSource datasource)
	{
		this.jdbcTemplate = new JdbcTemplate(datasource);
	}

}