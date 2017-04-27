package com.collegesource.interfaces.student.program;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.util.CollectionUtils;

import com.collegesource.interfaces.student.dao.BannerDao;

import uachieve.apis.common.logger.Logger;
import uachieve.apis.student.StuDprog;
import uachieve.apis.student.StuMarkerReq;
import uachieve.apis.student.StuMaster;
import uachieve.apis.support.ComHelper;

public class BannerMarkerFactory
{
	private ComHelper	comHelper;
	private BannerDao	dao;

	public BannerMarkerFactory(ComHelper comHelper, BannerDao dao)
	{
		setComHelper(comHelper);
		setDao(dao);
	}

	/**
	 * Find the markers for the dprog in the dprog group.
	 * 
	 * @param dprog the StuDprog record
	 * @param group a dprog group
	 */
	public List<StuMarkerReq> findMarkers(StuMaster student, StuDprog dprog, DprogGroup group)
	{
		List<StuMarkerReq> markers = new ArrayList<StuMarkerReq>();
		boolean createdNcaa = false;
		int bsbuMajorCount = 0;

		if (log().isDebugEnabled()) log().debug("Group[" + group + "]");
		
		for (Map<String, Object> row : group.getList())
		{
			String lfstCode = StringUtils.trimToEmpty((String) row.get("SOVLFOS_LFST_CODE"));
			String degcCode = StringUtils.trimToEmpty((String) row.get("DEGC_CODE"));
			String majrCode = StringUtils.trimToEmpty((String) row.get("MAJOR_CODE"));
			
			if (StringUtils.equals("MAJOR", lfstCode) && StringUtils.equalsIgnoreCase(degcCode, "BSBU"))
			{
				List<Map<String, Object>> dprogList = getDao().findCrosswalkDprog(majrCode, degcCode, getComHelper());

				if (CollectionUtils.isEmpty(dprogList))
				{
					log().debug("No dprogs found in crosswalk for majrCode[" + group + "] and degcCode[" + degcCode + "]");
				}
				else
				{		
					bsbuMajorCount++;
					
					for(Map<String, Object> map : dprogList)
					{
						String dprogName = StringUtils.trimToEmpty((String) map.get("DPROG"));
						
						log().debug("Found dprog in crosswalk [" + dprogName + "]");
						
						StuMarkerReq marker = new StuMarkerReq();

						marker.setMarker("$MAJOR");
						marker.setDrtype("D"); //configurable to either D or R
						marker.setDrval(dprogName);
						marker.setStuDprog(dprog);

						markers.add(marker);

						if (log().isDebugEnabled())
						{
							log().debug("Marker[" + marker.getDrval() + "] created: " + marker.toString());
						}
					}
				}
			}

			log().debug("There were [" + bsbuMajorCount + "] BSBU majors found for the student");
			
			if(bsbuMajorCount > 1)
			{
				StuMarkerReq marker2 = new StuMarkerReq();

				marker2.setMarker("$BU2MJRS");
				marker2.setDrtype("D"); //configurable to either D or R
				marker2.setDrval("BU2MJRS");
				marker2.setStuDprog(dprog);

				markers.add(marker2);

				if (log().isDebugEnabled())
				{
					log().debug("Marker[" + marker2.getDrval() + "] created: " + marker2.toString());
				}
			}
			
			if (StringUtils.equals("MINOR", StringUtils.trimToEmpty((String) row.get("SOVLFOS_LFST_CODE"))))
			{
				StuMarkerReq marker = new StuMarkerReq();

				marker.setMarker("$MINOR");
				marker.setDrtype("D"); //configurable to either D or R
				marker.setDrval(StringUtils.trimToEmpty((String) row.get("MAJOR_CODE")));
				marker.setStuDprog(dprog);

				markers.add(marker);

				if (log().isDebugEnabled())
				{
					log().debug("Marker[" + marker.getDrval() + "] created: " + marker.toString());
				}
			}

			if (StringUtils.equals("CONCENTRATION", StringUtils.trimToEmpty((String) row.get("SOVLFOS_LFST_CODE"))))
			{
				StuMarkerReq marker = new StuMarkerReq();

				marker.setMarker("$CONC");
				marker.setDrtype("D"); //configurable to either D or R
				marker.setDrval(StringUtils.trimToEmpty((String) row.get("MAJOR_CODE")));
				marker.setStuDprog(dprog);

				markers.add(marker);

				if (log().isDebugEnabled())
				{
					log().debug("Marker[" + marker.getDrval() + "] created: " + marker.toString());
				}
			}

			if (!createdNcaa && StringUtils.startsWithIgnoreCase(getComHelper().findByComfield(ComHelper.CLIENTS), "Y") && getDao().isNcaa((String) student.getCustomObject(), getComHelper()))
			{
				StuMarkerReq marker = new StuMarkerReq();

				marker.setMarker("$NCAA");
				marker.setDrtype("D"); //configurable to either D or R
				marker.setDrval("NCAA" + getDao().findAthleteYear((String) student.getCustomObject(), StringUtils.trimToEmpty((String) row.get("LEVEL_CODE")), getComHelper()));
				marker.setStuDprog(dprog);

				markers.add(marker);

				if (log().isDebugEnabled())
				{
					log().debug("Marker[" + marker.getDrval() + "] created: " + marker.toString());
				}
				createdNcaa = true;
			}
		}

		String collegeCode = dprog.getCustomObject().toString();
		log().debug("Got CollegeCode from Dprog[" + collegeCode + "] (Checked for HSS Marker)");

		if (StringUtils.equalsIgnoreCase(collegeCode, "EN") || StringUtils.equalsIgnoreCase(collegeCode, "AE"))
		{
			StuMarkerReq marker = new StuMarkerReq();

			marker.setMarker("$HSS");
			marker.setDrtype("D"); //configurable to either D or R
			marker.setDrval("HSSR");
			marker.setStuDprog(dprog);

			markers.add(marker);

			if (log().isDebugEnabled())
			{
				log().debug("Marker[" + marker.getDrval() + "] created: " + marker.toString());
			}
		}

		return markers;
	}

	public ComHelper getComHelper()
	{
		return comHelper;
	}

	public void setComHelper(ComHelper comHelper)
	{
		this.comHelper = comHelper;
	}

	public BannerDao getDao()
	{
		return dao;
	}

	public void setDao(BannerDao dao)
	{
		this.dao = dao;
	}

	public Logger log()
	{
		return getComHelper().getLogger();
	}
}
