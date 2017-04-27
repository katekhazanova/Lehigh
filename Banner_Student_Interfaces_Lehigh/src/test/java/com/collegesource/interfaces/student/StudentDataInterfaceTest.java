package com.collegesource.interfaces.student;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import com.redlantern.interfaces.student.StudentDataLoader;

import uachieve.apis.common.logger.DefaultLoggerImpl;
import uachieve.apis.student.StuAcadrec;
import uachieve.apis.student.StuDprog;
import uachieve.apis.student.StuMarkerReq;
import uachieve.apis.student.StuMaster;
import uachieve.apis.support.ComHelper;
import uachieve.apis.support.ComTable;
import uachieve.apis.support.ComTablePK;

/**
 * @author neighborsj
 */
public class StudentDataInterfaceTest
{
	private ApplicationContext											context;
	private StudentDataLoader											sdl;
	private JdbcTemplate												bannerJdbcTemplate;
	private static final uachieve.apis.common.logger.DefaultLoggerImpl	logger		= new DefaultLoggerImpl();

	//COMKEY MUST BE CONFIGURED
	private String														COMKEY		= "ONL";
	private String														COMFIELD	= "";

	private String														STUNO		= "891573024";

	private String														LOG_DIR		= "C:\\Users\\neighborsj\\Documents\\workspace-sts-3.3.0.RELEASE\\Banner_Student_Interfaces\\";
	private String														LOG_NAME	= "log";
	private String														LOG_LEVEL	= "T";

	private String														INSTIDQ;
	private String														INSTID;
	private String														INSTCD;
	private String														DEPTBGN;
	private String														DEPTLNG;
	private String														CRSLNG;
	private String														CLIENTS;

	public static void main(String[] args)
	{
		StudentDataInterfaceTest sdiTest = createNew();
		sdiTest.start();
	}

	private static StudentDataInterfaceTest createNew()
	{
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[] { "customClassContext.xml" });

		StudentDataInterfaceTest sdiTest = new StudentDataInterfaceTest(context);
		return sdiTest;
	}

	private StudentDataInterfaceTest(ApplicationContext context)
	{
		this.context = context;
		this.sdl = (StudentDataLoader) this.context.getBean("customStudentDataLoader");
		this.bannerJdbcTemplate = (JdbcTemplate) this.context.getBean("bannerJdbcTemplate");
	}

	private StudentDataInterfaceTest()
	{}

	/**
	 * Run the StudentDataInterfaces
	 */
	public void start()
	{
		System.out.println("START");
		
		ComHelper comHelper = buildCom();

		Long startLoad = System.nanoTime();
		StuMaster student = sdl.load(comHelper);
		Long endLoad = System.nanoTime();

		Long startLoadCourses = System.nanoTime();
		List<StuAcadrec> courses = sdl.loadCourses(student, comHelper);
		Long endLoadCourses = System.nanoTime();
		student.setStuAcadrecs(courses);

		comHelper.getLogger().info("");
		comHelper.getLogger().info("Load Time[" + ((endLoad - startLoad) / 1000000000.0) + "]");
		comHelper.getLogger().info("CourseLoad Time[" + ((endLoadCourses - startLoadCourses) / 1000000000.0) + "]");

		print(student, comHelper);
		
		System.out.println("END");
	}

	/**
	 * Print Student Object
	 * 
	 * @param student
	 */
	private void print(StuMaster student, ComHelper comHelper)
	{
		comHelper.getLogger().info("");
		
		//Print the Student
		comHelper.getLogger().info("==========StuMaster Object==========");
		
		comHelper.getLogger().info("StuMaster [stuno [" + student.getStuno()
				+ "] stuname [" + student.getStuDemos().get(0).getStuname() + "] ]");
		
		comHelper.getLogger().info("");

		comHelper.getLogger().info("==========StuDprog Objects==========");
		//Print Dprogs and Markers
		for (StuDprog dprog : student.getStuDprogs())
		{
			comHelper.getLogger().info("StuDprog [instcd [" + dprog.getComp_id().getInstcd()
					+ "] dprog [" + dprog.getComp_id().getDprog()
					+ "] drcatlyt [" + dprog.getDrcatlyt()
					+ "] dpmask [" + dprog.getDpmask()
					+ "] topText [" + dprog.getTopText()
					+ "] botText [" + dprog.getBottomText() + "] ]");

			for (StuMarkerReq marker : dprog.getStuMarkerReqs())
			{
				comHelper.getLogger().info("     StuMarkerReq [ marker [" + marker.getMarker()
						+ "] drval [" + marker.getDrval()
						+ "] drtype [" + marker.getDrtype()
						+ "] drcatlyt [" + marker.getDrcatlyt() + "] ]");
			}
		}

		comHelper.getLogger().info("");
		
		comHelper.getLogger().info("==========StuAcadrec Objects==========");
		//Print Courses
		for (StuAcadrec stuAcadrec : student.getStuAcadrecs()) {
			logger.info("StuAcadrec [term [" + stuAcadrec.getComp_id().getCrsYt()
					+ "] course [" + stuAcadrec.getComp_id().getCrsNum()
					+ "] seq_no [" + stuAcadrec.getComp_id().getCrsSeq()
					+ "] r_cred [" + stuAcadrec.getRcredit()							
					+ "] grade [" + stuAcadrec.getGrade()
					+ "] e_cred [" + stuAcadrec.getEcredit()
					+ "] gpa_hr [" + stuAcadrec.getGpahrs()
					+ "] gpa_pt [" + stuAcadrec.getGpapts() + "]" 
					+ "conds [" + stuAcadrec.getCondc() + "]"
					+" title [" + (stuAcadrec.getCtitle() == null ? "" : stuAcadrec.getCtitle()) +"] "
					+" xcrs [" + (stuAcadrec.getXcourse() == null ? "" : stuAcadrec.getXcourse()) +"] "
					+" rtitle [" + (stuAcadrec.getRtitle() == null ? "" : stuAcadrec.getRtitle()) +"] ]");
		}

		comHelper.getLogger().info("");
		
		comHelper.getLogger().info("==========ComHelper Objects==========");
		//Print Com Fields
		comHelper.getLogger().info("InclTopText [" + comHelper.findByComfield(ComHelper.INCLUDETEXTTOP) + "]");
		comHelper.getLogger().info("InclBotText [" + comHelper.findByComfield(ComHelper.INCLUDETEXTBOTTOM) + "]");
	}

	/**
	 * Build the Com Object
	 * 
	 * @return
	 */
	private ComHelper buildCom()
	{
		setComFields();
		ComTablePK pk = new ComTablePK(INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD);
		ComTable com = new ComTable(pk);
		List<ComTable> comTable = new ArrayList<ComTable>();
		comTable.add(com);

		logger.init(LOG_LEVEL, LOG_NAME, LOG_DIR);

		ComHelper comhelper = new ComHelper(comTable, logger);
		//ComHelper comhelper = new ComHelper(comTable);
		comhelper.editByComfield(ComHelper.STUID, STUNO);
		comhelper.editByComfield(ComHelper.INSTIDQ, INSTIDQ);
		comhelper.editByComfield(ComHelper.INSTID, INSTID);
		comhelper.editByComfield(ComHelper.INSTCD, INSTCD);
		comhelper.editByComfield(ComHelper.DEPTBGN, DEPTBGN);
		comhelper.editByComfield(ComHelper.DEPTLNG, DEPTLNG);
		comhelper.editByComfield(ComHelper.CRSLNG, CRSLNG);
		comhelper.editByComfield(ComHelper.CLIENTS, CLIENTS);

		return comhelper;
	}

	private void setComFields()
	{
		String comQuery = "select COMFIELD, COMVALUE from COM where COMKEY = '" + COMKEY + "'";

		List<Map<String, Object>> comtable = bannerJdbcTemplate.queryForList(comQuery);
		for (Map<String, Object> comfield : comtable)
		{
			String comfieldText = StringUtils.trimToEmpty((String) comfield.get("COMFIELD"));
			String comfieldValue = StringUtils.trimToEmpty((String) comfield.get("COMVALUE"));

			if (StringUtils.equalsIgnoreCase(comfieldText, "INSTIDQ"))
			{
				setINSTIDQ(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "INSTID"))
			{
				setINSTID(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "INSTCD"))
			{
				setINSTCD(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "DEPTBGN"))
			{
				setDEPTBGN(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "DEPTLNG"))
			{
				setDEPTLNG(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "CRSLNG"))
			{
				setCRSLNG(comfieldValue);
			}
			else if (StringUtils.equalsIgnoreCase(comfieldText, "CLIENTS"))
			{
				setCLIENTS(comfieldValue);
			}
		}

	}

	public String getINSTIDQ()
	{
		return INSTIDQ;
	}

	public void setINSTIDQ(String iNSTIDQ)
	{
		INSTIDQ = iNSTIDQ;
	}

	public String getINSTID()
	{
		return INSTID;
	}

	public void setINSTID(String iNSTID)
	{
		INSTID = iNSTID;
	}

	public String getINSTCD()
	{
		return INSTCD;
	}

	public void setINSTCD(String iNSTCD)
	{
		INSTCD = iNSTCD;
	}

	public String getDEPTBGN()
	{
		return DEPTBGN;
	}

	public void setDEPTBGN(String dEPTBGN)
	{
		DEPTBGN = dEPTBGN;
	}

	public String getDEPTLNG()
	{
		return DEPTLNG;
	}

	public void setDEPTLNG(String dEPTLNG)
	{
		DEPTLNG = dEPTLNG;
	}

	public String getCRSLNG()
	{
		return CRSLNG;
	}

	public void setCRSLNG(String cRSLNG)
	{
		CRSLNG = cRSLNG;
	}

	public String getCLIENTS()
	{
		return CLIENTS;
	}

	public void setCLIENTS(String cLIENTS)
	{
		CLIENTS = cLIENTS;
	}

}
