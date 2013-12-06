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

package edu.pitt.sis.paws.navex.structures;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
//import edu.pitt.sis.paws.navex.structures.*;

import edu.pitt.sis.paws.navex.*;
//import edu.pitt.sis.paws.um.structures.*;
import edu.pitt.sis.paws.core.*;
import edu.pitt.sis.paws.cbum.report.*;

public class ResMap implements Cloneable
{
	//CONSTANTS
	// Example-Concept Link orientatio
	private final static int LNK_IN = 0;
	private final static int LNK_OUT = 1;
	
	/** User Login */
	private String user_login;
	/** Id of the scope - group of examples */
	private int scope_id;
	/** Server Base URL*/
	private String serverBaseURL;
	/** List of Concepts */
	private ItemVector<Concept> concepts;
	/** List of Examples */
	private ItemVector<Example> examples;

	/** Constructor for ResMap
	 * @param _user - user login
	 * @param _scope_id - scope (example set) id
	 */
	public ResMap(String _user, int _scope_id)
	{
		concepts = new ItemVector<Concept>();
		examples = new ItemVector<Example>();
		user_login = _user;
		scope_id = _scope_id;
		serverBaseURL = null;
	}
	
	//-- Setters and Getters
	/** Getter for User Login */
	public String getUserLogin() { return user_login; }
	/** Getter for Id of the scope - group of examples */
	public int getScopeId() { return scope_id; }
	/** Server Base URL */
	public String getServerBaseURL() { return serverBaseURL; }
	/** Getter for List of Concepts */
	public ItemVector<Concept> getConcepts() { return concepts; }
	/** Getter for List of Examples */
	public ItemVector<Example> getExamples() { return examples; }
	
//	private boolean int2bool(int _int)
//	{
//		return _int==0?true:false;
//	}
	
	public void Load() //throws SQLException
	{// Load resource map
		Connection conn = null;
		String qry = "";
		ResultSet rs = null;
		try
		{
			conn = sgtSessionManager.getConntection();
//System.err.println("RM: conn not null " + (conn != null));
			// LOAD Server prefix
			qry = "SELECT s.ServerPrefix FROM ent_scope s " + 
				"WHERE s.ScopeID=" + scope_id + ";";
			rs = sgtSessionManager.executeStatement(conn, qry);
			if(rs.next())
				serverBaseURL = rs.getString("ServerPrefix");
				
			// LOAD Examples
			qry = "SELECT m.* FROM ent_example m, rel_scope_example rel " + 
				"WHERE m.ExampleID=rel.ExampleID AND " +
				"rel.ScopeID=" + scope_id + ";";
			rs = sgtSessionManager.executeStatement(conn, qry);
			while (rs.next())
			{
				examples.add(new Example(rs.getInt("ExampleID"),
					rs.getString("ExampleActivityID"), rs.getString("Title"),
					rs.getString("URL")));
			}
//System.err.println("RM: Examples ok");
			// LOAD Concepts
			qry = "SELECT DISTINCT c.* FROM ent_concept c, rel_example_concept r_ec,"+
				"rel_scope_example r_se "+
				"WHERE c.ConceptID=r_ec.ConceptID AND " +
				"r_ec.ExampleID=r_se.ExampleID AND " +
				"r_se.ScopeID=" + scope_id + ";";
			rs = sgtSessionManager.executeStatement(conn, qry);
			while (rs.next())
			{
				concepts.add(new Concept(rs.getInt("ConceptID"),
					rs.getString("Title")));
			}
//System.err.println("RM: Concepts ok");
			//Load Concept-Example Connectors
			qry = "SELECT rec.ExampleID, rec.ConceptID, rec.Relation " +
				"FROM rel_example_concept rec, rel_scope_example rse "+
				"WHERE  rec.ExampleID=rse.ExampleID AND " +
				"rse.ScopeID=" + scope_id + ";";
			rs = sgtSessionManager.executeStatement(conn, qry);
			while (rs.next())
			{
				Example modl = examples.findById(rs.getInt("ExampleID"));
				Concept conc = concepts.findById(rs.getInt("ConceptID"));
if(conc == null)
	System.out.println("RS-load: Error! no concept with this id found!");
				int link = rs.getInt("Relation");
				if (link == LNK_IN) modl.getInputs().add(conc);
				else if (link == LNK_OUT) modl.getOutputs().add(conc);
//if(modl.getId()==484)
//{
//	System.out.println("\tLoading 'L11: countdown1.c' concept:" + conc.getTitle() + " #in: " + modl.getInputs().size() + " #out:" + modl.getOutputs().size());
//}
			}
//System.err.println("RM: Links ok");
		}
		catch (Exception e) { e.printStackTrace(System.err); }
		finally {sgtSessionManager.freeConnection(conn);}
	}// Load resource map
//	/**
//	 * Upload the progress of the activities into Examples
//	 * calculate the status of examples and concepts (avail/navail/progress)
//	 * SO FAR HARDCODE THE '75% IS DONE' THRESHOLD
//	 * @param up - User profile to take progresses from
//	 */
//	public void uploadProfile(UserProfileRecordList uprlist)
//	{
//		if(uprlist == null)
//		{
//			System.out.println("ResMap.uploadUserActivityProfile: userprof null");
//			return;
//		}
//		// Example centered search and upload
///*		for(int i=0;i<examples.Count();i++)
//		{
//			UserProfileRecord upr = uprlist.findByAcivity(
//				examples.At(i).external_id);
//			examples.At(i).setProgress(upr.u_progr);
//			examples.At(i).setOProgress(upr.o_progr);
//			examples.At(i).u_click = upr.u_click;
//			examples.At(i).o_click = (int)Math.ceil((double)upr.o_click);
//		}/**/
//		// Activity centered search and upload
//		for(int i=0;i<uprlist.Count();i++)
//		{
//			Example example = null; 
//			for(int j=0; j<examples.size(); j++)
//			{
//				if(examples.get(j).getExampleId().
//					equalsIgnoreCase(uprlist.At(i).act))
//				{
//					example = examples.get(j);
//					break;
//				}
//			}
//			
//			if(example != null)
//			{
//				example.setUProgr(uprlist.At(i).u_progr);
////if(example.getProgress()<0) System.err.println("ResMap.uploadUserActivityProfile act " + uprlist.At(i).act + " mod " + example.id + " progress -1!");
//				example.setOProgr(uprlist.At(i).o_progr);
////if(example.getOProgress()<0) System.err.println("ResMap.uploadUserActivityProfile act " + uprlist.At(i).act + " mod " + example.id + " Oprogress -1!");
//				example.setUClick( uprlist.At(i).u_click );
//				example.setOClick( (int)Math.ceil((double)uprlist.At(i).o_click) );
//			}
//		}/**/
//		// compute status of examples
//		updateExampleStates();
//	}
	
	public void uploadUserActivityProfile(ArrayList profile, boolean _recalc_examples)
	{
		if(profile == null)
		{
			System.out.println("ResMap.uploadUserActivityProfile: userprof null");
			return;
		}
		// Example centered search and upload
/*		for(int i=0;i<examples.Count();i++)
		{
			UserProfileRecord upr = uprlist.findByAcivity(
				examples.At(i).external_id);
			examples.At(i).setProgress(upr.u_progr);
			examples.At(i).setOProgress(upr.o_progr);
			examples.At(i).u_click = upr.u_click;
			examples.At(i).o_click = (int)Math.ceil((double)upr.o_click);
		}/**/
		// Activity centered search and upload
//System.out.println("[navex] ResMap.uploadUserActivityProfile"); /// DEBUG				
		for(int i=0;i<profile.size();i++)
		{
			ProgressEstimatorReport per = 
				(ProgressEstimatorReport)profile.get(i);
//System.out.println("\t" + per); /// DEBUG				
			Example example = getExampleByExampleId(per.getId());
			
			if(example != null)
			{
				example.setUProgr((float)per.getProgress(1/*fudge*/));
				example.setOProgr((float)per.getGroupCount(1/*fudge*/));
				example.setUClick(per.getCount(1/*fudge*/));
				example.setOClick((int)per.getGroupProgress(1/*fudge*/));
			}
		}/**/
		// compute status of examples
		if(_recalc_examples) updateExampleStates();
	}

    public void uploadUserConceptProfile(ArrayList profile, boolean _recalc_examples)
    {
	    if(profile == null)
	    {
		    System.out.println("ResMap.uploadUserConceptProfile: userprof is null");
		    return;
	    }

	    for(int i=0;i<profile.size();i++)
	    {
		    ProgressEstimatorReport per = 
			    (ProgressEstimatorReport)profile.get(i);
    //System.out.println("\t" + per); /// DEBUG
		    Concept concept = concepts.findByTitle(per.getId());
		    
		    if(concept != null)
		    {
			if(per.getProgress(1/*fudge*/) > .5)
			{
			    // set concept as done and trigger the examples
//if(!concept.isDone()) System.err.println("    concept=" + per.id + " is overridden done");
			     concept.setDone();
			}
		    }
	    }/**/
	    // compute status of examples
	    if(_recalc_examples) updateExampleStates();
    }

	
	
	public void updateExampleStates()
	{
//System.out.println("[navex] ResMap.updateExampleStates --------------"); /// DEBUG
		for(int i=0;i<examples.size();i++)
		{
			if(examples.get(i).arePrereqsDone())
			{
				examples.get(i).setAvail(false); // set DONE w/o checking
//System.out.println("[navex] ResMap.updateExampleStates Available Id=" + examples.get(i).getId() + " Title=" +  examples.get(i).getTitle()); /// DEBUG
			}
		}
	}
	/** Display the map of the scope examples
	 * @param out - output stream
	 * @param cur_mod_id - Id of the current module, -1 if no current module
	 * @param session - current Http Session
	 * @param context_path - base path to the web application
	 */
	public void displayCourseMap(JspWriter out, int cur_mod_id, 
		HttpSession session, String context_path) throws IOException
	{
		// Table header
		out.println("<table border=\"0\" cellspacing=\"2\" cellpadding=\"1\" bordercolor=\"#FFFFFF\">");
//System.err.println("ResMap: SHOWING current example "+ current_example.title);

//System.err.println("ResMap intf " + intf);		
		String intf = (String)session.getAttribute(sgtSessionManager.SESS_INTERFACE);
		String other_parameters = (String)session.getAttribute(sgtSessionManager.SESS_OTHER_PARAMS);
		
		for(int i=0; i<examples.size(); i++)
		{
			// ANNOTATIONS
			//	Example name Cell
			String cell_class = ((examples.get(i).getId()==cur_mod_id))?
				"class='ExampleCurrentCell'":"class='ExampleRegularCell'";
			// Progress icon
			String icon_name = (examples.get(i).isAvail()) ?
				sgtSessionManager.getProgressIcon(examples.get(i).getUProgr()) :
				sgtSessionManager.icon_locked;/**/
			// Availability Icon
			String path = context_path + sgtSessionManager.SYSTEM_PATH + "/";
			
			String icon_avail = (!examples.get(i).isAvail()) ? 
				"<img src='" + path + sgtSessionManager.icon_navail + "'>":
					(examples.get(i).getUProgr()>examples.get(i).getThreshold()) ?
					"<img src='" + path + sgtSessionManager.icon_done + "'>":
					"";
				
			// Social navigation cell style and icon
//			int u_lev = SocialNavigation.getClickLevel(examples.At(i).u_click);
//			int o_lev = SocialNavigation.getClickLevel(examples.At(i).o_click);
//			String socio_cell = sgtSessionManager.social_progress[o_lev];
//			String socio_icon = sgtSessionManager.social_icon[u_lev];

			int u_prog = SocialNavigation.getPlogressLevel(examples.get(i).getUProgr());
			int o_prog = SocialNavigation.getPlogressLevel(examples.get(i).getOProgr());
//System.out.println("[navex] " + examples.get(i).getTitle() + " Oprogress=" + examples.get(i).getOProgr());
			String socio_cell = sgtSessionManager.social_progress[o_prog];
			String socio_icon = sgtSessionManager.social_icon[u_prog];
			
			// Example name link style
			String link_class = 
				((examples.get(i).getThreshold()>examples.get(i).getUProgr()) &&
				examples.get(i).isAvail()) ? 
				"'ExampleLinkHighligh'" : "'ExampleLink'";
				
			out.println("<tr>");// height='20'
			
			// Social Cell
			if(intf.toUpperCase().indexOf(sgtSessionManager.INTERFACE_SOCIAL)!=-1)
			{
				out.println("<td width='16' class=" + socio_cell + ">");
				out.println("<p class=" + socio_icon + ">&nbsp;</p>");
				out.println("</td>");
//System.out.print("[navex] Social cell");
			}
			// Availability Cell
			if(intf.toUpperCase().indexOf(sgtSessionManager.INTERFACE_AVAIL)!=-1)
			{
				out.println("<td width='16'>");
				out.println(icon_avail);
				out.println("</td>");
//System.out.print("[navex] Avail cell");
			}
			// Progress Cell
			if(intf.toUpperCase().indexOf(sgtSessionManager.INTERFACE_PROGRESS)!=-1)
			{
				out.println("<td width='16'>");
				out.println("<img src=\"" + context_path + 
					sgtSessionManager.SYSTEM_PATH + "/" + icon_name + "\">");
				out.println("</td>");
//System.out.print("[navex] Progress cell");
			}
			// Example name Cell
			out.println("<td " + cell_class + ">");//<a" + active_id + ">");

//System.err.println("ResMap: example: " + examples.At(i).id + " progress: " + examples.At(i).getProgress() + 
//	" u_click/o_click: " + examples.At(i).u_click + "/" + examples.At(i).o_click +
//	" u_lev/o_lev: " + SocialNavigation.getClickLevel(examples.At(i).u_click) + "/" + SocialNavigation.getClickLevel(examples.At(i).o_click));

//			String pin = "#"+examples.At(i).id; // link to current active Example
				// link to the example nonempty id avail
				// ALWAYS A LINK
			
//			String state = (examples.get(i).isAvail()) ?
//				sgtSessionManager.getState(examples.get(i).getUProgr()) :
//				sgtSessionManager.NAVAIL_VAL;/**/
			
				
			// UPLOAD THE TRAIL
			String svc_new = "";
			if(examples.get(i).getId()==cur_mod_id)
			{
				svc_new = sgtSessionManager.NAVAIL_VAL + 
					((examples.get(i).isAvail())?Integer.toString(u_prog):"n") + o_prog;
				session.removeAttribute(sgtSessionManager.TRAIL_PAR);
				session.setAttribute(sgtSessionManager.TRAIL_PAR,svc_new);
//System.err.println("ResMap putting trail par "+sgtSessionManager.TRAIL_PAR+"="+svc_new);				
//System.err.println("ResMap checking trail par "+sgtSessionManager.TRAIL_PAR+"="+(String)session.getAttribute(sgtSessionManager.TRAIL_PAR + " session" + session.getId()));				
			}

			String href = (examples.get(i).getId()!=cur_mod_id) ? 
				(" href=\"" + context_path +
				"/Show?" + sgtSessionManager.REQ_EXAMPLE_ID + "=" + 
				examples.get(i).getId() + other_parameters + "#" + 
				examples.get(i).getId() + "\" target=\"_top\"") : "";
				//+++ HARCODED SERVLETNAME SO FAR
			
//			String onclick = (examples.get(i).getId()==cur_mod_id) ? 
//				" onClick='window.location.reload();'" : "";
			
			out.println("<a name='" + examples.get(i).getId() +  "'" +
				href + /*onclick +*/ " class=" + link_class + ">" );
			out.println(examples.get(i).getTitle());
			out.println("</a></td></tr>");
		}
		// closing the table
		out.println("</table>");
	}
	
	
	
	public Example getExampleByExampleId(String _example_id)
	{
		for(int i=0; i<examples.size(); i++)
			if(examples.get(i).getExampleId().equalsIgnoreCase(_example_id))
				return examples.get(i);
		return null;
	}
	
	public String Examples2Advise()
	{
		String result = "";
		for(int i=0; i<examples.size(); i++)
		{
			Example example = examples.get(i);
			if(result.length()>0)
				result+= ",";
			result += example.getTitle() + "(";
			String eg_concepts = "";
			for(int j=0; j<concepts.size(); j++)
			{
				Concept concept = concepts.get(j);
				if(eg_concepts.length()>0)
					eg_concepts += ",";
				if( (example.getInputs().findById(concept.getId()) != null) ||
					(example.getOutputs().findById(concept.getId()) != null))
					eg_concepts += "1";
				else
					eg_concepts += "0";
			}
			String eg_state = (example.isLocked())?"-1":
				Long.toString(Math.round(example.getUProgr()*10/2.5));
			result += eg_concepts + 
				"|" + eg_state + 
				")";
		}
		return result;
	}

	public String Concepts2Advise()
	{
		String result = "";
		for(int i=0; i<concepts.size(); i++)
		{
			Concept concept = concepts.get(i);
			if(result.length()>0)
				result+= ",";
			result += concept.getTitle();
		}
		return result;
	}

	public String URLs4Advise(String other_parameters)
	{
		String result = "";
		for(int i=0; i<examples.size(); i++)
		{
			Example example = examples.get(i);
			if(result.length()>0)
				result+= ",";
			result += example.getBaseURL() + other_parameters;
		}
		return result;
	}

/*	public String getExampleTitleByID(int example_id)//
	{
		return ((Example)examples.findByID(example_id)).title;
	}/**/
}
