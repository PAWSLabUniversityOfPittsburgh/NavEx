<%@ page 
	contentType="text/html;charset=utf-8"
	language="java"
	import="java.util.*, edu.pitt.sis.paws.navex.structures.*, 
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
//Calendar start = null;
//Calendar finish = null;
//long diff_mills;
%>
<%
//start = new GregorianCalendar();
	resmap = (ResMap)session.getAttribute(
		sgtSessionManager.SESS_RESMAP);
	user_login = (String) session.getAttribute(sgtSessionManager.SESS_USER);
	user_group = (String) session.getAttribute(sgtSessionManager.SESS_GROUP_ID);
//System.out.println("[navex] left.jsp user_login=" + user_login + " gid=" + gid); /// DEBUG

//	UserProfileRecordList uprlist = null;
//	if(user_login != null && user_group != null)
//	{
//		try{ uprlist = sgtSessionManager.getUserActivityProfile(user_login, user_group); }
//		catch(Exception e) { e.printStackTrace(System.err); }
//		resmap.uploadUserActivityProfile(uprlist);
//	}
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
//		resmap.uploadUserActivityProfile(profile);
//		for(int i=0; i<profile.size() ;i++)
//		{
//			System.out.println("\t" + profile.get(i));
//		}
//	}
	
	current_example = (Example)session.getAttribute(
		sgtSessionManager.SESS_CURRENT_EXAMPLE);
	if(current_example != null)
		fragment = "'#" + current_example.getId() +"'";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title></title>
<link rel='stylesheet' href="<%=request.getContextPath() +
	sgtSessionManager.SYSTEM_PATH%>/A2TeAL.css" type="text/css"/>

</head>
<body>
<%
	resmap.displayCourseMap(out,((current_example != null) ? current_example.getId() : -1),session, request.getContextPath()); 
//finish = new GregorianCalendar();
//diff_mills = finish.getTimeInMillis() - start.getTimeInMillis();
//System.out.println("\t [navex] left.jsp millisec passed " + diff_mills);

%>
</body>
</html>