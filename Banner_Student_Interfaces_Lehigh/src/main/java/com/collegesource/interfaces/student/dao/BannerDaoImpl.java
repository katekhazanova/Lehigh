package com.collegesource.interfaces.student.dao;

import static org.apache.commons.lang.StringUtils.replaceOnce;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.CollectionUtils;

import com.collegesource.interfaces.student.util.StudentQueryUtil;

import uachieve.apis.student.StuAcadrec;
import uachieve.apis.support.ComHelper;

/**
 * This is an implementation of a DAO object for a Banner SIS.
 * 
 * @author Justin Neighbors
 */
public class BannerDaoImpl implements BannerDao
{
	private JdbcTemplate		bannerJdbcTemplate;
	private StudentQueryUtil	studentQueryUtil;

	/**
	 * Load the student pidm.
	 * 
	 * @param stuno the student number
	 */
	@Override
	public String loadPidm(String stuno, ComHelper comHelper)
	{
		String results = "";
		String query = studentQueryUtil.getPidmQuery();
		query = replaceOnce(query, "?", "'" + StringUtils.trim(stuno) + "'");

		comHelper.getLogger().trace(Thread.currentThread().getStackTrace()[2].getMethodName() + " Query[" + query + "]");

		try
		{
			results = bannerJdbcTemplate.queryForObject(query, String.class);
		}
		catch (DataAccessException dae)
		{
			comHelper.getLogger().error("Exception in [" + Thread.currentThread().getStackTrace()[2].getMethodName() + "] e[" + dae + "]");
		}
		comHelper.getLogger().trace(MessageFormat.format(Thread.currentThread().getStackTrace()[2].getMethodName() + " Result: [{0}]", results));
		return results;
	}

	/**
	 * Load the student name.
	 * 
	 * @param pidm the student number
	 */
	@Override
	public String loadStudentName(String pidm, ComHelper comHelper)
	{
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		String query = studentQueryUtil.getNameQuery();
		query = replaceOnce(query, "?", "'" + pidm + "'");

		comHelper.getLogger().trace(Thread.currentThread().getStackTrace()[2].getMethodName() + " Query[" + query + "]");

		try
		{
			results = bannerJdbcTemplate.queryForList(query);
		}
		catch (DataAccessException dae)
		{
			comHelper.getLogger().error("Exception in [" + Thread.currentThread().getStackTrace()[2].getMethodName() + "] e[" + dae + "]");
		}
		comHelper.getLogger().trace(MessageFormat.format(Thread.currentThread().getStackTrace()[2].getMethodName() + " Result: [{0}]", results));

		if (!CollectionUtils.isEmpty(results))
		{
			Map<String, Object> nameRow = results.get(0);
			return (String) nameRow.get("stuname");
		}
		return null;
	}

	/**
	 * Find Advisor Name
	 * 
	 * @param pidm
	 * @param comHelper
	 * @return String
	 */
	@Override
	public String findAdvisorName(String pidm, ComHelper comHelper)
	{
		List<Map<String, Object>> results = query(new Object[] { pidm }, studentQueryUtil.getFindAdvisorNameQuery(), comHelper);
		String name = "";
		if (!CollectionUtils.isEmpty(results))
		{
			name = (String) results.get(0).get("name");
		}
		return name;
	}

	/**
	 * Get Shrdgmr Data, currently used for GradDate
	 * 
	 * @param pidm
	 * @param comHelper
	 * @return List<Map<String, Object>>
	 */
	@Override
	public List<Map<String, Object>> findShrdgmrData(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm, pidm }, studentQueryUtil.getFindShrdgmrDataQuery(), comHelper);
	}

	/**
	 * Get student's Program Info
	 * 
	 * @PARAM pidm
	 */
	@Override
	public List<Map<String, Object>> findDegreeProgramInfo(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getDprogQuery(), comHelper);
	}

	/**
	 * Find the student's degree program information.
	 * 
	 * @param majorCode
	 * @param degreeCode
	 */
	@Override
	public List<Map<String, Object>> findCrosswalkDprog(String majorCode, String degreeCode, ComHelper comHelper)
	{
		return query(new Object[] { StringUtils.trimToEmpty(majorCode), StringUtils.trimToEmpty(degreeCode) }, studentQueryUtil.getCrosswalkQuery(), comHelper);
	}

	/**
	 * Determines if Student gets NCAA Marker
	 * 
	 * @param pidm
	 * @param comHelper
	 * @return boolean
	 */
	@Override
	public boolean isNcaa(String pidm, ComHelper comHelper)
	{
		List<Map<String, Object>> ncaaList = query(new Object[] { pidm }, studentQueryUtil.getNcaaCountQuery(), comHelper);
		if (!CollectionUtils.isEmpty(ncaaList))
		{
			return true;
		}
		return false;
	}

	/**
	 * Find Athlete Year for NCAA Marker
	 * 
	 * @param pidm
	 * @param level
	 * @param comHelper
	 * @return String
	 */
	@Override
	public String findAthleteYear(String pidm, String level, ComHelper comHelper)
	{
		String result = "0000";

		List<Map<String, Object>> athleteEnrolledCount = query(new Object[] { pidm }, studentQueryUtil.getFindAthleteYearCountQuery(), comHelper);

		//Enrolled Athlete Year
		if (!CollectionUtils.isEmpty(athleteEnrolledCount))
		{
			List<Map<String, Object>> athleteEnrolledYear = query(new Object[] { pidm }, studentQueryUtil.getFindAthleteYearEnrollQuery(), comHelper);
			if (!CollectionUtils.isEmpty(athleteEnrolledYear))
			{
				result = (String) athleteEnrolledYear.get(0).get("stvterm_acyr_code");
			}
		}
		//Not Enrolled Athlete Year
		else
		{
			List<Map<String, Object>> athleteNotEnrolledYear = query(new Object[] { pidm, level }, studentQueryUtil.getFindAthleteYearNotEnrollQuery(), comHelper);
			if (!CollectionUtils.isEmpty(athleteNotEnrolledYear))
			{
				result = (String) athleteNotEnrolledYear.get(0).get("stvterm_acyr_code");
			}
		}

		return result;
	}

	/**
	 * Load the student's course history.
	 * 
	 * @param pidm the student number
	 */
	@Override
	public List<Map<String, Object>> loadCourseHistory(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getCourseHistoryQuery(), comHelper);
	}
	
	public List<Map<String, Object>> loadCourseHistoryAtt(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getCourseHistoryQuery(), comHelper);
	}
	/**
	 * Load the student's transfer courses.
	 * 
	 * @param pidm the student number
	 */
	@Override
	public List<Map<String, Object>> loadPseudoCourses(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getPseudoCourseQuery(), comHelper);
	}

	/**
	 * Load the student's transfer courses.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> loadTransferCourses(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getTransferCourseQuery(), comHelper);
	}
	
	public List<Map<String, Object>> loadTransferCoursesAttCodes(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getTransferCourseQuery(), comHelper);
	}
	/**
	 * Load the student's current courses.
	 * 
	 * @param pidm the student number
	 * @param fromTerm the term range beginning
	 * @param toTerm the term range end
	 */
	@Override
	public List<Map<String, Object>> loadCurrentCourses(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getCurrentCourseQuery(), comHelper);
	}
	public List<Map<String, Object>> getSsrAttributes(String pidm, String term, String subject, String number, String crn, ComHelper comhelper)
	{
		comhelper.getLogger().trace("getSsrAttributes");
		comhelper.getLogger().trace("Query:" + studentQueryUtil.getSsrAttributeQuery());
		comhelper.getLogger().trace("Pidm:" + pidm);
		comhelper.getLogger().trace("term:" + term);
		comhelper.getLogger().trace("subject:" + subject);
		comhelper.getLogger().trace("number:" + number);
		comhelper.getLogger().trace("crn:" + crn);
		try
		{
			return bannerJdbcTemplate.queryForList(studentQueryUtil.getSsrAttributeQuery(), pidm, term, subject, number, crn);
		}
		catch(Exception e)
		{
			return new ArrayList<Map<String, Object>>();
		}
	}
	
	public List<Map<String, Object>> getShrAttributes(String pidm,  String trceSeqno,String tritSeqno, String tramSeqno,String trcrSeqno, ComHelper comhelper)
	{
		//(pidm,trceSeqno,tritSeqno, tramSeqno,trcrSeqno, comHelper);
		comhelper.getLogger().trace("getShrAttributes");
		comhelper.getLogger().trace("Query:" + studentQueryUtil.getShrAttributeQuery());
		comhelper.getLogger().trace("pidm:" + pidm);
		comhelper.getLogger().trace("trceSeqno:" + trceSeqno);
		comhelper.getLogger().trace("tritSeqno:" + tritSeqno);
		comhelper.getLogger().trace("tramSeqno:" + tramSeqno);
		comhelper.getLogger().trace("trcrSeqno:" + trcrSeqno);
		try
		{
			return bannerJdbcTemplate.queryForList(studentQueryUtil.getShrAttributeQuery(), pidm,trceSeqno,tritSeqno, tramSeqno,trcrSeqno);
		}
		catch(Exception e)
		{
			return new ArrayList<Map<String, Object>>();
		}
	}
	
	public List<Map<String, Object>> getCourseShrattcAttributeCode(String crn, String term, ComHelper comhelper)
	{
		comhelper.getLogger().trace("getCourseShrAttributes");
		comhelper.getLogger().trace("Query:" + studentQueryUtil.getShrattcAttributeCourseQuery());
		comhelper.getLogger().trace("CRN: " + crn);
		comhelper.getLogger().trace("term:" + term);
		
		try
		{ 
			return bannerJdbcTemplate.queryForList(studentQueryUtil.getShrattcAttributeCourseQuery(), crn, term);
		}
		catch(Exception e)
		{
			return new ArrayList<Map<String, Object>>();
		}
		
	}
	
	@Override
	public List<Map<String, Object>> getCourseShrattrAttributeCode(String pidm,String term, String seqNo, ComHelper comhelper)
	{
		comhelper.getLogger().trace("getCourseShrAttributes");
		comhelper.getLogger().trace("Query:" + studentQueryUtil.getShrattrAttributeCourseQuery());
		comhelper.getLogger().trace("Crs_yt:" + term);
		comhelper.getLogger().trace("PIDM: " + pidm);
		comhelper.getLogger().trace("Seq: " + seqNo);
		try
		{ 
			return bannerJdbcTemplate.queryForList(studentQueryUtil.getShrattrAttributeCourseQuery(), term , pidm, seqNo);
		}
		catch(Exception e)
		{
			comhelper.getLogger().error(e.getMessage());
			return new ArrayList<Map<String, Object>>();
		}
		
	}
	
	@Override
	public List<Map<String, Object>> getCourseSsrAttributeCode(String crn, String crsYt, ComHelper comhelper)
	{
		comhelper.getLogger().trace("getCourseShrAttributes");
		comhelper.getLogger().trace("Query:" + studentQueryUtil.getSsrAttributeCourseQuery());
		comhelper.getLogger().trace("Crs_yt:" + crsYt);
		comhelper.getLogger().trace("CRN: " + crn);
		try
		{ 
			return bannerJdbcTemplate.queryForList(studentQueryUtil.getSsrAttributeCourseQuery(), crsYt, crn);
		}
		catch(Exception e)
		{
			return new ArrayList<Map<String, Object>>();
		}
		
	}
	public List<Map<String, Object>> loadCurrentCoursesAttCodes(String pidm, ComHelper comHelper)
	{
		return query(new Object[] { pidm }, studentQueryUtil.getSsrAttributeCourseQuery(), comHelper);
	}
	/**
	 * Main Querying Method
	 * 
	 * @param emplid
	 * @param comHelper
	 * @return List<Map<String, Object>>
	 */
	private List<Map<String, Object>> query(Object[] args, String query, ComHelper comHelper)
	{
		if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("ENTER[" + Thread.currentThread().getStackTrace()[3].getMethodName() + "]");

		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		try
		{
			if (comHelper.getLogger().isTraceEnabled())
			{
				comHelper.getLogger().trace("Query: " + query);
				comHelper.getLogger().trace("Args: [" + Arrays.asList(args) + "]");
			}

			results = bannerJdbcTemplate.queryForList(query, args);
		}
		catch (Exception e)
		{
			if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("ERROR: Exception Thrown during " + Thread.currentThread().getStackTrace()[3].getMethodName() + ". Returning empty list.[" + e + "]");
		}

		if (comHelper.getLogger().isTraceEnabled()) comHelper.getLogger().trace(Thread.currentThread().getStackTrace()[3].getMethodName() + " Result[" + results + "]");
		return results;
	}

	/**
	 * Search for a student by first name and/or last name.
	 * 
	 * @param firstName
	 * @param lastName
	 */
	@Override
	public List<Map<String, Object>> searchForStudentByName(String firstName, String lastName, Logger logger)
	{
		String fName = StringUtils.isBlank(firstName) ? "%" : firstName + "%";
		String lName = StringUtils.isBlank(lastName) ? "%" : lastName + "%";

		return bannerJdbcTemplate.queryForList(studentQueryUtil.getFindByNameQuery(), fName, lName);
	}

	/**
	 * Search for a student by stuno.
	 * 
	 * @param stuno
	 */
	@Override
	public List<Map<String, Object>> searchForStudentByStuno(String stuno, Logger logger)
	{
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		String query = studentQueryUtil.getFindByStunoQuery();
		query = replaceOnce(query, "?", "'" + StringUtils.trim(stuno) + "'");

		if (logger.isDebugEnabled()) logger.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + " Query[" + query + "]");

		try
		{
			results = bannerJdbcTemplate.queryForList(query);
		}
		catch (DataAccessException dae)
		{
			logger.error("Exception in [" + Thread.currentThread().getStackTrace()[1].getMethodName() + "] e[" + dae + "]");
		}
		if (logger.isDebugEnabled()) logger.debug(MessageFormat.format(Thread.currentThread().getStackTrace()[1].getMethodName() + " Result: [{0}]", results));
		return results;
	}

	public void setBannerJdbcTemplate(JdbcTemplate bannerJdbcTemplate)
	{
		this.bannerJdbcTemplate = bannerJdbcTemplate;
	}

	public void setStudentQueryUtil(StudentQueryUtil studentQueryUtil)
	{
		this.studentQueryUtil = studentQueryUtil;
	}

}
