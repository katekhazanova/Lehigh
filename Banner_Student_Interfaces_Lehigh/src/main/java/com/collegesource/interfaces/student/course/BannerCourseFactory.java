package com.collegesource.interfaces.student.course;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

import com.collegesource.interfaces.student.dao.BannerDao;

import uachieve.apis.student.StuAcadrec;
import uachieve.apis.student.StuAcadrecPK;
import uachieve.apis.student.StuMaster;
import uachieve.apis.support.ComHelper;

/**
 * BannerCourseFactory
 * 
 * @author Justin Neighbors
 * 
 */
public class BannerCourseFactory /*extends CourseFactoryInterface*/
{
	private ComHelper	comHelper;
	private BannerDao	dao;
	private int			deptBegin	= 0;
	private int			deptLength	= 0;
	private int			crsLength	= 0;
	private String		instid		= "";
	private String		instcd		= "";

	/**
	 * Constructor
	 * 
	 * @param comHelper
	 * @param dao
	 */
	public BannerCourseFactory(ComHelper comHelper, BannerDao dao)
	{
		this.comHelper = comHelper;
		this.dao = dao;
		this.deptBegin = Integer.valueOf(comHelper.findByComfield(ComHelper.DEPTBGN));
		this.deptLength = Integer.valueOf(comHelper.findByComfield(ComHelper.DEPTLNG));
		this.crsLength = Integer.valueOf(comHelper.findByComfield(ComHelper.CRSLNG));
		this.instid = comHelper.findByComfield(ComHelper.INSTID);
		this.instcd = comHelper.findByComfield(ComHelper.INSTCD);
	}

	/**
	 * Top Method to Process Courses
	 * 
	 * @param student
	 */
	public List<StuAcadrec> processCourses(StuMaster student)
	{
		StuAcadrec course = null;

		//Make a list of course numbers to check against to ensure courses aren't duplicated
		SortedMap<String, StuAcadrec> finalCourseMap = new TreeMap<String, StuAcadrec>();

		String pidm = (String) student.getCustomObject();

		//Add courses from course history
		for (Map<String, Object> courseMap : dao.loadCourseHistory(pidm, comHelper))
		{
			course = createHistoricCourse(student, courseMap, "", "");
			
			if (!StringUtils.isBlank(course.getComp_id().getCrsNum()))
			{
				finalCourseMap.put(course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsNum() + " " + courseMap.get("CRN"), course);

				comHelper.getLogger().debug("Past course added: [" + course.getComp_id().getCrsNum() + "] [" + course.getCtitle() + "] [" + course.getRcredit() + "] [" + course.getGrade() + "]");
			}
			else
			{
				comHelper.getLogger().debug("Past course Number Blank [" + courseMap.get("CRN") + " " + course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsSeq() + "]");
			}

			comHelper.getLogger().debug("============================================================");
		}

		//Add current courses
		for (Map<String, Object> courseMap : dao.loadCurrentCourses(pidm, comHelper))
		{
			course = createCurrentCourse(student, courseMap, "", "");

			if (!StringUtils.isBlank(course.getComp_id().getCrsNum()))
			{
				//If the course is already in the courseList
				if (!finalCourseMap.containsKey(course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsNum() + " " + courseMap.get("CRN")))
				{
					finalCourseMap.put(course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsNum() + " " + courseMap.get("CRN"), course);
					comHelper.getLogger().debug("Current course added: [" + course.getComp_id().getCrsNum() + "] [" + course.getCtitle() + "] [" + course.getRcredit() + "] [" + course.getGrade() + "]");
				}
				else
				{
					comHelper.getLogger().debug("Current course Found In History[" + courseMap.get("CRN") + " " + course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsNum() + " " + course.getComp_id().getCrsSeq() + "]");
				}
			}
			else
			{
				comHelper.getLogger().debug("Current course Blank[" + courseMap.get("CRN") + " " + course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsSeq() + "]");
			}

			comHelper.getLogger().debug("============================================================");
		}

		//Add transfer courses
		for (Map<String, Object> courseMap : dao.loadTransferCourses(pidm, comHelper))
		{
			course = createTransferCourse(student, courseMap, "", "E");

			if (!StringUtils.isBlank(course.getComp_id().getCrsNum()))
			{
				finalCourseMap.put(course.getComp_id().getCrsYt() + " " + course.getComp_id().getCrsNum() + " " + courseMap.get("CRN"), course);
				comHelper.getLogger()
						.debug("Transfer course added: Num[" + course.getComp_id().getCrsNum() + "] CTitle[" + course.getCtitle() + "] RCredit[" + course.getRcredit() + "] Grade[" + course.getGrade() + "] RGrade[" + course.getRgrade() + "]");
			}

			comHelper.getLogger().debug("============================================================");
		}

		return new ArrayList<StuAcadrec>(finalCourseMap.values());
	}

	/**
	 * Create StuAcadrec Object
	 * 
	 * @param student
	 * @param courseMap the course map
	 * @param pflg determines if this is a pseudo-course
	 * @param evalflg determines if this is a transfer course
	 * @return StuAcadrec
	 */
	public StuAcadrec createCurrentCourse(StuMaster student, Map<String, Object> courseMap, String pflg, String evalflg)
	{
		StuAcadrec course = new StuAcadrec();
		StuAcadrecPK pk = new StuAcadrecPK();

		String crsYt = (String) courseMap.get("YEARTERM");
		String crsNum = formatCourseNumber((String) courseMap.get("DEPT"), (String) courseMap.get("NUM"));
		String grade = StringUtils.trimToEmpty(formatGrade((String) courseMap.get("GRADE")));
		String title = StringUtils.trimToEmpty((String) courseMap.get("TITLE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		String repeat = (String) courseMap.get("REPEAT");
		//boolean isRepeat = false;
		BigDecimal rcredit = (BigDecimal) courseMap.get("RCREDIT");
		String rgrade = "";

		//Set Actual Grade to 'CR' if Grade is 'TR' and set RGrade to 'TR' to display on the audit
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			rgrade = "TR";
			grade = "CR";
			//Reset RGrade to 'AP' if RTitle is 'APTEST'
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				rgrade = "AP";
			}
		}
		/* YSK 3/10/2017 they no longer wish for * to be stripped off the grade
        else
		{
			if (!StringUtils.equalsIgnoreCase(grade, "IP"))
			{
				if (StringUtils.startsWithIgnoreCase(grade, "*"))
				{
					grade = grade.substring(1);
				}
			}
		}*/

		if (StringUtils.isNotBlank(repeat))
		{
			//Doesn't do anything, may want to ask about it being an asterisk
			course.setRtext(">R");
			//isRepeat = true;
		}

		if (rcredit == null)
		{
			rcredit = new BigDecimal(0);
		}

		//String cLine = StringUtils.rightPad(crsYt, 6) + " " + StringUtils.rightPad(crsNum, 8) + " " + StringUtils.rightPad(cLineGrade, 3) + " " + rcredit + "  " + (isRepeat ? "*" : " ");
		//comHelper.getLogger().debug(MessageFormat.format("CLine for this course is [{0}]", cLine));

		pk.setStuMaster(student);
		pk.setSourceId(instid);
		pk.setSourceCd(instcd);
		pk.setCdpmask("");
		pk.setCrsSeq("");
		pk.setCrsYt(crsYt);
		pk.setCrsNum(crsNum);

		course.setComp_id(pk);
		course.setGrade(grade);
		if (!StringUtils.isBlank(rgrade))
		{
			course.setRgrade(rgrade);
		}
		course.setRepeatf(repeat);
		course.setCtitle(title);
		//course.setRtitle(rtitle);
		course.setRcredit(rcredit);
		course.setPflg(pflg);
		course.setEvalflg(evalflg);

		//course.setCline(cLine);

		//Add Condition Code
		BannerCourseConditionCodeFactory bcccf = new BannerCourseConditionCodeFactory(comHelper, dao);
		String condCodes = bcccf.findCurrentConditionCodes(courseMap);
		course.setCondc(condCodes);

		//addConditionCodes(course);

		return course;
	}

	public StuAcadrec createTransferCourse(StuMaster student, Map<String, Object> courseMap, String pflg, String evalflg)
	{
		StuAcadrec course = new StuAcadrec();
		StuAcadrecPK pk = new StuAcadrecPK();

		String crsYt = (String) courseMap.get("YEARTERM");
		String crsNum = formatCourseNumber((String) courseMap.get("DEPT"), (String) courseMap.get("NUM"));
		
		String grade = StringUtils.trimToEmpty(formatGrade((String) courseMap.get("GRADE")));
		String title = StringUtils.trimToEmpty((String) courseMap.get("TITLE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		String repeat = (String) courseMap.get("REPEAT");
		//boolean isRepeat = false;
		BigDecimal rcredit = (BigDecimal) courseMap.get("RCREDIT");
		String rgrade = "";

		//Set Actual Grade to 'CR' if Grade is 'TR' and set RGrade to 'TR' to display on the audit
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			rgrade = "TR";
			grade = "CR";
			//Reset RGrade to 'AP' if RTitle is 'APTEST'
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				rgrade = "AP";
			}
		}
		/* YSK 3/10/2017 they no longer wish for * to be stripped off the grade
        else
		{
			if (!StringUtils.equalsIgnoreCase(grade, "IP"))
			{
				if (StringUtils.startsWithIgnoreCase(grade, "*"))
				{
					grade = grade.substring(1);
				}
			}
		}*/

		if (StringUtils.isNotBlank(repeat))
		{
			//Doesn't do anything, may want to ask about it being an asterisk
			course.setRtext(">R");
			//isRepeat = true;
		}

		if (rcredit == null)
		{
			rcredit = new BigDecimal(0);
		}

		//String cLine = StringUtils.rightPad(crsYt, 6) + " " + StringUtils.rightPad(crsNum, 8) + " " + StringUtils.rightPad(cLineGrade, 3) + " " + rcredit + "  " + (isRepeat ? "*" : " ");
		//comHelper.getLogger().debug(MessageFormat.format("CLine for this course is [{0}]", cLine));

		pk.setStuMaster(student);
		pk.setSourceId(instid);
		pk.setSourceCd(instcd);
		pk.setCdpmask("");
		pk.setCrsSeq("");
		pk.setCrsYt(crsYt);
		pk.setCrsNum(crsNum);

		course.setComp_id(pk);
		course.setGrade(grade);
		if (!StringUtils.isBlank(rgrade))
		{
			course.setRgrade(rgrade);
		}
		course.setRepeatf(repeat);
		course.setCtitle(title);
		//course.setRtitle(rtitle);
		course.setRcredit(rcredit);
		course.setPflg(pflg);
		course.setEvalflg(evalflg);

		//course.setCline(cLine);

		//Add Condition Code
		BannerCourseConditionCodeFactory bcccf = new BannerCourseConditionCodeFactory(comHelper, dao);
		String condCodes = bcccf.findTransferConditionCodes(courseMap);
		course.setCondc(condCodes);

		//addConditionCodes(course);

		return course;
	}

	public StuAcadrec createHistoricCourse(StuMaster student, Map<String, Object> courseMap, String pflg, String evalflg)
	{
		StuAcadrec course = new StuAcadrec();
		StuAcadrecPK pk = new StuAcadrecPK();

		String crsYt = (String) courseMap.get("YEARTERM");
		String crsNum = formatCourseNumber((String) courseMap.get("DEPT"), (String) courseMap.get("NUM"));
		String grade = StringUtils.trimToEmpty(formatGrade((String) courseMap.get("GRADE")));
		String title = StringUtils.trimToEmpty((String) courseMap.get("TITLE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		String repeat = (String) courseMap.get("REPEAT");
		//boolean isRepeat = false;
		BigDecimal rcredit = (BigDecimal) courseMap.get("RCREDIT");
		String rgrade = "";

		//Set Actual Grade to 'CR' if Grade is 'TR' and set RGrade to 'TR' to display on the audit
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			rgrade = "TR";
			grade = "CR";
			//Reset RGrade to 'AP' if RTitle is 'APTEST'
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				rgrade = "AP";
			}
		}
		/* YSK 3/10/2017 they no longer wish for * to be stripped off the grade
        else
		{
			if (!StringUtils.equalsIgnoreCase(grade, "IP"))
			{
				if (StringUtils.startsWithIgnoreCase(grade, "*"))
				{
					grade = grade.substring(1);
				}
			}
		}*/

		if (StringUtils.isNotBlank(repeat))
		{
			//Doesn't do anything, may want to ask about it being an asterisk
			course.setRtext(">R");
			//isRepeat = true;
		}

		if (rcredit == null)
		{
			rcredit = new BigDecimal(0);
		}

		//String cLine = StringUtils.rightPad(crsYt, 6) + " " + StringUtils.rightPad(crsNum, 8) + " " + StringUtils.rightPad(cLineGrade, 3) + " " + rcredit + "  " + (isRepeat ? "*" : " ");
		//comHelper.getLogger().debug(MessageFormat.format("CLine for this course is [{0}]", cLine));

		pk.setStuMaster(student);
		pk.setSourceId(instid);
		pk.setSourceCd(instcd);
		pk.setCdpmask("");
		pk.setCrsSeq("");
		pk.setCrsYt(crsYt);
		pk.setCrsNum(crsNum);

		course.setComp_id(pk);
		course.setGrade(grade);
		if (!StringUtils.isBlank(rgrade))
		{
			course.setRgrade(rgrade);
		}
		course.setRepeatf(repeat);
		course.setCtitle(title);
		//course.setRtitle(rtitle);
		course.setRcredit(rcredit);
		course.setPflg(pflg);
		course.setEvalflg(evalflg);

		//course.setCline(cLine);

		//Add Condition Code
		BannerCourseConditionCodeFactory bcccf = new BannerCourseConditionCodeFactory(comHelper, dao);
		String condCodes = bcccf.findHistoricalConditionCodes(courseMap);
		course.setCondc(condCodes);

		//addConditionCodes(course);

		return course;
	}

	/**
	 * Format the grade.
	 * 
	 * @param courseMap the map corresponding to a course
	 */
	private String formatGrade(String grade)
	{
		return grade;
		//return StringUtils.rightPad(grade, 4);
	}

	/**
	 * Format the course number.
	 * 
	 * @param dept the department
	 * @param num the number
	 */
	private String formatCourseNumber(String dept, String num)
	{
		StringBuffer course = new StringBuffer();
		course.append(StringUtils.rightPad("", (deptBegin - 1)));

		String pdept = StringUtils.rightPad(StringUtils.trim(dept), deptLength);
		String pnum = StringUtils.rightPad(StringUtils.trim(num), crsLength);

		course.append(pdept);
		course.append(pnum);

		return course.toString();
	}

	/**
	 * Format the fromTerm and toTerm values.
	 */
	/*	private void formatTerms()
		{
			String term = comHelper.findByComfield(ComHelper.CLIENTS).trim();
	
			if (term != null && StringUtils.isNotBlank(term))
			{
				String code = term.substring(0, 1);
				String year = term.substring(1);
	
				if (code.equals("1"))
				{
					fromTerm = year + "10";
					toTerm = year + "40";
				}
				else if (code.equals("2"))
				{
					fromTerm = year + "20";
					toTerm = year + "40";
				}
				else if (code.equals("3"))
				{
					fromTerm = year + "40";
					toTerm = (Integer.parseInt(year) + 1) + "10";
				}
				else if (code.equals("4"))
				{
					fromTerm = year + "20";
					toTerm = year + "30";
					//TODO Need Third Variable
					toTerm = (Integer.parseInt(year) + 1) + "10";
				}
				else
				{
					comHelper.getLogger().warn("The COM-CLIENTS value doesn't resolve to valid terms");
				}
			}
			else
			{
				comHelper.getLogger().warn("The COM-CLIENTS value doesn't exist");
			}
		}
	*/
}
