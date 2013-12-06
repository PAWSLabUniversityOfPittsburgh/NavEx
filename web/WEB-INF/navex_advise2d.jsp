<%@ page 
	contentType="text/html;charset=utf-8"
	language="java"
	import="java.util.*, edu.pitt.sis.paws.navex.structures.*, 
		java.util.regex.*,
		edu.pitt.sis.paws.navex.*;"
	errorPage=""
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%!
	public Example current_example = null;
	public String user_login = null;
	public String user_group = null;
	public ResMap resmap = null;
	public String fragment = "";
	public String advise2d_codebase = "";
	public String other_parameters = "";
%>
<%
//		sgtSessionManager sm = sgtSessionManager.getInstance(application);

		String sess_user = (String)session.getAttribute(sgtSessionManager.SESS_USER);
		String req_user = request.getParameter(sgtSessionManager.REQ_USER);

		String user_login = (req_user != null)?req_user:sess_user;
		if(user_login == null)
		{
			response.setContentType("text/html");
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
		String req_gid = request.getParameter(sgtSessionManager.REQ_GROUP_ID);

		String user_group = (req_gid != null)?req_gid:sess_gid;
		if(user_group == null)
		{
			response.setContentType("text/html");
			HTMLUtils.Message(out,"Group was not specified");
			return;
		}
		if(req_gid != null && !req_gid.equals(sess_gid))
		{
			session.setAttribute(sgtSessionManager.SESS_GROUP_ID, req_gid);
		}
		
		
		//	Handle Scope Id
		String sess_scope = (String)session.getAttribute(sgtSessionManager.SESS_SCOPE);
		String req_scope = request.getParameter(sgtSessionManager.REQ_SCOPE);
		String scope_id_s = (req_scope != null)?req_scope:sess_scope;
		if(scope_id_s == null)
		{
			response.setContentType("text/html");
			HTMLUtils.Message(out,"Scope was not specified");
			return;
		}
		//	check whether scope_id_s is a number
		Pattern p = Pattern.compile("[0-9]+");
		Matcher m = p.matcher("");
		m.reset(scope_id_s);
		if(!m.matches())
		{
			response.setContentType("text/html");
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

		String gid = request.getParameter("grp");
		session.setAttribute("grp", gid);
		
		if( resmap == null || (sess_user != null && !sess_user.equals(req_user)) ||
			(sess_scope != null && !sess_scope.equals(req_scope)) )
		{// Create resource map anew
//System.out.println("[navex] Show.doGet Loading ResMap"); /// DEBUG
			resmap = new ResMap(user_login, scope_id);
			resmap.Load();
			session.setAttribute(sgtSessionManager.SESS_RESMAP,resmap);

//			ArrayList resArray = null;
//			resArray = sm.getUserActivityProfile(user_login, resmap);

//			UserProfileRecordList uprlist = null;
//			try{ uprlist = sm.getUserActivityProfile(user_login,gid); }
//			catch(Exception e) { e.printStackTrace(System.err); }
//			resmap.uploadUserActivityProfile(uprlist);
		}// -- Create resource map anew


	ArrayList profile = null;
	profile = sgtSessionManager.getUserActivityProfile(user_login, user_group, resmap);
	
	ArrayList profile2 = sgtSessionManager.getUserConceptProfile(user_login, user_group, resmap);
	resmap.uploadUserActivityProfile(profile, false);
	resmap.uploadUserConceptProfile(profile2, true);
//	for(int i=0; i<profile2.size(); i++)
//	{
//	    ProgressEstimatorReport per = (ProgressEstimatorReport)profile2.get(i);
//	    System.out.println("	concept=" + per.id + " count=" + per.count + " progress=" + per.progress);
//	}

	
//	if(user_login != null && user_group != null)
//	{
//		profile = sgtSessionManager.getUserActivityProfile(resmap, user_login, 
//			user_group);
//		resmap.uploadProfile(profile);
//		for(int i=0; i<profile.size() ;i++)
//		{
//			System.out.println("\t" + profile.get(i));
//		}
//	}
	
	current_example = (Example)session.getAttribute(
		sgtSessionManager.SESS_CURRENT_EXAMPLE);
	if(current_example != null)
		fragment = "'#" + current_example.getId() +"'";
		
	advise2d_codebase = application.getInitParameter("advise2d_codebase");
	Enumeration enum_allparam = request.getParameterNames();
	for(;enum_allparam.hasMoreElements();)
	{
		String parameter = (String)enum_allparam.nextElement();
		String value = request.getParameter(parameter);
		if(//!parameter.equals(sgtSessionManager.REQ_USER) &&
			//!parameter.equals(sgtSessionManager.REQ_SCOPE) &&
			!parameter.equals(sgtSessionManager.REQ_EXAMPLE_ID))
		{
			other_parameters += "&" + parameter + "=" + value;
//System.out.println("[navex] Show.doGet Enumerating 'other' params: " + parameter + "=" + value);	/// DEBUG
		}
	}
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title></title>
<link rel='stylesheet' href="<%=request.getContextPath() +
	sgtSessionManager.SYSTEM_PATH%>/A2TeAL.css" type="text/css"/>

</head>
<body>
<APPLET codebase="<%=advise2d_codebase%>" code="amds.class" width=720 height=560>
   <param name="vectors" value="<%=resmap.Examples2Advise()%>">
   <param name="terms"  value="<%=resmap.Concepts2Advise()%>">
   <param name="urls"  value="<%=resmap.URLs4Advise(other_parameters)%>">
   <param name=zoom value="16">
</APPLET>
</body>
</html>