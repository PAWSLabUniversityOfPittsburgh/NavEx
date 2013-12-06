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

package edu.pitt.sis.paws.navex;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import edu.pitt.sis.paws.navex.structures.*;

public class ShowMainKT extends HttpServlet
{
	static final long serialVersionUID = -2L;

	// Constants
	public final static String SS_MODE_CODE = "code"; 
	public final static String SS_MODE_DISS = "diss"; 
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException
	{
//System.err.println("ShowMainKT: starting");
		// Initialize HTML output stream
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
	
		// Get resource map
		HttpSession session = req.getSession();
		ResMap resmap = (ResMap)session.getAttribute(
			sgtSessionManager.SESS_RESMAP);
//System.err.println("ShowMainKT: resource map ok");

		// Get Current example
		Example current_example = (Example)session.getAttribute(
			sgtSessionManager.SESS_CURRENT_EXAMPLE);
//System.err.println("ShowMainKT: current example ok");
		
		// Get View Mode
		String view_mode = (String) session.getAttribute(
			sgtSessionManager.SS_VIEW_MODE);
//System.err.println("ShowMainKT: view example session: "+view_mode);
		if (view_mode == null)
		{
			view_mode = SS_MODE_DISS;
//System.err.println("ShowMainKT: view mode from session/default: "+view_mode);
		}
		// override if request parameter
		String view_mode_p = req.getParameter(sgtSessionManager.PAR_VIEW_MODE);
//System.err.println("ShowMainKT: view mode param: "+view_mode_p);
		if(view_mode_p != null)
		{
			view_mode = view_mode_p;
//System.err.println("ShowMainKT: view mode from param: "+view_mode);
		}
		// upload to session
		session.setAttribute(sgtSessionManager.SS_VIEW_MODE, view_mode);
//System.err.println("ShowMainKT: resmap null "+(resmap==null));

		// Get title parameter
		String url_c = current_example.getBaseURL()+ Example.EXAMPLE_TXT;
		String url_d = current_example.getBaseURL()+ Example.EXAMPLE_SIM;
//		String url_sw = req.getParameter(sgtSessionManager.URL_PAR);
		// vvv 'decider' for url, very tangled :)
//System.err.println("ShowMainKT: resmap not null "+(resmap!=null));
//System.err.println("ShowMainKT: url_c not null "+(url_c!=null));
//System.err.println("ShowMainKT: url_d not null "+(url_d!=null));
//System.err.println("ShowMainKT: url_sw not null "+(url_sw!=null));

		// TRAFFIKING PARAMETERS
		// +++ hardcoded sid
		String sid = (String)session.getAttribute("sid");
		// +++ hardcoded gid
		String gid = (String)session.getAttribute("gid");
		
		String svc = (String)session.getAttribute(sgtSessionManager.TRAIL_PAR);
//System.err.println("ShowMainKT checking trail par "+sgtSessionManager.TRAIL_PAR+"="+(String)session.getAttribute(sgtSessionManager.TRAIL_PAR) + " session" + session.getId());				
//System.err.println("ShowMainKT checking trail par in req "+sgtSessionManager.TRAIL_PAR+"="+svc);				
		String main = 
			(
				(view_mode.equals(SS_MODE_CODE))
					?url_c
					:(view_mode.equals(SS_MODE_DISS))
						?url_d + "&" + sgtSessionManager.USER_PAR + 
							"=" + resmap.getUserLogin() + "&sid="+sid +
						// add trail
						((svc!=null)?("&svc="+svc):"") +
						//add gid
						"&gid="+gid
						:""
			)
			// add trail
			;
/*		String main_report = "&report=window.open(\"" + 
			sgtSessionManager.APP_SELF + sgtSessionManager.APP_ROOT +
			sgtSessionManager.SERVLET_PATH + 
			"/ShowLeft?progress=yes\",\"leftFrame\");";
		main = (!main.equals("") && view_mode.equals(SS_MODE_DISS))
			? main + main_report : main;/**/
//if(url_sw.equals(sgtSessionManager.URL_DISS))System.err.println("ShowMainKT: main "+main);		
//		resmap.active = (url_sw.equals(sgtSessionManager.URL_C))?false:
//			(url_sw.equals(sgtSessionManager.URL_DISS))?true:false;
		String top = req.getContextPath() + "/ShowMainKTSub";// +
//			"?" + sgtSessionManager.URL_PAR + "=" + url_sw;

		HTMLUtils.Header(out, req.getContextPath(), "top frame", false, true);

		String left = req.getContextPath() + "/ShowLeft";

		// Reporting code
		out.println("<script language=\"javascript\">");
		out.println("	function Report()");
		out.println("	{");
//		out.println("		alert('Main KT reporting');");
//		out.println("		setTimeout(\";\",500);");
//		out.println("		alert(window.name);");
		out.println("		window.open(\"" + left + "?progress=yes\",\"leftFrame\");");
//		out.println("		w.close();");
		out.println("	}");
		out.println("</script>");
		
		HTMLUtils.MainFrameset(out, top, main);
		HTMLUtils.Footer(out, false);
		out.close();
		
		// Request progress update and update progress
	}
}
