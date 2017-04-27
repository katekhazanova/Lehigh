package com.collegesource.interfaces.student.util;

public class StudentQueryUtil
{
	private String	pidmQuery;
	private String	nameQuery;

	private String	courseHistoryQuery;
	private String	currentCourseQuery;
	private String	pseudoCourseQuery;
	private String	transferCourseQuery;

	private String	findByStunoQuery;
	private String	findByNameQuery;

	//Queries for pulling DPROGs
	private String	dprogQuery;
	private String  crosswalkQuery;
	private String	markerQuery;
	private String  ncaaCountQuery;
	private String  findAthleteYearCountQuery;
	private String  findAthleteYearEnrollQuery;
	private String  findAthleteYearNotEnrollQuery;
	
	private String ssrAttributeQuery;
	private String ssrAttributeCourseQuery;
	
	private String shrAttributeQuery;
	
	private String shrattcAttributeCourseQuery;
	private String shrattrAttributeCourseQuery;
	
	private String	clineQuery;
	private String  szvinstQuery;
	private String  dprogFlagQuery;
	
	private String findAdvisorNameQuery;
	private String findShrdgmrDataQuery;

	/**
	 * @return the pidmQuery
	 */
	public String getPidmQuery()
	{
		return pidmQuery;
	}

	/**
	 * @return the nameQuery
	 */
	public String getNameQuery()
	{
		return nameQuery;
	}

	/**
	 * @return the dprogQuery
	 */
	public String getDprogQuery()
	{
		return dprogQuery;
	}

	/**
	 * @return the crosswalkQuery
	 */
	public String getCrosswalkQuery()
	{
		return crosswalkQuery;
	}

	/**
	 * @return the courseHistoryQuery
	 */
	public String getCourseHistoryQuery()
	{
		return courseHistoryQuery;
	}

	/**
	 * @return the currentCourseQuery
	 */
	public String getCurrentCourseQuery()
	{
		return currentCourseQuery;
	}

	/**
	 * @return the pseudoCourseQuery
	 */
	public String getPseudoCourseQuery()
	{
		return pseudoCourseQuery;
	}

	/**
	 * @return the findByStunoQuery
	 */
	public String getFindByStunoQuery()
	{
		return findByStunoQuery;
	}

	/**
	 * @return the findByNameQuery
	 */
	public String getFindByNameQuery()
	{
		return findByNameQuery;
	}

	/**
	 * @param pidmQuery the pidmQuery to set
	 */
	public void setPidmQuery(String pidmQuery)
	{
		this.pidmQuery = pidmQuery;
	}

	/**
	 * @param nameQuery the nameQuery to set
	 */
	public void setNameQuery(String nameQuery)
	{
		this.nameQuery = nameQuery;
	}

	/**
	 * @param dprogQuery the dprogQuery to set
	 */
	public void setDprogQuery(String dprogQuery)
	{
		this.dprogQuery = dprogQuery;
	}

	/**
	 * @param crosswalkQuery the crosswalkQuery to set
	 */
	public void setCrosswalkQuery(String crosswalkQuery)
	{
		this.crosswalkQuery = crosswalkQuery;
	}

	/**
	 * @param courseHistoryQuery the courseHistoryQuery to set
	 */
	public void setCourseHistoryQuery(String courseHistoryQuery)
	{
		this.courseHistoryQuery = courseHistoryQuery;
	}

	/**
	 * @param currentCourseQuery the currentCourseQuery to set
	 */
	public void setCurrentCourseQuery(String currentCourseQuery)
	{
		this.currentCourseQuery = currentCourseQuery;
	}

	/**
	 * @param pseudoCourseQuery the pseudoCourseQuery to set
	 */
	public void setPseudoCourseQuery(String pseudoCourseQuery)
	{
		this.pseudoCourseQuery = pseudoCourseQuery;
	}

	/**
	 * @param findByStunoQuery the findByStunoQuery to set
	 */
	public void setFindByStunoQuery(String findByStunoQuery)
	{
		this.findByStunoQuery = findByStunoQuery;
	}

	/**
	 * @param findByNameQuery the findByNameQuery to set
	 */
	public void setFindByNameQuery(String findByNameQuery)
	{
		this.findByNameQuery = findByNameQuery;
	}

	public String getTransferCourseQuery()
	{
		return transferCourseQuery;
	}

	public void setTransferCourseQuery(String transferCourseQuery)
	{
		this.transferCourseQuery = transferCourseQuery;
	}

	public String getClineQuery()
	{
		return clineQuery;
	}

	public void setClineQuery(String clineQuery)
	{
		this.clineQuery = clineQuery;
	}

	public String getMarkerQuery()
	{
		return markerQuery;
	}

	public void setMarkerQuery(String markerQuery)
	{
		this.markerQuery = markerQuery;
	}

	public String getNcaaCountQuery()
	{
		return ncaaCountQuery;
	}

	public void setNcaaCountQuery(String ncaaCountQuery)
	{
		this.ncaaCountQuery = ncaaCountQuery;
	}

	public String getFindAthleteYearCountQuery()
	{
		return findAthleteYearCountQuery;
	}

	public String getSsrAttributeQuery()
	{
		return ssrAttributeQuery;
	}
	public void setSsrAttributeQuery(String ssrAttributeQuery)
	{
		this.ssrAttributeQuery = ssrAttributeQuery;
	}
	public String getSsrAttributeCourseQuery()
	{
		return ssrAttributeCourseQuery;
	}
	public void setSsrAttributeCourseQuery(String ssrAttributeCourseQuery)
	{
		this.ssrAttributeCourseQuery = ssrAttributeCourseQuery;
	}
	public String getShrAttributeQuery()
	{
		return shrAttributeQuery;
	}
	public void setShrAttributeQuery(String shrAttributeQuery)
	{
		this.shrAttributeQuery = shrAttributeQuery;
	}
	public String getShrattcAttributeCourseQuery()
	{
		return shrattcAttributeCourseQuery;
	}
	public void setShrattcAttributeCourseQuery(String shrattcAttributeCourseQuery)
	{
		this.shrattcAttributeCourseQuery = shrattcAttributeCourseQuery;
	}
	public String getShrattrAttributeCourseQuery()
	{
		return shrattrAttributeCourseQuery;
	}
	public void setShrattrAttributeCourseQuery(String shrattrAttributeCourseQuery)
	{
		this.shrattrAttributeCourseQuery = shrattrAttributeCourseQuery;
	}
	
	public void setFindAthleteYearCountQuery(String findAthleteYearCountQuery)
	{
		this.findAthleteYearCountQuery = findAthleteYearCountQuery;
	}

	public String getFindAthleteYearEnrollQuery()
	{
		return findAthleteYearEnrollQuery;
	}

	public void setFindAthleteYearEnrollQuery(String findAthleteYearEnrollQuery)
	{
		this.findAthleteYearEnrollQuery = findAthleteYearEnrollQuery;
	}

	public String getFindAthleteYearNotEnrollQuery()
	{
		return findAthleteYearNotEnrollQuery;
	}

	public void setFindAthleteYearNotEnrollQuery(String findAthleteYearNotEnrollQuery)
	{
		this.findAthleteYearNotEnrollQuery = findAthleteYearNotEnrollQuery;
	}

	public String getSzvinstQuery()
	{
		return szvinstQuery;
	}

	public void setSzvinstQuery(String szvinstQuery)
	{
		this.szvinstQuery = szvinstQuery;
	}

	public String getDprogFlagQuery()
	{
		return dprogFlagQuery;
	}

	public void setDprogFlagQuery(String dprogFlagQuery)
	{
		this.dprogFlagQuery = dprogFlagQuery;
	}

	public String getFindAdvisorNameQuery()
	{
		return findAdvisorNameQuery;
	}

	public void setFindAdvisorNameQuery(String findAdvisorNameQuery)
	{
		this.findAdvisorNameQuery = findAdvisorNameQuery;
	}

	public String getFindShrdgmrDataQuery()
	{
		return findShrdgmrDataQuery;
	}

	public void setFindShrdgmrDataQuery(String findShrdgmrDataQuery)
	{
		this.findShrdgmrDataQuery = findShrdgmrDataQuery;
	}
}
