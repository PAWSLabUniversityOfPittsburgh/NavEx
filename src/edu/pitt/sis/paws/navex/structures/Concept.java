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

public class Concept extends Item //implements Cloneable 
{
	//Constants
	private final static int CONCEPT_DONE = -1;
	private final static int CONCEPT_LOCKED = 1;
	
	public byte state;// -1 viewed, 0 avail, 1 navail
	public int tag;

	public Concept(int _id, String _title)
	{
		super(_id,_title);
		tag = 0;
		state = CONCEPT_LOCKED;
	}
	
//	public Object clone()
//	{
//		Concept copy = null;
//		try{ copy = new Concept(this.id, new String(this.title));}
//		catch (Exception e) { e.printStackTrace(System.out); }
//		copy.state = this.state;
//		copy.tag = this.tag;
//		return copy;
//	}

	public boolean isDone() { return (state == CONCEPT_DONE); }
	public void setDone(){ state = CONCEPT_DONE; }
}
