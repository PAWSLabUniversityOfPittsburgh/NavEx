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

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.util.regex.*;
import java.net.*;

import edu.pitt.sis.paws.core.utils.SQLManager;
import edu.pitt.sis.paws.navex.structures.*;
//import edu.pitt.sis.paws.um.structures.*;

public class Show extends HttpServlet
{
	static final long serialVersionUID = -2L;
	private SQLManager sqlManager;
	public static final String db_context = "java:comp/env/jdbc/main";;

	public void init() throws ServletException
	{
		super.init();		
		sqlManager = new SQLManager(db_context);
	}
	public void destroy()
	{
		sqlManager = null;
		super.destroy();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException
	{
		// get session manager
		sgtSessionManager sm =
			sgtSessionManager.getInstance(getServletContext());

		// get request/session parameters
		HttpSession session = req.getSession(true);

		//	Handle User Login
		String sess_user = (String)session.getAttribute(sgtSessionManager.SESS_USER);
		String req_user = req.getParameter(sgtSessionManager.REQ_USER);

		String user_login = (req_user != null)?req_user:sess_user;
		if(user_login == null)
		{
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
			HTMLUtils.Message(out,"User was not specified");
			return;
		}
//System.out.println("[navex] Show.doGet req_user=" + req_user + " sess_user=" +sess_user  + " (req_user != null):" + (req_user != null) + " (!req_user.equals(sess_user)):"+!req_user.equals(sess_user)); /// DEBUG
		if(req_user != null && !req_user.equals(sess_user))
		{
			session.setAttribute(sgtSessionManager.SESS_USER, req_user);
//System.out.println("[navex] Show.doGet user_login has been uploaded into session"); /// DEBUG
		}
		
		
		// Handle Group ID
		String sess_gid = (String)session.getAttribute(sgtSessionManager.SESS_GROUP_ID);
		String req_gid = req.getParameter(sgtSessionManager.REQ_GROUP_ID);

		String user_group = (req_gid != null)?req_gid:sess_gid;
		if(user_group == null)
		{
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
			HTMLUtils.Message(out,"Group was not specified");
			return;
		}
		if(req_gid != null && !req_gid.equals(sess_gid))
		{
			session.setAttribute(sgtSessionManager.SESS_GROUP_ID, req_gid);
		}
		
		
		//	Handle Scope Id
		String sess_scope = (String)session.getAttribute(sgtSessionManager.SESS_SCOPE);
		String req_scope = req.getParameter(sgtSessionManager.REQ_SCOPE);
		String scope_id_s = (req_scope != null)?req_scope:sess_scope;
		if(scope_id_s == null)
		{
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
			HTMLUtils.Message(out,"Scope was not specified");
			return;
		}
		//	check whether scope_id_s is a number
		Pattern p = Pattern.compile("[0-9]+");
		Matcher m = p.matcher("");
		m.reset(scope_id_s);
		if(!m.matches())
		{
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
			HTMLUtils.Message(out,"Scope was specified incorrectly " +
				"(Id not a number)");
			return;
		}
		int scope_id = Integer.parseInt(scope_id_s);
		if(req_scope != null && !req_scope.equals(sess_scope))
			session.setAttribute(sgtSessionManager.SESS_SCOPE, sess_scope);

		// Handle Res Map
		ResMap resmap = (ResMap)session.getAttribute(
			sgtSessionManager.SESS_RESMAP);

		// TODO remove this or deal nicely
		String gid = req.getParameter("grp");
		session.setAttribute("grp", gid);
		
		if( resmap == null || (sess_user != null && !sess_user.equals(req_user)) ||
			(sess_scope != null && !sess_scope.equals(req_scope)) )
		{// Create resource map anew
//System.out.println("[navex] Show.doGet Loading ResMap"); /// DEBUG
			resmap = new ResMap(user_login, scope_id);
			resmap.Load();
			session.setAttribute(sgtSessionManager.SESS_RESMAP,resmap);

			// TODO change profile request
//			ArrayList resArray = null;
//			resArray = sm.getUserActivityProfile(user_login, resmap);

//			UserProfileRecordList uprlist = null;
//			try{ uprlist = sm.getUserActivityProfile(user_login,gid); }
//			catch(Exception e) { e.printStackTrace(System.err); }
//			resmap.uploadUserActivityProfile(uprlist);
		}// -- Create resource map anew

		//	Handle the Example Id
		String example_id_s = req.getParameter(sgtSessionManager.
			REQ_EXAMPLE_ID);
		Example current_example_sess = (Example) session.getAttribute(
			sgtSessionManager.SESS_CURRENT_EXAMPLE);
		int example_id = -1;
		if(example_id_s != null)
		{
			//	check whether example_id_s is a number
			p = Pattern.compile("-?[0-9]+");
			m = p.matcher("");
			m.reset(example_id_s);
			if(!m.matches())
			{
				res.setContentType("text/html");
				PrintWriter out = res.getWriter();
				HTMLUtils.Message(out,"Example was specified incorrectly " +
					"(Id not a number)");
				return;
			}
			example_id = Integer.parseInt(example_id_s);
		}
		Example current_example_req = resmap.getExamples().findById(example_id);
		Example current_example = (current_example_req != null ) ?
			current_example_req : current_example_sess;
		if((current_example_req != null && current_example_sess != null &&
			current_example_req.getId() != current_example_sess.getId()) ||
			(current_example_req != null && current_example_sess == null))
		{
			session.setAttribute(sgtSessionManager.SESS_CURRENT_EXAMPLE,
				current_example_req);
//System.out.println("[navex] Show.doGet Setting new current example"); /// DEBUG
		}
		else if(example_id == -1)
			session.removeAttribute(sgtSessionManager.SESS_CURRENT_EXAMPLE);

		// handle interface parameter
		String interface_req = req.getParameter(sgtSessionManager.REQ_INTERFACE);
		String interface_sess = (String)session.getAttribute(sgtSessionManager.SESS_INTERFACE);
		String interface_ = (interface_req != null) ? interface_req :
			interface_sess;
		if(interface_ == null) interface_ = sgtSessionManager.INTERFACE_PROGRESS;
		if(!interface_.equals(interface_sess))
			session.setAttribute(sgtSessionManager.SESS_INTERFACE, interface_);

		// Handle all other parameters
		Enumeration enum_allparam = req.getParameterNames();
		String other_parameters = "";
		for(;enum_allparam.hasMoreElements();)
		{
			String parameter = (String)enum_allparam.nextElement();
			String value = req.getParameter(parameter);
			if(//!parameter.equals(sgtSessionManager.REQ_USER) &&
				//!parameter.equals(sgtSessionManager.REQ_SCOPE) &&
				!parameter.equals(sgtSessionManager.REQ_EXAMPLE_ID))
			{
				other_parameters += "&" + parameter + "=" + value;
//System.out.println("[navex] Show.doGet Enumerating 'other' params: " + parameter + "=" + value);	/// DEBUG
			}
		}
		session.setAttribute(sgtSessionManager.SESS_OTHER_PARAMS, other_parameters);

		// Handle UMS parameter
		String ums = sm.ctxt_um_servlet;
		String ums_req = req.getParameter(sgtSessionManager.REQ_UMS);
		ums = (ums_req != null) ? ums_req : ums;

		// Handle No-Report parameter
		String noreport = req.getParameter(sgtSessionManager.REQ_NOREPORT);

		// Report click and service-trail to the um database
		if(noreport == null)
		{
			URL url = new URL(ums + "?app=9&act=" +
				((example_id != -1)?current_example.getId():0) +
				"&sub=0&res=-1" + other_parameters);
//System.out.println("[navex] Show.doGet reporting to url:" + url); ///DEBUG
			URLConnection dbpc = (url).openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(
				dbpc.getInputStream()));
			in.close();
		}

		// Upload the view parameter
//		String main = req.getContextPath() +
//			((example_id != -1) ? ("/ShowMainKT") : "/help.html");// +
		String main = ((example_id != -1) ? (current_example.getBaseURL() + other_parameters) :(req.getContextPath() + "/help.html"));// +
//System.out.println("[navex] Show.doGet mainURL="+main); /// DEBUG
		session.setAttribute(sgtSessionManager.SESS_MAIN_URL, main);
		RequestDispatcher disp;
		disp = getServletContext().getRequestDispatcher("/jspShow");
		disp.forward(req, res);
	}
}
