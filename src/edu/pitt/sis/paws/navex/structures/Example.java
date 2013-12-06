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

import edu.pitt.sis.paws.core.*;

public class Example extends Item
{
	// Constants
	private final static int EXAMPLE_AVAIL = -1; // available
	private final static int EXAMPLE_LOCKED = 1; // not available
//	private final static int TAG_ACTIVE = 1;
//	private final static int TAG_FIRED = 2;
	public final static String EXAMPLE_TXT = "&mode=txt";
	public final static String EXAMPLE_SIM = "&mode=sim";
	public final static String EXAMPLE_SN = "&mode=sn";

	/** Id of the example */
	private String exampleId = null;
	/** Base URL of the example */
	private String baseURL = null;

	/** Score/progress of the user */
	private float u_progr = 0;
	/** progress of others */
	private float o_progr = 0;
	/** when Example is considered done */
	private float threshold = 1;
	/** clicks of user */
	private int u_click = 0;
	/** clicks of others */
	private int o_click = 0;
	
	/** Prerequisite concepts */
	private ItemVector<Concept> inputs = null;
	/** Outcome concepts */
	private ItemVector<Concept> outputs = null;
	/** Availability state - done/avail/locked */
	private byte state;
	/** Processing tag */
	private int tag;

	public Example(int _id, String _example_id, String _title, String _url)
	{
		super(_id,_title);
		exampleId = _example_id;
		baseURL = _url;

		inputs = new ItemVector<Concept>();
		outputs = new ItemVector<Concept>();

		tag = 0;
		state = EXAMPLE_LOCKED;
		u_progr = 0;
		o_progr = 0;
		threshold = 1;
		u_click = 0;
		o_click = 0;
	}

	//-- Setters and Getters
	/** Getter for the Id of the example */
	public String getExampleId() { return exampleId; }
	/** Getter for the URL of the example */
	public String getBaseURL() { return baseURL; }

	/** Getter for the Score/progress of the user */
	public float getUProgr() { return u_progr; }
	/** Setter for the Score/progress of the user */
	public void setUProgr(float _u_progr)
	{// set U progress
		u_progr = _u_progr;
//System.err.println("Example: example: " + id + " in : " + outputs.size() + "  out: " + inputs.size() + "  progress: " + u_progr);

		int learnt = 0;
		for(int j=0;j<outputs.size();j++)
			learnt += (outputs.get(j).isDone())?1:0;
		for(int j=0;j<inputs.size();j++)
			learnt += (inputs.get(j).isDone())?1:0;

		threshold = (float)0.8*((outputs.size()+inputs.size() - learnt)/
			(outputs.size()+inputs.size()));
//System.err.println("Example: id " + id + " learnt " + learnt + " of " +
//	(outputs.size()+inputs.size()));
//System.err.println("Example: id " + id + " threshold "+threshold);
//System.err.println("Example: id " + id + " progress "+u_progr);
//System.err.println("----------------------------");
		//outputs.Count()/(outputs.Count()+inputs.Count());

		if(threshold<=0.3) threshold = (float)0.3;
		else if (threshold<=0.6) threshold = (float)0.6;
		else threshold = (float)1.0;

		if(u_progr >= threshold)
		{
//System.err.println("  trigger em " + this.getTitle());
			for(int j=0;j<outputs.size();j++)
			{
				outputs.get(j).setDone();
//System.err.println("\t\t" + outputs.get(j).getTitle());
			}
			for(int j=0;j<inputs.size();j++)
			{
				inputs.get(j).setDone();
//System.err.println("\t\t" + inputs.get(j).getTitle());
			}
			this.setAvail(false);
		}
	}// end of -- set U progress

	/** Getter for the Score/progress of others */
	public float getOProgr() { return o_progr; }
	/** Setter for the Score/progress of others */
	public void setOProgr(float _o_progr) { o_progr = _o_progr; }

	/** Getter for the Threshold */
	public float getThreshold() { return threshold; }
	/** Setter for the Threshold */
	public void setThreshold(float _threshold) { threshold = _threshold; }

	/** Getter for the clicks of user */
	public int getUClick() { return u_click; }
	/** Setter for the clicks of user */
	public void setUClick(int _u_click) { u_click = _u_click; }

	/** Getter for the clicks of others */
	public int getOClick() { return o_click; }
	/** Setter for the clicks of others */
	public void setOClick(int _o_click) { o_click = _o_click; }

	/** Getter for the Prerequisite concepts */
	public ItemVector<Concept> getInputs() { return inputs; }
	/** Getter for the Outcome concepts */
	public ItemVector<Concept> getOutputs()  { return outputs; }
	/** Getter for the Availability state - done/avail/locked */
	public byte getState() { return state; }
	/** Getter for the Processing tag */
	public int getTag() { return tag; }

	/** Checks whether Example is available 
	 * @return - true if Example is available */
	public boolean isAvail(){ return state == EXAMPLE_AVAIL; }
	/** Checks whether Example is locked 
	 * @return - true if Example is locked */
	public boolean isLocked(){ return state == EXAMPLE_LOCKED; }

	/** Set Example status to AVAIL
	 * @param check_availability - check whether all prereqs are in AVAIL
	 * 	state before sessing */
	public void setAvail(boolean check_availability)
	{
		if(check_availability)
		{
			if (!arePrereqsDone())
			{
				System.err.println("Error!: not all prereqs are done. #101");
				return;
			}
		}
		state = EXAMPLE_AVAIL;
	}

	/** Returns true if all prerequisite concepts are 'Done' false otherwise
	 * @return - true if all prerequisite concepts are 'Done' false otherwise
	 */
	public boolean arePrereqsDone()
	{
		for(int i=0;i<inputs.size();i++)
		{
//if(this.getTitle().equalsIgnoreCase("L11: countdown1.c"))
//if(this.getId()==484)
//{
//	System.out.println("\t\t'L11: countdown1.c' concept(" + inputs.size() + "):" + inputs.get(i).getTitle() + " done?: " + inputs.get(i).isDone());
//}
			if(!inputs.get(i).isDone()) return false;
		}
		return true;
	}

}
