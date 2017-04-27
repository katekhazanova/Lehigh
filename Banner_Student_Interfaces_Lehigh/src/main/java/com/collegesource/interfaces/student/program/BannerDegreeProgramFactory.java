package com.collegesource.interfaces.student.program;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.springframework.util.CollectionUtils;
import com.collegesource.interfaces.student.dao.BannerDao;
import uachieve.apis.common.logger.Logger;
import uachieve.apis.student.StuDprog;
import uachieve.apis.student.StuDprogPK;
import uachieve.apis.student.StuMarkerReq;
import uachieve.apis.student.StuMaster;
import uachieve.apis.support.ComHelper;

/**
 * This factory builds student degree programs from a Banner SIS.
 * BannerDegreeProgramFactory
 * 
 * @author Justin Neighbors
 * 
 */
public class BannerDegreeProgramFactory
{
	private ComHelper	comHelper;
	private BannerDao	dao;
	private String 		topText;
	private String 		whatIfTopText;

	/**
	 * Constructor
	 * 
	 * @param comHelper
	 * @param dao
	 * @param whatIfTopText 
	 */
	public BannerDegreeProgramFactory(ComHelper comHelper, BannerDao dao, String topText, String whatIfTopText)
	{
		setComHelper(comHelper);
		setDao(dao);
		setTopText(topText);
		setWhatIfTopText(whatIfTopText);
	}

	/**
	 * Top Method for Degree Program Processing
	 * 
	 * @param StuMaster student
	 */
	public void processDegreePrograms(StuMaster student)
	{
		String whatIfDprog = getComHelper().findByComfield(ComHelper.DPROG);
		String pidm = (String) student.getCustomObject();

		if (StringUtils.isBlank(whatIfDprog))
		{
			List<StuDprog> dprogList = new ArrayList<StuDprog>();

			List<Map<String, Object>> degreeProgramData = loadDegreePrograms(pidm);

			if (CollectionUtils.isEmpty(degreeProgramData))
			{
				log().error("The student doesn't have a default degree program.");

				student.setStuDprogs(new ArrayList<StuDprog>());
				return;
			}

			dprogList = buildDegreePrograms(student, degreeProgramData);

			student.setStuDprogs(dprogList);
			
			comHelper.editByComfield(ComHelper.INCLUDETEXTTOP, topText);
		}
		else
		{
			log().debug("This is a what-if audit. No need to look up dprog in Banner.");
			comHelper.editByComfield(ComHelper.INCLUDETEXTTOP, whatIfTopText);
		}
	}

	private List<Map<String, Object>> loadDegreePrograms(String pidm)
	{
		return getDao().findDegreeProgramInfo(pidm, getComHelper());
	}

	/**
	 * Build Degree Programs From Banner Data
	 * 
	 * @param student
	 * @param degreeProgramList
	 * @return List<StuDprog>
	 */
	public List<StuDprog> buildDegreePrograms(StuMaster student, List<Map<String, Object>> degreeProgramList)
	{
		List<DprogGroup> dprogGroups = groupBannerResults(degreeProgramList);
		List<DprogGroup> splitGroups = splitDprogGroups(dprogGroups);
		List<StuDprog> dprogList = generateStudentDegreePrograms(student, splitGroups);

		return dprogList;
	}

	private List<DprogGroup> splitDprogGroups(List<DprogGroup> dprogGroups)
	{
		List<DprogGroup> result = new ArrayList<DprogGroup>();
		//Split out the Major records
		//Duplicating Markers through them
		//BSBU curriculum groups should stay together.
		comHelper.getLogger().debug("Splitting the Results of our sorted and group SOVLCUR/FOS records.");
		for(DprogGroup dg : dprogGroups)
		{
			List<Map<String, Object>> rows = dg.getList();		
			if(StringUtils.equalsIgnoreCase((String)rows.get(0).get("PROGRAM_CODE"), "BSBU"))
			{
				comHelper.getLogger().debug("DprogGroup is BSBU. Leave it alone.");
				//This program should be left alone
				result.add(dg);
			}
			else //Looks like a BA degree
			{
				//Split rows between Major and other rows
				//Combine after we're through all the rows in this dprogGroup
				comHelper.getLogger().debug("DprogGroup is non-BSBU. All Majors are seperate DprogGroups. Splitting.");
				List<Map<String, Object>> majorRows = new ArrayList<Map<String, Object>>();
				List<Map<String, Object>> otherRows = new ArrayList<Map<String, Object>>();
				for(Map<String, Object> row : rows)
				{
					if(StringUtils.equalsIgnoreCase((String)row.get("SOVLFOS_LFST_CODE"), "MAJOR"))
					{
						comHelper.getLogger().debug("Found Major Row.");
						majorRows.add(row);
						comHelper.getLogger().debug("Row:" + row.toString());
					}
					else
					{
						comHelper.getLogger().debug("Found Other Row.");
						otherRows.add(row);
						comHelper.getLogger().debug("Row:" + row.toString());
					}
				}
				comHelper.getLogger().debug("MajorRows: " + majorRows.toString());
				comHelper.getLogger().debug("OtherRows: " + otherRows.toString());
				
				for(Map<String, Object> majorRow : majorRows)
				{
					DprogGroup dprog = new DprogGroup();
					dprog.addToList(majorRow);
					dprog.addAllToList(otherRows);
					result.add(dprog);
				}
			}
		}
		return result;
	}

	/**
	 * Sorts the Banner results by sovlcur_seqno so majors, minors, and
	 * concentrations are grouped together.
	 * 
	 * @param bannerDegreeProgramResults
	 */
	@SuppressWarnings("null")
	public List<DprogGroup> groupBannerResults(List<Map<String, Object>> bannerDegreeProgramResults)
	{
		List<DprogGroup> groups = new ArrayList<DprogGroup>();

		int activeSovlcurSeqNo = -1;
		DprogGroup group = null;

		for (Map<String, Object> map : bannerDegreeProgramResults)
		{
			int sovlcurSeqNo = ((BigDecimal) map.get("SOVLCUR_SEQNO")).intValue();

			if (sovlcurSeqNo == activeSovlcurSeqNo)
			{
				group.addToList(map);
			}
			else
			{
				group = new DprogGroup();
				group.addToList(map);
				groups.add(group);

				activeSovlcurSeqNo = sovlcurSeqNo;
			}
		}

		return groups;
	}

	/**
	 * Create a list of StuDprog objects from the dprog groups.
	 * 
	 * @param dprogGroups a list of sorted dprog groups
	 */
	public List<StuDprog> generateStudentDegreePrograms(StuMaster student, List<DprogGroup> dprogGroups)
	{
		List<StuDprog> dprogList = new ArrayList<StuDprog>();

		BannerMarkerFactory markerFactory = new BannerMarkerFactory(comHelper, dao);

		for (DprogGroup group : dprogGroups)
		{
			StuDprog dprog = findDprog(student, group);

			if (dprog != null)
			{
				List<StuMarkerReq> markers = markerFactory.findMarkers(student, dprog, group);
				dprog.getStuMarkerReqs().addAll(markers);

				dprogList.add(dprog);
			}
		}

		return dprogList;
	}

	/**
	 * Find the dprog in the dprog group.
	 * 
	 * @param group a dprog group
	 */
	public StuDprog findDprog(StuMaster student, DprogGroup group)
	{
		for (Map<String, Object> map : group.getList())
		{
			if (StringUtils.equals("MAJOR", StringUtils.trimToEmpty((String) map.get("SOVLFOS_LFST_CODE"))))
			{
				//group.removeFromList(map);
				return createStuDprog(student, map);
			}
		}

		log().error("StuDprog not found in sovlcur table");
		return null;
	}

	/**
	 * Create a StuDprog object from the results map.
	 * 
	 * @param map the results map
	 */
	public StuDprog createStuDprog(StuMaster student, Map<String, Object> map)
	{
		String dprogName = "Not Found In Crosswalk";
		if (StringUtils.equalsIgnoreCase(StringUtils.trimToEmpty((String) map.get("DEGC_CODE")), "BSBU"))
		{
			dprogName = "BSBU";
		}
		else
		{
			List<Map<String, Object>> dprogList = getDao().findCrosswalkDprog(StringUtils.trimToEmpty((String) map.get("MAJOR_CODE")), StringUtils.trimToEmpty((String) map.get("DEGC_CODE")), getComHelper());

			if (!CollectionUtils.isEmpty(dprogList))
			{
				dprogName = StringUtils.trimToEmpty((String) dprogList.get(0).get("DPROG"));
			}
		}

		StuDprog dprog = new StuDprog();
		StuDprogPK dprogPK = new StuDprogPK();

		dprogPK.setStuMaster(student);
		dprog.setComp_id(dprogPK);
		dprog.setStuMarkerReqs(new ArrayList<StuMarkerReq>());
		String catlyt = StringUtils.trimToEmpty((String) map.get("CATLYT"));

		log().debug(MessageFormat.format("Found DPROG [{0}] and catlyt [{1}]", dprogName, catlyt));

		dprogPK.setDprog(dprogName);
		dprog.setDrcatlyt(catlyt);

		dprog.setCustomObject(StringUtils.trimToEmpty((String) map.get("COLLEGE_CODE")));

		return dprog;
	}

	/**
	 * @return the comHelper
	 */
	public ComHelper getComHelper()
	{
		return comHelper;
	}

	/**
	 * @return the dao
	 */
	public BannerDao getDao()
	{
		return dao;
	}

	public void setComHelper(ComHelper comHelper)
	{
		this.comHelper = comHelper;
	}

	public void setDao(BannerDao dao)
	{
		this.dao = dao;
	}

	public void setTopText(String topText) 
	{
		this.topText = topText;
	}
	
	public void setWhatIfTopText(String whatIfTopText) 
	{
		this.whatIfTopText = whatIfTopText;
	}

	public Logger log()
	{
		return getComHelper().getLogger();
	}
}