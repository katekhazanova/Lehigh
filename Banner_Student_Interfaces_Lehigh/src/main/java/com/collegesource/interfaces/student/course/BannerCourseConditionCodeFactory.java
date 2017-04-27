package com.collegesource.interfaces.student.course;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.collegesource.interfaces.student.dao.BannerDao;

import uachieve.apis.support.ComHelper;

public class BannerCourseConditionCodeFactory
{
	private BannerDao	bannerDao;
	private ComHelper	comHelper;

	public BannerCourseConditionCodeFactory(ComHelper comHelper, BannerDao bannerDao)
	{
		this.bannerDao = bannerDao;
		this.comHelper = comHelper;
	}
	public String findCurrentConditionCodes(Map<String, Object> courseMap)
	{
		comHelper.getLogger().debug("Attempting to get condition codes");

		StringBuffer result = new StringBuffer();

		String crsID = (String) courseMap.get("DEPT");
		String crsNum = (String) courseMap.get("NUM");
		String crn = (String) courseMap.get("CRN");
		String crsYt = (String) courseMap.get("YEARTERM");
		String grade = StringUtils.trimToEmpty((String) courseMap.get("GRADE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		BigDecimal rCredit = (BigDecimal) courseMap.get("RCREDIT");
		String repeat = (String) courseMap.get("REPEAT");
		
		int courseNum = Integer.parseInt(StringUtils.trimToEmpty(crsNum));
		comHelper.getLogger().debug("CourseNum: " + courseNum);
		String gmodCode = (String) courseMap.get("GMOD_CODE");
		String attrCode = (String) courseMap.get("ATTR_CODE");
		List<Map<String, Object>> ssrAttList = bannerDao.getCourseSsrAttributeCode(crn, crsYt, comHelper);
		comHelper.getLogger().debug("Size of list: " + ssrAttList.size());
	
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				result.append("A");
			}
			else
			{
				result.append("T");
			}
		}

		//ComHelper.REDEF56
		comHelper.getLogger().debug("Credits:" + rCredit);
		if (rCredit.compareTo(new BigDecimal(2.0)) > 0)
		{
			result.append("3");
		}
		else if (rCredit.compareTo(new BigDecimal(1.0)) == 0)
		{
			result.append("1");
		}
		//		comHelper.getLogger().debug(MessageFormat.format("Adding course number condition codes using courseNum [{0}]", courseNum));
		if (courseNum < 100)
		{
			result.append(")");
		}
		else if (courseNum < 200)
		{
			result.append("!");
		}
		else if (courseNum < 300)
		{
			result.append("@");
		}
		else if (courseNum < 400)
		{
			result.append("#");
		}

		if (courseNum < 400)
		{
			result.append("U");
		}
		else
		{
			result.append("G");
		}

		if (StringUtils.equals(gmodCode, "P"))
		{
			result.append("P");
		}
		for(Map<String, Object> ssrAttCodeMap : ssrAttList)
		{
			attrCode = (String) ssrAttCodeMap.get("ATTR_CODE");
			if (StringUtils.equals(attrCode, "WRIT"))
			{
			result.append("w");
			}
			if (StringUtils.equals(attrCode, "NS"))
			{
				result.append("n");
			}
			if (StringUtils.equals(attrCode, "HU"))
			{
			result.append("h");
			}
			if (StringUtils.equals(attrCode, "SS"))
			{
			result.append("s");
			}
			if (StringUtils.equals(attrCode, "MA"))
			{
				result.append("m");
			}
			if (StringUtils.equals(attrCode, "BUG"))
			{
				result.append("g");
			}
			if (StringUtils.equals(attrCode, "BUD"))
			{
			result.append("d");
			}
			if (StringUtils.equals(attrCode, "LS"))
			{
				result.append("l");
			}
		}
		if (StringUtils.isNotBlank(repeat))
		{
			comHelper.getLogger().debug("Processing repeat course with repeat value of: " + repeat);
			result.append("?");
			switch (repeat)
			{
				case "E":
					result.append("XR");
					break;
				case "A":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("R");
					}
					else
					{
						result.append("X");
					}
				case "X":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("X");
					}
					else
					{
						result.append("R");
					}
					break;
				case "I":
					break;
				default:
					break;
			}
		}

		//TODO

		/*		017add         select f_class_calc_fnc(:ws-pidm,
						017add                                  a.sgbstdn_levl_code,
						017add                                  :CSQL-YT)
						017add         into :ws-classification
						017add         from saturn.sgbstdn a
						017add         where a.sgbstdn_pidm = :ws-pidm
						017add           and a.sgbstdn_term_code_eff =
						017add              (select max(b.sgbstdn_term_code_eff)
						017add               from saturn.sgbstdn b
						017add               where b.sgbstdn_pidm = a.sgbstdn_pidm
						017add                 and b.sgbstdn_term_code_eff <= :CSQL-YT)
						017add     end-exec.
						017add**
						017add     if sqlcode = 0 and ws-classification not = spaces
						017add         evaluate ws-classification
						017add             when 'FR'
						017add                 move 'F'        to class-cond-code
						017add             when 'SO'
						017add                 move 'O'        to class-cond-code
						017add             when 'JR'
						017add                 move 'J'        to class-cond-code
						017add             when 'SR'
						017add                 move 'S'        to class-cond-code
						017add             when other
						017add                 move space      to class-cond-code
						017add         end-evaluate
						017add     end-if.*/

		comHelper.getLogger().debug(MessageFormat.format("Condition codes set for courseId [{0}] and subject:[{1}] are [{2}]", crsID, crsNum, result.toString()));

		return result.toString();
	}

	public String findHistoricalConditionCodes(Map<String, Object> courseMap)
	{
		comHelper.getLogger().debug("Attempting to get condition codes");

		StringBuffer result = new StringBuffer();

		String crsID = (String) courseMap.get("DEPT");
		String crsNum = (String) courseMap.get("NUM");

		String grade = StringUtils.trimToEmpty((String) courseMap.get("GRADE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		BigDecimal rCredit = (BigDecimal) courseMap.get("RCREDIT");
		String repeat = (String) courseMap.get("REPEAT");

		int courseNum = Integer.parseInt(StringUtils.trimToEmpty(crsNum));
		comHelper.getLogger().debug("CourseNum: " + courseNum);
		String gmodCode = (String) courseMap.get("GMOD_CODE");
		String attrCode = (String) courseMap.get("ATTR_CODE");
		String pidm = String.valueOf((BigDecimal) courseMap.get("PIDM"));
		String seqno = String.valueOf((BigDecimal) courseMap.get("SEQNO"));
		String term = (String) courseMap.get("YEARTERM");
		String crn = (String) courseMap.get("CRN");
		List<Map<String, Object>> shrattrAttList = bannerDao.getCourseShrattrAttributeCode(pidm,term, seqno, comHelper);
		List<Map<String, Object>> shrattcAttList = bannerDao.getCourseShrattcAttributeCode(crn,term, comHelper);
		//getCourseShrattrAttributeCode(String pidm,String term, String subject, String seqNo, String crn, ComHelper comHelper)
		
		comHelper.getLogger().debug("Size of list: " + shrattrAttList.size());		
		
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				result.append("A");
			}
			else
			{
				result.append("T");
			}
		}

		//ComHelper.REDEF56
		comHelper.getLogger().debug("Credits:" + rCredit);
		if (rCredit.compareTo(new BigDecimal(2.0)) > 0)
		{
			result.append("3");
		}
		else if (rCredit.compareTo(new BigDecimal(1.0)) == 0)
		{
			result.append("1");
		}
		//		comHelper.getLogger().debug(MessageFormat.format("Adding course number condition codes using courseNum [{0}]", courseNum));
		if (courseNum < 100)
		{
			result.append(")");
		}
		else if (courseNum < 200)
		{
			result.append("!");
		}
		else if (courseNum < 300)
		{
			result.append("@");
		}
		else if (courseNum < 400)
		{
			result.append("#");
		}

		if (courseNum < 400)
		{
			result.append("U");
		}
		else
		{
			result.append("G");
		}

		if (StringUtils.equals(gmodCode, "P"))
		{
			result.append("P");
		}
		for(Map<String, Object> shrAttCodeMap : shrattrAttList)
		{
			attrCode = (String) shrAttCodeMap.get("ATTR_CODE");
			if (StringUtils.equals(attrCode, "WRIT"))
			{
				result.append("w");
			}
			if (StringUtils.equals(attrCode, "NS"))
			{
				result.append("n");
			}
			if (StringUtils.equals(attrCode, "HU"))
			{
			result.append("h");
			}
			if (StringUtils.equals(attrCode, "SS"))
			{
			result.append("s");
			}
			if (StringUtils.equals(attrCode, "MA"))
			{
				result.append("m");
			}
			if (StringUtils.equals(attrCode, "BUG"))
			{
				result.append("g");
			}
			if (StringUtils.equals(attrCode, "BUD"))
			{
			result.append("d");
			}
			if (StringUtils.equals(attrCode, "LS"))
			{
				result.append("l");
			}
		}
		for(Map<String, Object> shrattcAttCodeMap : shrattcAttList)
		{
			attrCode = (String) shrattcAttCodeMap.get("ATTR_CODE");
			if (StringUtils.equals(attrCode, "WRIT"))
			{
			result.append("w");
			}
			if (StringUtils.equals(attrCode, "NS"))
			{
				result.append("n");
			}
			if (StringUtils.equals(attrCode, "HU"))
			{
			result.append("h");
			}
			if (StringUtils.equals(attrCode, "SS"))
			{
			result.append("s");
			}
			if (StringUtils.equals(attrCode, "MA"))
			{
				result.append("m");
			}
			if (StringUtils.equals(attrCode, "BUG"))
			{
				result.append("g");
			}
			if (StringUtils.equals(attrCode, "BUD"))
			{
			result.append("d");
			}
			if (StringUtils.equals(attrCode, "LS"))
			{
				result.append("l");
			}
		}
		if (StringUtils.isNotBlank(repeat))
		{
			comHelper.getLogger().debug("Processing repeat course with repeat value of: " + repeat);
			result.append("?");
			switch (repeat)
			{
				case "E":
					result.append("XR");
					break;
				case "A":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("R");
					}
					else
					{
						result.append("X");
					}
				case "X":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("X");
					}
					else
					{
						result.append("R");
					}
					break;
				case "I":
					break;
				default:
					break;
			}
		}

		//TODO

		/*		017add         select f_class_calc_fnc(:ws-pidm,
						017add                                  a.sgbstdn_levl_code,
						017add                                  :CSQL-YT)
						017add         into :ws-classification
						017add         from saturn.sgbstdn a
						017add         where a.sgbstdn_pidm = :ws-pidm
						017add           and a.sgbstdn_term_code_eff =
						017add              (select max(b.sgbstdn_term_code_eff)
						017add               from saturn.sgbstdn b
						017add               where b.sgbstdn_pidm = a.sgbstdn_pidm
						017add                 and b.sgbstdn_term_code_eff <= :CSQL-YT)
						017add     end-exec.
						017add**
						017add     if sqlcode = 0 and ws-classification not = spaces
						017add         evaluate ws-classification
						017add             when 'FR'
						017add                 move 'F'        to class-cond-code
						017add             when 'SO'
						017add                 move 'O'        to class-cond-code
						017add             when 'JR'
						017add                 move 'J'        to class-cond-code
						017add             when 'SR'
						017add                 move 'S'        to class-cond-code
						017add             when other
						017add                 move space      to class-cond-code
						017add         end-evaluate
						017add     end-if.*/

		comHelper.getLogger().debug(MessageFormat.format("Condition codes set for courseId [{0}] and subject:[{1}] are [{2}]", crsID, crsNum, result.toString()));

		return result.toString();
	}
	public String findTransferConditionCodes(Map<String, Object> courseMap)
	{
		comHelper.getLogger().debug("Attempting to get condition codes");

		StringBuffer result = new StringBuffer();

		String crsID = (String) courseMap.get("DEPT");
		String crsNum = (String) courseMap.get("NUM");

		String grade = StringUtils.trimToEmpty((String) courseMap.get("GRADE"));
		String rtitle = StringUtils.trimToEmpty((String) courseMap.get("RTITLE"));
		BigDecimal rCredit = (BigDecimal) courseMap.get("RCREDIT");
		String repeat = (String) courseMap.get("REPEAT");

		int courseNum = Integer.parseInt(StringUtils.trimToEmpty(crsNum));
		comHelper.getLogger().debug("CourseNum: " + courseNum);
		String gmodCode = (String) courseMap.get("GMOD_CODE");
		String attrCode = (String) courseMap.get("ATTR_CODE");
		String attrCode2="";
		String pidm = String.valueOf((BigDecimal) courseMap.get("PIDM"));
		String trceSeqno = String.valueOf((BigDecimal) courseMap.get("TRCE_SEQNO"));
		String tritSeqno = String.valueOf((BigDecimal) courseMap.get("TRIT_SEQNO"));
		String tramSeqno = String.valueOf((BigDecimal) courseMap.get("TRAM_SEQNO"));
		String trcrSeqno = String.valueOf((BigDecimal) courseMap.get("TRCR_SEQNO"));
		
		
		List<Map<String, Object>> shrattAttList = bannerDao.getShrAttributes(pidm,trceSeqno,tritSeqno, tramSeqno,trcrSeqno, comHelper);
		comHelper.getLogger().debug("List size: " + shrattAttList.size());
		if(courseMap.get("ATTR_CODE_2")!=null)
		{
			attrCode2 = (String) courseMap.get("ATTR_CODE_2");
		}
		if (StringUtils.equalsIgnoreCase(grade, "TR"))
		{
			if (StringUtils.equalsIgnoreCase(rtitle, "APTEST"))
			{
				result.append("A");
			}
			else
			{
				result.append("T");
			}
		}

		//ComHelper.REDEF56
		comHelper.getLogger().debug("Credits:" + rCredit);
		if (rCredit.compareTo(new BigDecimal(2.0)) > 0)
		{
			result.append("3");
		}
		else if (rCredit.compareTo(new BigDecimal(1.0)) == 0)
		{
			result.append("1");
		}
		//		comHelper.getLogger().debug(MessageFormat.format("Adding course number condition codes using courseNum [{0}]", courseNum));
		if (courseNum < 100)
		{
			result.append(")");
		}
		else if (courseNum < 200)
		{
			result.append("!");
		}
		else if (courseNum < 300)
		{
			result.append("@");
		}
		else if (courseNum < 400)
		{
			result.append("#");
		}

		if (courseNum < 400)
		{
			result.append("U");
		}
		else
		{
			result.append("G");
		}

		if (StringUtils.equals(gmodCode, "P"))
		{
			result.append("P");
		}
		for(Map<String, Object> shrAttCodeMap : shrattAttList)
		{
			attrCode = (String) shrAttCodeMap.get("ATTR_CODE");
			if (StringUtils.equals(attrCode, "WRIT"))
			{
			result.append("w");
			}
			if (StringUtils.equals(attrCode, "NS"))
			{
				result.append("n");
			}
			if (StringUtils.equals(attrCode, "HU"))
			{
			result.append("h");
			}
			if (StringUtils.equals(attrCode, "SS"))
			{
			result.append("s");
			}
			if (StringUtils.equals(attrCode, "MA"))
			{
				result.append("m");
			}
			if (StringUtils.equals(attrCode, "BUG"))
			{
				result.append("g");
			}
			if (StringUtils.equals(attrCode, "BUD"))
			{
			result.append("d");
			}
			if (StringUtils.equals(attrCode, "LS"))
			{
				result.append("l");
			}
		}
		if (StringUtils.isNotBlank(repeat))
		{
			comHelper.getLogger().debug("Processing repeat course with repeat value of: " + repeat);
			result.append("?");
			switch (repeat)
			{
				case "E":
					result.append("XR");
					break;
				case "A":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("R");
					}
					else
					{
						result.append("X");
					}
				case "X":
					if (StringUtils.equalsIgnoreCase(comHelper.findByComfield(ComHelper.REDEF56), "Y"))
					{
						result.append("X");
					}
					else
					{
						result.append("R");
					}
					break;
				case "I":
					break;
				default:
					break;
			}
		}

		//TODO

		/*		017add         select f_class_calc_fnc(:ws-pidm,
						017add                                  a.sgbstdn_levl_code,
						017add                                  :CSQL-YT)
						017add         into :ws-classification
						017add         from saturn.sgbstdn a
						017add         where a.sgbstdn_pidm = :ws-pidm
						017add           and a.sgbstdn_term_code_eff =
						017add              (select max(b.sgbstdn_term_code_eff)
						017add               from saturn.sgbstdn b
						017add               where b.sgbstdn_pidm = a.sgbstdn_pidm
						017add                 and b.sgbstdn_term_code_eff <= :CSQL-YT)
						017add     end-exec.
						017add**
						017add     if sqlcode = 0 and ws-classification not = spaces
						017add         evaluate ws-classification
						017add             when 'FR'
						017add                 move 'F'        to class-cond-code
						017add             when 'SO'
						017add                 move 'O'        to class-cond-code
						017add             when 'JR'
						017add                 move 'J'        to class-cond-code
						017add             when 'SR'
						017add                 move 'S'        to class-cond-code
						017add             when other
						017add                 move space      to class-cond-code
						017add         end-evaluate
						017add     end-if.*/

		comHelper.getLogger().debug(MessageFormat.format("Condition codes set for courseId [{0}] and subject:[{1}] are [{2}]", crsID, crsNum, result.toString()));

		return result.toString();
	}
}
