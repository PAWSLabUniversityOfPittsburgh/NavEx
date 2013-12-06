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
import javax.servlet.jsp.*;

public class HTMLUtils
{
	public static void Message(PrintWriter out, String message)
	{
		out.println("<meta http-equiv=\"pragma\" content=\"text/html; no-cache;\"");
		out.println("no-cache; charset=iso-8859-1 \">");
		out.println("<HTML><BODY><P>");
		out.println(message);
		out.println("</P></BODY></HTML>");
		out.close();
	}
	public static void Message(JspWriter out, String message) throws IOException
	{
		out.println("<meta http-equiv=\"pragma\" content=\"text/html; no-cache;\"");
		out.println("no-cache; charset=iso-8859-1 \">");
		out.println("<HTML><BODY><P>");
		out.println(message);
		out.println("</P></BODY></HTML>");
		out.close();
	}
	public static void Header(PrintWriter out, String context_path, String pgTitle, boolean body, boolean frames)
	{
//		out.println("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//RU'>");
		if(frames)
			out.println("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Frameset//EN' 'http://www.w3.org/TR/html4/frameset.dtd'>");
		else
			out.println("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>");
		out.println("<html><head><title>");
		out.println(pgTitle);
		out.println("</title>");
//System.err.println("APP ROOT " + sgtSessionManager.APP_ROOT);		
//System.err.println("CSS " + sgtSessionManager.APP_ROOT + 
//	sgtSessionManager.SYSTEM_PATH);		

out.println("<link rel='stylesheet' href='" + context_path + 
			sgtSessionManager.SYSTEM_PATH + "/A2TeAL.css' type='text/css'/>");
out.println("<link rel='stylesheet' href='" + context_path + 
			sgtSessionManager.SYSTEM_PATH + "/A2TeAL.css' type='text/css' title='green' media='screen'/>");
out.println("<link rel='alternate stylesheet' href='" + context_path + 
			sgtSessionManager.SYSTEM_PATH + "/A2TeAL.css' type='text/css' title='blue' media='screen'/>");


//		out.println("<meta http-equiv=\"pragma\" content=\"text/html; no-cache; charset=iso-8859-1\">");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; no-cache; charset=utf-8\">");
		out.println("</head>");
		if (body) out.println("<BODY>");
	}
	public static void Footer(PrintWriter out, boolean body)
	{
		if (body) out.println("</BODY>");
		out.println("</html>");
	}
	public static void ModuleFrameset(PrintWriter out, String top, String left,
		String main)
	{
		out.println("<frameset id=frameset cols=\"250,*\" frameborder=\"YES\" border=\"4\" framespacing=\"4\" ");
		out.println("framespacing=\"0\">");
		out.println("	<frame src=\""+left+"\" id=left name=\"leftFrame\" > ");
		out.println("	<frameset rows=\"65,*\" cols=\"*\" frameborder=\"NO\" border=\"0\" framespacing=\"0\">");
		out.println("		<frame src=\""+top+"\" id=top name=\"topFrame\" scrolling=\"NO\" marginwidth=\"0\" marginheight=\"0\">");
		out.println("		<frame src=\""+main+"\" id=main name=\"mainFrame\">");
		out.println("	</frameset>");
		out.println("</frameset>");
		out.println("<noframes>");
		out.println("	<body>");
		out.println("	</body>");
		out.println("</noframes>");
	}
	public static void MainFrameset(PrintWriter out, String top,String bottom)
	{
		out.println("<frameset rows='40,*' cols='*' frameborder='NO' border='0' framespacing='0'>");
		out.println("	<frame src='"+top+"' name='topSubFrame' scrolling='NO' noresize marginwidth='0'> ");
		out.println("	<frame src='"+bottom+"' name='mainSubFrame' > ");
		out.println("</frameset>");
		out.println("<noframes>");
		out.println("	<body>");
		out.println("	</body>");
		out.println("</noframes>");
	}
}
