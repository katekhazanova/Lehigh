package com.collegesource.interfaces.student;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.CollectionUtils;

import com.collegesource.interfaces.student.course.BannerCourseFactory;
import com.collegesource.interfaces.student.dao.BannerDao;
import com.collegesource.interfaces.student.program.BannerDegreeProgramFactory;
import com.collegesource.interfaces.student.util.TextFileUtil;
import com.redlantern.interfaces.student.StudentDataLoader;

import uachieve.apis.student.StuAcadrec;
import uachieve.apis.student.StuDemo;
import uachieve.apis.student.StuDemoPK;
import uachieve.apis.student.StuMaster;
import uachieve.apis.support.ComHelper;

public class BannerStudentDataLoader implements StudentDataLoader
{
	private BannerDao bannerDao;

	private String topText;
	private String whatIfTopText;
	
	/**
	 * Load the student and degree program information.
	 * 
	 * @param comHelper a ComHelper instance
	 */
	@Override
	public StuMaster load(ComHelper comHelper)
	{
		comHelper.getLogger().debug("====================START Student Data Loader====================");
		StuMaster student = initializeStudent(comHelper);

		comHelper.getLogger().debug("====================START Degree Program Loader====================");
		BannerDegreeProgramFactory dpf = new BannerDegreeProgramFactory(comHelper, getBannerDao(), topText, whatIfTopText);
		dpf.processDegreePrograms(student);

		setFullDemo(student, comHelper);

		comHelper.getLogger().debug("====================END Degree Program Loader====================");

		return student;
	}

	/**
	 * Load the student's course information.
	 * 
	 * @param student the student object
	 * @param comHelper a ComHelper instance
	 * 
	 * @return a list of student courses
	 */
	@Override
	public List<StuAcadrec> loadCourses(StuMaster student, ComHelper comHelper)
	{
		comHelper.getLogger().debug("====================START Student Course Loader====================");
		BannerCourseFactory bcf = new BannerCourseFactory(comHelper, getBannerDao());
		List<StuAcadrec> results = bcf.processCourses(student);
		comHelper.getLogger().debug("====================END Student Course Loader====================");
		return results;
	}

	/**
	 * Initialize the student from the u.achieve database.
	 * 
	 * @param comHelper a ComHelper instance
	 */
	private StuMaster initializeStudent(ComHelper comHelper)
	{
		comHelper.getLogger().debug("Initializing Student Object");
		String stuno = comHelper.findByComfield(ComHelper.STUID);
		String instidq = comHelper.findByComfield(ComHelper.INSTIDQ);
		String instid = comHelper.findByComfield(ComHelper.INSTID);

		String pidm = getBannerDao().loadPidm(stuno, comHelper);

		StuMaster student = new StuMaster();

		if (StringUtils.isBlank(pidm))
		{
			//throw new RuntimeException(MessageFormat.format("PIDM not found using studentId [{0}]", stuno));
			comHelper.getLogger().warn(MessageFormat.format("PIDM not found using studentId [{0}]", stuno));
			student.setCustomObject("");
		}
		else
		{
			// We have to store the Banner PIDM in the custom object because it's not a property on the regular StuMaster object 
			student.setCustomObject(pidm);
		}

		student.setStuno(stuno);
		student.setInstidq(instidq);
		student.setInstid(instid);

		createStuDemos(student, comHelper);

		return student;
	}

	/**
	 * Create and set the StuDemo list.
	 * 
	 * @param student
	 * @param comHelper
	 */
	private void createStuDemos(StuMaster student, ComHelper comHelper)
	{
		String pidm = (String) student.getCustomObject();
		String name = getBannerDao().loadStudentName(pidm, comHelper);

		if (StringUtils.isBlank(name))
		{
			comHelper.getLogger().warn(MessageFormat.format("Student name not found using pidm [{0}]", pidm));
		}
		else
		{
			comHelper.editByComfield(ComHelper.NAME, name);
		}

		comHelper.getLogger().debug(MessageFormat.format("Student name [{0}] found for PIDM [{1}]", name, pidm));

		StuDemo demo = new StuDemo();
		StuDemoPK demoPK = new StuDemoPK();

		demoPK.setStuMaster(student);
		demo.setComp_id(demoPK);
		demo.setStuname(name);

		student.setStuDemos(new ArrayList<StuDemo>());
		student.getStuDemos().add(demo);
	}

	/**
	 * Set Full Demo
	 * 
	 * @param student
	 * @param comHelper
	 */
	private void setFullDemo(StuMaster student, ComHelper comHelper)
	{
		if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("Creating FULLDEMO");

		boolean isWhatif = StringUtils.isNotBlank(comHelper.findByComfield(ComHelper.DPROG));
		String initFlg = StringUtils.trimToEmpty(comHelper.findByComfield(ComHelper.INITFLG));
		String ncol = StringUtils.trimToEmpty(comHelper.findByComfield(ComHelper.NCOL));
		String rptType = StringUtils.trimToEmpty(comHelper.findByComfield(ComHelper.RPTTYPE));

		if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("isWhatif[" + isWhatif + "] initFlg[" + initFlg + "] ncol[" + ncol + "] rptType[" + rptType + "]");

		//Get Advisor Name
		String advisorName = StringUtils.trimToEmpty(StringUtils.substring(getBannerDao().findAdvisorName((String) student.getCustomObject(), comHelper), 0, 26));

		//Get Grad Date
		List<Map<String, Object>> shrdgmrData = getBannerDao().findShrdgmrData((String) student.getCustomObject(), comHelper);
		String gradDate = "";
		String gradCatlyt = "";
		if (!CollectionUtils.isEmpty(shrdgmrData))
		{
			gradDate = StringUtils.trimToEmpty((String) shrdgmrData.get(0).get("GRAD_DATE"));
			gradCatlyt = StringUtils.trimToEmpty((String) shrdgmrData.get(0).get("GRAD_CATLYT"));
		}

		//Get Catlyt
		String catlyt = comHelper.findByComfield(ComHelper.CATLYT);
		if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("Catlyt from Com[" + catlyt + "]");
		if (StringUtils.isBlank(catlyt))
		{
			if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("Is Blank, Searching Student's Dprog");
			if (!CollectionUtils.isEmpty(student.getStuDprogs()))
			{
				catlyt = student.getStuDprogs().get(0).getDrcatlyt();
				if (comHelper.getLogger().isDebugEnabled()) comHelper.getLogger().debug("Found on Dprog[" + catlyt + "]");
			}
		}

		//TODO Only creating 1 column audits
		//Start Building FullDemo
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();

		if (StringUtils.equalsIgnoreCase(initFlg, "C") || (StringUtils.equalsIgnoreCase(initFlg, "P") && StringUtils.equalsIgnoreCase(ncol, "1")))
		{
			//ONE COLUMN 
			sb2.append("ADVISOR: " + advisorName);

			if (isWhatif)
			{
				sb.append(StringUtils.rightPad("This is a 'WHAT IF' audit", 35));
			}
			else
			{
				sb.append(StringUtils.rightPad("GRADUATION DATE: " + gradDate, 35));
			}

			//sb.append("                ");

		}
		else
		{
			//TWO COLUMN
			if (isWhatif)
			{
				sb.append(StringUtils.rightPad("This is a 'WHAT IF' audit", 36));
			}
			else
			{
				sb.append(StringUtils.rightPad("GRADUATION DATE: " + gradDate, 36));
			}

			sb.append(StringUtils.rightPad("ADVISOR: " + advisorName, 44));

		}

		sb.append(StringUtils.rightPad("CATALOG YEAR: " + catlyt, 20));

		//String fullDemo = StringUtils.substring(sb.toString(), 0, 105);
		String demo = sb2.toString();
		String fullDemo = sb.toString();
		comHelper.getLogger().debug("Setting DEMO[" + demo + "]");
		comHelper.editByComfield(ComHelper.DEMO, demo);

		comHelper.getLogger().debug("Setting FULLDEMO[" + fullDemo + "]");
		comHelper.editByComfield(ComHelper.FULLDEMO, fullDemo);

		//Set Grad Catlyt on COM
		if (StringUtils.isNotBlank(gradCatlyt))
		{
			comHelper.getLogger().debug("Setting Grad Date on COM[" + gradCatlyt + "]");
			comHelper.editByComfield(ComHelper.DEGDATE, gradCatlyt);
		}
	}

	/**
	 * Set the bannerDao instance.
	 * 
	 * @param bannerDao
	 */
	public void setBannerDao(BannerDao bannerDao)
	{
		this.bannerDao = bannerDao;
	}

	public BannerDao getBannerDao()
	{
		return bannerDao;
	}

	public void setTopText(ClassPathResource topFile)
	{
		String text = TextFileUtil.getText(topFile);

		this.topText = text;
	}
	
	public void setWhatIfTopText(ClassPathResource whatIfTopFile)
	{
		String text = TextFileUtil.getText(whatIfTopFile);

		this.whatIfTopText = text;
	}
}