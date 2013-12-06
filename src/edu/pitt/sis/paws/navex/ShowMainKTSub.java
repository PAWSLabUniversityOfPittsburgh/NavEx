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

//import edu.pitt.sis.paws.navex.structures.*;

public class ShowMainKTSub extends HttpServlet
{
	static final long serialVersionUID = -2L;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException
	{
		// Initialize HTML output stream
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		// Get resource map
		HttpSession session = req.getSession();
/*		ResMap resmap = (ResMap)session.getAttribute(
			sgtSessionManager.SS_RES_MAP);/**/
		// Get Current example
		
//		Example current_example = (Example)session.getAttribute(
//			sgtSessionManager.SESS_CURRENT_EXAMPLE);

		//String url_sw = req.getParameter(sgtSessionManager.URL_PAR);
		// Get View Mode
		String view_mode = (String) session.getAttribute(
			sgtSessionManager.SS_VIEW_MODE);
		if (view_mode == null) view_mode = ShowMainKT.SS_MODE_DISS;
//System.err.println("ShowMainKTSub: view mode : "+view_mode);

		// Get title parameter
		String main = req.getContextPath() + 
			"/ShowMainKT?" + sgtSessionManager.PAR_VIEW_MODE + "=";
		HTMLUtils.Header(out, req.getContextPath(), "top frame", false, false);
		String code_url = (view_mode.equals(ShowMainKT.SS_MODE_CODE)) ? "" : 
			"href=\"" + main + ShowMainKT.SS_MODE_CODE + "\"";
		String diss_url = (view_mode.equals(ShowMainKT.SS_MODE_DISS)) ? "" : 
			"href=\"" + main + ShowMainKT.SS_MODE_DISS + "\"";
		String diss_onclick = (view_mode.equals(ShowMainKT.SS_MODE_DISS)) ? "" : 
			" onClick=\"top.frames[1].change(-1);\"";//Report();
		String code_strong_open = (view_mode.equals(ShowMainKT.SS_MODE_CODE)) ?
			"<STRONG>" : "";
		String code_strong_clos = (view_mode.equals(ShowMainKT.SS_MODE_CODE)) ?
			"</STRONG>" : "";
		String diss_strong_open = (view_mode.equals(ShowMainKT.SS_MODE_DISS)) ?
			"<STRONG>" : "";
		String diss_strong_clos = (view_mode.equals(ShowMainKT.SS_MODE_DISS)) ?
			"</STRONG>" : "";
		// Reporting code
/*		out.println("<script language=\"javascript\">");
		out.println("	function Report()");
		out.println("	{");
		out.println("		parent.Report();");
		out.println("	}");
		out.println("</script>");/**/
		out.println("<BODY>");
		
		out.println("<CENTER>");
		out.println(code_strong_open);
		out.println("<a " + code_url +  " target=\"mainFrame\">Code</a>");
		out.println(code_strong_clos);
		out.println(diss_strong_open);
		out.println("<a " + diss_url +  " target=\"mainFrame\""+diss_onclick+"\">Dissection</a>");
		out.println(diss_strong_clos);
		out.println("</CENTER>");
			
		HTMLUtils.Footer(out, true);
//System.err.println("ShowMainKTSUB checking trail par "+sgtSessionManager.TRAIL_PAR+"="+(String)session.getAttribute(sgtSessionManager.TRAIL_PAR) + " session" + session.getId());				
		out.close();
	}
}
