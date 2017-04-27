package com.collegesource.interfaces.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import uachieve.apis.student.StuAcadrec;
import uachieve.apis.support.ComHelper;

/**
 * This interface describes a DAO object for a Banner SIS.
 * 
 * @author Justin Neighbors
 */
public interface BannerDao
{
	/**
	 * Load the student pidm.
	 * 
	 * @param stuno the student number
	 */
	public String loadPidm(String stuno, ComHelper comHelper);

	/**
	 * Load the student name.
	 * 
	 * @param pidm the student number
	 */
	public String loadStudentName(String pidm, ComHelper comHelper);

	/**
	 * Find Advisor Name
	 * @param pidm
	 * @param comHelper
	 * @return String
	 */
	public String findAdvisorName(String pidm, ComHelper comHelper);
	
	/**
	 * Get Shrdgmr Data, currently used for GradDate
	 * @param pidm
	 * @param comHelper
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> findShrdgmrData(String pidm, ComHelper comHelper);
	
	/**
	 * Get student's CONCCODE1, MAJORCODE1, DEGCODE1
	 * 
	 * @PARAM stuno
	 */
	public List<Map<String, Object>> findDegreeProgramInfo(String pidm, ComHelper comHelper);

	/**
	 * Find the student's degree program information.
	 * 
	 * @param CONCCOND1 padded to 4 characters on the right
	 * @param majorCode padded to 4 characters on the right
	 * @param degreeCode padded to 6 characters on the right
	 */
	public List<Map<String, Object>> findCrosswalkDprog(String majorCode, String degreeCode, ComHelper comHelper);

	/**
	 * Determines if Student gets NCAA Marker
	 * @param pidm
	 * @param comHelper
	 * @return boolean
	 */
	public boolean isNcaa(String pidm, ComHelper comHelper);
	
	/**
	 * Find Athlete Year for NCAA Marker
	 * @param pidm
	 * @param level
	 * @param comHelper
	 * @return String
	 */
	public String findAthleteYear(String pidm, String level, ComHelper comHelper);
	
	/**
	 * Load the student's course history.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> loadCourseHistory(String pidm, ComHelper comHelper);

	/**
	 * Load the student's course history attributes.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> loadCourseHistoryAtt(String pidm, ComHelper comHelper);

	/**
	 * Load the student's pseudo courses.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> loadPseudoCourses(String pidm, ComHelper comHelper);

	/**
	 * Load the student's transfer courses.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> loadTransferCourses(String pidm, ComHelper comHelper);

	/**
	 * Load the student's transfer courses.
	 * 
	 * @param pidm the student number
	 */
	public List<Map<String, Object>> getSsrAttributes(String pidm, String term, String subject,
			String number, String crn, ComHelper comhelper);
	
	public List<Map<String, Object>> getShrAttributes(String pidm,  String trceSeqno,String tritSeqno, String tramSeqno,String trcrSeqno, ComHelper comhelper);
	
	public List<Map<String, Object>> getCourseShrattcAttributeCode(String crn, String term, ComHelper comhelper);
	
	public List<Map<String, Object>> getCourseShrattrAttributeCode(String pidm,String term, String seqNo, ComHelper comHelper);
	
	List<Map<String, Object>> getCourseSsrAttributeCode(String crn,	String crsYt, ComHelper comhelper);
	/**
	 * Load the student's current courses.
	 * 
	 * @param pidm the student number
	 * @param fromTerm the term range beginning
	 * @param toTerm the term range end
	 */
	public List<Map<String, Object>> loadCurrentCourses(String pidm, ComHelper comHelper);

	/**
	 * Searches for a student by first name and/or last name
	 * 
	 * @param firstName
	 * @param lastName
	 */
	public List<Map<String, Object>> searchForStudentByName(String firstName, String lastName, Logger logger);

	/**
	 * Searches for a student by stuno
	 * 
	 * @param stuno
	 */
	public List<Map<String, Object>> searchForStudentByStuno(String stuno, Logger logger);
}
