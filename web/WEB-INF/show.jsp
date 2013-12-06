<%@ page
	contentType="text/html; charset=utf-8"
	language="java"
	import="edu.pitt.sis.paws.navex.structures.*,
		edu.pitt.sis.paws.navex.*"
	errorPage=""
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
	"http://www.w3.org/TR/html4/frameset.dtd">
<%!
	public String main = "";
	public Example current_example = null;
	public String fragment = "";
%>
<%
	current_example = (Example)session.getAttribute(
		sgtSessionManager.SESS_CURRENT_EXAMPLE);
	main = (String)session.getAttribute(sgtSessionManager.SESS_MAIN_URL);
	if(current_example != null)
		fragment = "#" + current_example.getId() +"";
//System.out.println("[navex] current_example="+current_example);
//System.out.println("[navex] main="+main);
%>


<html>
<head>
<title>NavEx::<%=((current_example!=null)?current_example.getTitle():"Help!")%></title>
<link rel='stylesheet' href="<%=request.getContextPath() +
	sgtSessionManager.SYSTEM_PATH%>/A2TeAL.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; no-cache; charset=utf-8">
<script language=\"javascript\" type="text/javascript">
	function ReloadMe()
	{
//		var do_reload = ((noreload==null) ? "true" : "false");
//		if(do_reload)
			window.location.reload();
//			window.location.replace(window.location.href);
//			alert('window.location');
	}
</script>

</head>

<frameset id=frameset cols="250,*">
	<frame src="<%=request.getContextPath()%>/jspLeft<%=fragment%>" id=left name="leftFrame" frameborder="1"> 
	<frameset rows="50,*" cols="*" border="0">
		<frame src="<%=request.getContextPath()%>/jspTop" id=top name="topFrame" scrolling="NO" marginwidth="0" marginheight="0" frameborder="0">
		<frame src="<%=main%>" id=main name="mainFrame">
	</frameset>
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>