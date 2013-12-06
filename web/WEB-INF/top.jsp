<%@ page 
	contentType="text/html;charset=utf-8"
	language="java"
	import="java.io.*, java.util.*, edu.pitt.sis.paws.navex.structures.*, 
		edu.pitt.sis.paws.navex.*, java.net.*;"
	errorPage=""
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%!
	public Example current_example;
%>
<%
	current_example = (Example)session.getAttribute(
		sgtSessionManager.SESS_CURRENT_EXAMPLE);


//	// What to report
//	ArrayList reqArray = new ArrayList();
//	
//	reqArray.add(new ProgressEstimatorReport("2.1",0,0));
//	reqArray.add(new ProgressEstimatorReport("2.2",0,0));
//	reqArray.add(new ProgressEstimatorReport("2.3",0,0));
//	reqArray.add(new ProgressEstimatorReport("2.4",0,0));
//
//	try{
//		URL url = new URL("http://localhost:8080/cbum/ReportManager?type=act&dir=in&format=dat&app=3&kt_user=myudelson");
//		URLConnection con = url.openConnection();
//	    	con.setUseCaches(false);
//		con.setDefaultUseCaches(false);
//		con.setDoOutput(true);
//		con.setDoInput(true);
////		con.setRequestProperty("Content-Type","application/x-java-serialized-object");
//		con.setRequestProperty("Content-Type","java-internal/" + reqArray.getClass().getName());
//System.err.println("[navex]: connection good");
//
//		ObjectOutputStream oo = new ObjectOutputStream(con.getOutputStream());
//System.err.println("[navex]: ObjectOutputStream");
//		oo.writeObject(reqArray);
//System.err.println("[navex]: sent! to " + "http://localhost:8080/cbum/ReportManager?type=act&dir=in&format=dat");
//		oo.flush();
////		oo.reset();
//		oo.close();
//System.err.println("[navex]: -----");
//		
//
//		ObjectInputStream ii = new ObjectInputStream(con.getInputStream());
//		ArrayList resArray = null;
//		try{ resArray = (ArrayList)ii.readObject(); }
//		catch(Exception e) { e.printStackTrace(System.err); }
//		finally{ii.close();} 
//
//		
//		System.out.println("[navex] top received response");
//		for(int i=0; i<resArray.size() ;i++)
//		{
//			System.out.println("\t" + resArray.get(i));
//		}
//		
//		
////System.err.println("[navex]: before stream");
////		ObjectInputStream result = new ObjectInputStream(in);
////		ArrayList uprlist = null;
////System.err.println("[navex]: before in");
////		try{ uprlist = (ArrayList)result.readObject(); }
////		catch(Exception e) { e.printStackTrace(System.err); }
////System.err.println("[navex]: done");
////System.err.println("[navex]:===================================");
//
//	}
//	catch(Exception e) { e.printStackTrace(System.out); }
		
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title></title>
<link rel='stylesheet' href="<%=request.getContextPath() +
	sgtSessionManager.SYSTEM_PATH%>/A2TeAL.css" type="text/css"/>

<script type='text/javascript' language='javascript'>
function change(param)
{
	if(param==-1)
	{
		document.getElementById('frameControl').innerHTML = 
			"<a href='#' class='Button' onClick='change(1);'><img border='0' src='"+ "<%=request.getContextPath()%>" +
			 "<%=sgtSessionManager.SYSTEM_PATH%>" + "/right.gif' alt='>>'/></a>";
		top.document.getElementById('frameset').cols = '0,*';
		top.document.getElementById('left').noResize = 'true';
	}
	else if(param==1)
	{
		document.getElementById('frameControl').innerHTML = 
			"<a href='#' class='Button' onClick='change(-1);'><img border='0' src='"+ "<%=request.getContextPath()%>" +
			 "<%=sgtSessionManager.SYSTEM_PATH%>" + "/left.gif' alt='<<'/></a>";
		top.document.getElementById('frameset').cols = '250,*';
		top.document.getElementById('left').noResize = null;
		top.frames[0].Reload();
	}
}
</script>

</head>
<body>
<!-- Example Title -->
<table width='100%' cellpadding='0' cellspacing='0'>
	<tr><td class='ExampleTitle'>
		<%=(current_example!=null)?current_example.getTitle():"Help!"%>
	</td></tr>
</table>
<!-- Menu buttons-->
<table width='100%' border='0' cellpadding='0' cellspacing='2'>
<tr>
<!-- 		Hide/show map button -->
	<td width='16' height='16'>
		<div id='frameControl'><a href='#' class='Button' onClick='change(-1);'><img border='0' src='<%=request.getContextPath() + sgtSessionManager.SYSTEM_PATH%>/left.gif' alt='&lt;&lt;'/></a></div>
	</td>
<!-- 		Reload button -->
	<%
		if(current_example!=null)
		{
			Example current_example = (Example)session.getAttribute(
				sgtSessionManager.SESS_CURRENT_EXAMPLE);
			out.println("<td width='16'><div id=reload><a href='#' class='Button'"+
				" onClick='parent.ReloadMe();'><img src='" +  
				request.getContextPath() + sgtSessionManager.SYSTEM_PATH + "/" + 
				"reload.gif' border='0'/></a></div>");
			out.println("</td>");
		}
	%>
<!-- 		Help button -->
	<%
		out.println("<td width='100%'></td>");
		if(current_example!=null)
		{
			String other_parameters = (String)session.getAttribute(
				sgtSessionManager.SESS_OTHER_PARAMS);
			
			String href = " href=\"" + request.getContextPath() + 
				"/Show?" + sgtSessionManager.REQ_EXAMPLE_ID + "=-1" + 
				other_parameters + "\" target='_top' ";			
			out.println("<td><div id=help><a" + href + "><img src='"+
				request.getContextPath() + sgtSessionManager.SYSTEM_PATH +
				"/" + "help.gif' border='0'/></a></div>");
			out.println("</td>");
		}
	%>
</tr>
</table>

</body>
</html>