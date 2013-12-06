/* Disclaimer:
 * 	Java code contained in this file is created as part of educational
 *    research and development. It is intended to be used by researchers of
 *    University of Pittsburgh, School of Information Sciences ONLY.
 *    You assume full responsibility and risk of lossed resulting from compiling
 *    and running this code.
 */

/**
 * @author Michael V. Yudelson (C) 2003-2005
 */

/**
 * SESSION MANAGER
 */
package edu.pitt.sis.paws.navex;

import java.io.*;
import java.sql.*;
import java.net.*;
import java.util.ArrayList;
import javax.servlet.*;

//import edu.pitt.sis.paws.um.structures.*;
import edu.pitt.sis.paws.navex.structures.*;
import edu.pitt.sis.paws.cbum.report.*;

//import org.w3c.dom.*;
//import com.lena.utils.*;

public class sgtSessionManager
{
	protected static sgtSessionManager instance = new sgtSessionManager();
	protected static boolean initialized = false;

	// Context parameter names (without suffixation)
	private static final String CTXT_DB_DRIVER = "driver";
	private static final String CTXT_DB_URL = "url";
	private static final String CTXT_DB_USER = "user";
	private static final String CTXT_DB_PASS = "password";
	private static final String CTXT_UMM_SERVLET = "ummanager";
	private static final String CTXT_UM_SERVLET = "um";

	// Context values
	public static String ctxt_db_driver = null;
	public static String ctxt_db_url = null;
	public static String ctxt_db_user = null;
	public static String ctxt_db_pass = null;
	public static String ctxt_umm_servlet = null;
	public static String ctxt_um_servlet = null;

	// Request parameters
	public static final String REQ_USER = "usr";
	public static final String REQ_SCOPE = "scope";
	public static final String REQ_EXAMPLE_ID = "id";
	public static final String REQ_INTERFACE = "intf";
	public static final String REQ_UMS = "ums";
	public static final String REQ_NOREPORT = "noreport";
	public static final String REQ_GROUP_ID = "grp";

	// Session parameters
	public static final String SESS_USER = "usr";
	public static final String SESS_SCOPE = "scope";
	public static final String SESS_RESMAP = "resmap";
	public static final String SESS_CURRENT_EXAMPLE = "current_example";
	public static final String SESS_INTERFACE = "intf";
	public static final String SESS_OTHER_PARAMS = "other_params";
	public static final String SESS_MAIN_URL = "main_url";
	public static final String SESS_GROUP_ID = "grp";

	// Values
	public static final String INTERFACE_PROGRESS = "P";
	public static final String INTERFACE_SOCIAL = "S";
	public static final String INTERFACE_AVAIL = "A";

	// Session variables
//	public final static String SS_USER_LOGIN = "user_login";
//	public final static String SS_RES_MAP = "res_map";
//	public final static String SS_CURRENT_MODULE = "current_module";
	public final static String SS_VIEW_MODE = "view_mode"; //c++/diss
	//UMManager Parameters and their possible values
	private final static String PAR_ACTION = "act";
//	private final static String VAL_USER_PFILE = "up";
	private final static String VAL_ACT_PROGRESS = "apro";
	private final static String PAR_ID = "id";
//	private final static String PAR_OUTPUT = "out";
//	private final static String VAL_DATA = "dat";
//	private final static String VAL_XML = "xml";
	private final static String PAR_USER = "u";
//	private final static String PAR_GID = "gid";
	// Servlet parameters [and their values]
		//MAIN
	public static String USER_PAR = null; // THIS ONE IS CONTEXT DEFINED
//	public static String USER = null;
//	public static final String SCOPE_PAR = "scope";
//	public static int COURSEID = 0;
//	public static final String MODULEID_PAR = "id";
//	public static final String INTERFACE_PAR = "intf";


	public static final String TRAIL_PAR = "svc";
	public static final String TRAIL_VAL = "A";
//	public static final String STATE_PAR = "stt";
	public static final String NAVAIL_VAL = "N";
	public static final String[] AVAIL_VAL = {"0","1","2","3","4"};

		//Left
	public static final String PAR_PROGRESS = "progress";
	public static final String VAL_PROGRESS_YES = "yes";
		// Top
	//public static final String MODULEID_PAR = "id"; same as in MAIN
	public static final String PAR_TITLE = "ti"; // title of the module
	public static final String PAR_MENU = "mn"; // menu status
	public static final String VAL_MENU_MIN = "min"; // menu status

		// Inner
	public static final String PAR_VIEW_MODE = "view"; // defined in handlers
	// Resource Paths
	public static final String SYSTEM_PATH = "/system"; // common resouces etc
	// Module knowledge progress
	public final static String[] icon_progress = {"progr000.gif","progr025.gif",
		"progr050.gif","progr075.gif","progr100.gif"};
	public final static String icon_locked = "progr_lock.gif";
	public final static String[] social_progress = {"SocioBG1",
		"SocioBG2","SocioBG3","SocioBG4"};
	public final static String[] social_icon = {"SocioIC1x5", "SocioIC2x5",
		"SocioIC3x5","SocioIC4x5","SocioIC5x5"};
	public final static int progress_count = 4;
	public final static String icon_navail = "navail2.gif";
	public final static String icon_done = "done.gif";

	private static void initIt(ServletContext context)
	{
		//Setup context parameters
		ctxt_db_driver = context.getInitParameter(CTXT_DB_DRIVER);
		ctxt_db_url = context.getInitParameter(CTXT_DB_URL);
		ctxt_db_user = context.getInitParameter(CTXT_DB_USER);
		ctxt_db_pass = context.getInitParameter(CTXT_DB_PASS);
		ctxt_umm_servlet = context.getInitParameter(CTXT_UMM_SERVLET);
		ctxt_um_servlet = context.getInitParameter(CTXT_UM_SERVLET);

		if ( (ctxt_db_driver == null) || (ctxt_db_url == null) ||
			(ctxt_db_user == null) || (ctxt_db_pass == null) ||
			(ctxt_umm_servlet == null) || (ctxt_um_servlet == null) )
		{
if (ctxt_db_driver == null) System.err.println("SessionManager: 1"); /// DEBUG
if (ctxt_db_url == null) System.err.println("SessionManager: 2"); /// DEBUG
if (ctxt_db_user == null) System.err.println("SessionManager: 3"); /// DEBUG
if (ctxt_db_pass == null) System.err.println("SessionManager: 4"); /// DEBUG
if (ctxt_umm_servlet == null) System.err.println("SessionManager: 5"); /// DEBUG
if (ctxt_um_servlet == null)	System.err.println("SessionManager: 6"); /// DEBUG
			System.err.println("SessionManager: Initialization error!");
			return;
		}
//System.err.println("SM: Session Manager Created");
//System.err.println("SM: session id: "+req.getSession().getId());
	} // end of -- initIt


	public static sgtSessionManager getInstance(ServletContext context)
	{
		if (!initialized)
		{
			initialized = true;
			initIt(context);
		}
		return instance;
	}

	private sgtSessionManager() { /* Empty provate constructor*/ }

//	public boolean Logon(HttpServletRequest req, ServletContext context,
//		HttpSession session)
	public static String getProgressIcon(float progress)
	{
		float p = progress;
if((progress>1)||(progress<0))
{
	System.err.println("Error! Progress is " + progress);
	if(progress>1)
		p = 1;
	else if(progress<0)
		p = 0;
}
		return icon_progress[(int)Math.floor(p*progress_count)];
	}
	public static String getState(float progress)
	{
		return AVAIL_VAL[(int)Math.floor(progress*progress_count)];
	}
	public static boolean isEmptyStr(String str)
	{
		return ((str == null) || (str.trim().equals("")));
	}
	public static ArrayList getUserActivityProfile(String user, String group,
		ResMap resmap)// throws IOException
	{
	
	
		ArrayList reqArray = new ArrayList();
		ArrayList resArray = null;
		for(int i=0; i<resmap.getExamples().size(); i++)
		{
			reqArray.add(new ProgressEstimatorReport(
				resmap.getExamples().get(i).getExampleId()));
		}
		try
		{

				URL url = new URL(ctxt_umm_servlet + "?typ=act&dir=in&frm=dat&app=3&usr=" + user+"&grp="+group);
//				URL url = new URL("http://localhost:8080/cbum/ReportManager?type=act&dir=in&format=dat&app=3&usr=myudelson");
				URLConnection con = url.openConnection();
				con.setUseCaches(false);
				con.setDefaultUseCaches(false);
				con.setDoOutput(true);
				con.setDoInput(true);
				con.setRequestProperty("Content-Type","java-internal/" + reqArray.getClass().getName());
//System.err.println("[navex]: connection good");
				ObjectOutputStream oo = new ObjectOutputStream(con.getOutputStream());
//System.err.println("[navex]: ObjectOutputStream");
				oo.writeObject(reqArray);
//System.err.println("[navex]: sent! to " + url);
				oo.flush();
				oo.close();
//System.err.println("[navex]: -----");
				
		
				ObjectInputStream ii = new ObjectInputStream(con.getInputStream());
				try{ resArray = (ArrayList)ii.readObject(); }
				catch(Exception e) { e.printStackTrace(System.err); }
				finally{ii.close();} 

//for(int i=0; i<resArray.size(); i++)
//	System.out.println("{!!navEx} " + resArray.get(i));
				
				
//System.out.println("[navex] top received response");
//for(int i=0; i<resArray.size() ;i++)
//{
//	System.out.println("\t" + resArray.get(i));
//}
				
				
		//System.err.println("[navex]: before stream");
		//		ObjectInputStream result = new ObjectInputStream(in);
		//		ArrayList uprlist = null;
		//System.err.println("[navex]: before in");
		//		try{ uprlist = (ArrayList)result.readObject(); }
		//		catch(Exception e) { e.printStackTrace(System.err); }
		//System.err.println("[navex]: done");
		//System.err.println("[navex]:===================================");
		
		}
		catch(Exception e) { e.printStackTrace(System.out); }
	
		return resArray;
	}


    public static ArrayList getUserConceptProfile(String user, String group,
	    ResMap resmap)// throws IOException
    {
    
    
	    ArrayList reqArray = new ArrayList();
	    ArrayList resArray = null;
	    for(int i=0; i<resmap.getConcepts().size(); i++)
	    {
	    	if(resmap.getConcepts().get(i).getTitle().indexOf(".c") != -1 )
	    		continue;
		    reqArray.add(new ProgressEstimatorReport(resmap.getConcepts().get(i).getTitle()));
	    }
	    try
	    {

			    URL url = new URL(ctxt_umm_servlet + "?typ=con&dir=in&frm=dat&lev=Application&app=3&dom=c_programming&usr=" + user + "&grp=" + group);
//                                  URL url = new URL("http://localhost:8080/cbum/ReportManager?type=act&dir=in&format=dat&app=3&usr=myudelson");
			    URLConnection con = url.openConnection();
			    con.setUseCaches(false);
			    con.setDefaultUseCaches(false);
			    con.setDoOutput(true);
			    con.setDoInput(true);
			    con.setRequestProperty("Content-Type","java-internal/" + reqArray.getClass().getName());
//System.err.println("[navex]:  connection good");
			    ObjectOutputStream oo = new ObjectOutputStream(con.getOutputStream());
//System.err.println("[navex]: ObjectOutputStream");
			    oo.writeObject(reqArray);
//System.err.println("[navex]: sent!  to " + url);
			    oo.flush();
			    oo.close();
//System.err.println("[navex]: -----");
			    
	    
			    ObjectInputStream ii = new ObjectInputStream(con.getInputStream());
			    try{ resArray = (ArrayList)ii.readObject(); }
			    catch(Exception e) { e.printStackTrace(System.err); }
			    finally{ii.close();} 
	    
			    
//System.out.println("[navex] top received response ");
//for(int i=0; i<resArray.size() ;i++)
//{
//      System.out.println("\t" + resArray.get(i));
//}

			    
//	    System.err.println("[navex]: before stream");
//	                  ObjectInputStream result = new ObjectInputStream(in);
//	                  ArrayList uprlist = null;
//	    System.err.println("[navex]: before in");
//	                  try{ uprlist = (ArrayList)result.readObject(); }
//	                  catch(Exception e) { e.printStackTrace(System.err); }
//	    System.err.println("[navex]: done");
//	    System.err.println("[navex]:===================================");
	    
	    }
	    catch(Exception e) { e.printStackTrace(System.out); }
    
	    return resArray;
    }

//	public static ArrayList getUserProfile(ResMap resmap, String u_log,
//		String group_id) throws IOException
//	{
//		ArrayList request = new ArrayList();
//		for(int i=0; i<resmap.getExamples().size(); i++)
//			request.add(new ProgressEstimatorReport(
//				resmap.getExamples().get(i).getExampleId(), 0, 0));
//
//		URL url = new URL("http://localhost:8080/cbum/ReportManager?type=act&dir=in&format=dat&app=3&usr=myudelson");
//		URLConnection con = url.openConnection();
//	    	con.setUseCaches(false);
//		con.setDefaultUseCaches(false);
//		con.setDoOutput(true);
//		con.setDoInput(true);
//		con.setRequestProperty("Content-Type","java-internal/" + request.getClass().getName());
//
//		ObjectOutputStream oo = new ObjectOutputStream(con.getOutputStream());
//		oo.writeObject(request);
//		oo.flush();
//		oo.close();
//
//		ObjectInputStream ii = new ObjectInputStream(con.getInputStream());
//		ArrayList response = null;
//		try{ response = (ArrayList)ii.readObject(); }
//		catch(Exception e) { e.printStackTrace(System.err); }
//		finally{ii.close();} 
//		
//		return response;
////		URL servlet_url = new URL(ctxt_umm_servlet + "?" + PAR_ACTION + "=" +
////			VAL_USER_PFILE + "&" + PAR_ID + "=" + u_log +
////			"&" + PAR_GID + "=" + group_id);
////		URL url = new URL(servlet_url.toExternalForm());
////		URLConnection con = url.openConnection();
////		InputStream in = con.getInputStream();
////		ObjectInputStream result = new ObjectInputStream(in);
////		UserProfileRecordList uprlist = null;
////		try{ uprlist = (UserProfileRecordList)result.readObject(); }
////		catch(Exception e) { e.printStackTrace(System.err); }
////System.err.println("SM: user profile " + (up!=null));
////System.err.println("SM: user profile user " + (up.user!=null));
////System.err.println("SM: user profile acts " + (up.activities!=null));
////		return uprlist;
//	}

	public static float getActivityProgress(String user_login, String act)
		throws IOException
	{
		URL servlet_url = new URL(ctxt_umm_servlet + "?" + PAR_ACTION + "=" +
			VAL_ACT_PROGRESS + "&" + PAR_ID + "=" + act + "&" + PAR_USER +
			"=" + user_login);
		URL url = new URL(servlet_url.toExternalForm());
		URLConnection con = url.openConnection();
		InputStream in = con.getInputStream();
		ObjectInputStream result = new ObjectInputStream(in);
		Float progress = null;
		try{ progress = (Float)result.readObject(); }
		catch(Exception e) { e.printStackTrace(System.err); }
		return progress.floatValue();
	}

	public static Connection getConntection() 
		throws Exception
	{
		Class.forName(sgtSessionManager.ctxt_db_driver).newInstance();
		return DriverManager.getConnection(sgtSessionManager.ctxt_db_url,
			sgtSessionManager.ctxt_db_user, 
			sgtSessionManager.ctxt_db_pass);
	}

	public static ResultSet executeStatement(Connection conn, String query)
		throws Exception
	{
		PreparedStatement statement = conn.prepareStatement(query);
		return statement.executeQuery();
	}

	public static void freeConnection(Connection conn)
	{
		try { if (conn != null) conn.close(); }
		catch (Exception e) { e.printStackTrace(System.err); }
	}

/*	public String getModuleHandlerByID(int module_id)
	{
		/**
		 *  ##### #####     ###   #####
		 *    #   #   #     #  #  #   #
		 *    #   #   #     #   # #   #
		 *    #   #   #     #  #  #   #
		 *    #   #####     ###   #####
		 */
/*		 return null;
	}*/
/*	public void displayCourseMap(PrintWriter out, boolean modl,
		boolean conc)//
	{
		resmap.displayCourseMap(out, modl, conc);
	}/**/
/*	public void setCurrentModuleByID(int m_id)//
	{
		current_module = resmap.modules.findByID(m_id);
	}/**/
/*	public void updateModuleStates()//
	{
		resmap.updateModuleStates();
	}/**/

}