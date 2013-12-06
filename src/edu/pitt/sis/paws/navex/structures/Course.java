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

//import java.util.*;

public class Course implements Cloneable
{
	//Constants
	public int id;
	public String title;
	public String description;
	public boolean conceptmap;
	public boolean modulemap;
	public int tag;

	public Course(int _id, String _title, String _desc, boolean _cmap,
		boolean _mmap)
	{
		id = _id;
		title = _title;
		description = _desc;
		conceptmap = _cmap;
		modulemap = _mmap;
		tag = 0;
	}
	public Object clone()
	{
		Course copy = null;
		try
		{
			copy = new Course(this.id, new String(this.title),
				new String(this.description), this.conceptmap, this.modulemap);
		}
		catch (Exception e) { e.printStackTrace(System.err); }
		copy.tag = this.tag;
		return copy;
	}
}
