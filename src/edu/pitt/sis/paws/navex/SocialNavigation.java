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

/** Social Navigation Functionality */
package edu.pitt.sis.paws.navex;

//import java.io.*;
//import java.util.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.net.*;
//
//import edu.pitt.sis.paws.navex.structures.*;
//import edu.pitt.sis.paws.um.structures.*;

//import org.w3c.dom.*;
//import com.lena.utils.*;

public class SocialNavigation
{
	// Context parameter names (without suffixation)
	public static final int MAX_CLICKS = 10;
	public static final int MIN_CLICKS = 0;
	public static final int NO_INTERVALS = 3;
	
	/**
	 * Converts number of clicks into a scale category by cubic transformation
	 * number of intervals - default, maximum number of clicks - default
	 * @param _clicks - current number of clicks
	 * @return scale category
	 */
	public static int getClickLevel(int _clicks)
	{
		int clicks = (_clicks>MAX_CLICKS)?MAX_CLICKS:_clicks;
		float x = ((float) (clicks * NO_INTERVALS * NO_INTERVALS * NO_INTERVALS) / MAX_CLICKS);
		float y = (float)Math.pow(x, (float)1/3);
		return (int)Math.floor(y*1.01);
	}
	/**
	 * Converts nprogress [0,1] into a scale category by cubic transformation
	 * number of intervals - default, maximum number of clicks - default
	 * @param _progress - current progress
	 * @return scale category
	 */
	public static int getPlogressLevel(float _progress)
	{
		int progress = (int)(_progress * MAX_CLICKS);
		float x = ((float) (progress * NO_INTERVALS * NO_INTERVALS * NO_INTERVALS) / MAX_CLICKS);
		float y = (float)Math.pow(x, (float)1/3);
		int result = (int)Math.floor(y*1.01);
		return (result>NO_INTERVALS)?NO_INTERVALS:result;
	}
	/*
		float x = (_clicks>MAX_CLICKS)?MAX_CLICKS:_clicks;

		// If any of the parameters are 0, log returns -infinity, hence we are checking that. If it is 0 , then we leave it at 0.
		if(x != 0)
		{
			x = (float)java.lang.Math.log((double)(x));
			if(x == 0) // that means input to log function was 1
			x = (float)0.2;  // something less than log(2) , so that we get lighter color than that obtained for 2
		}
		//First normalize x
		float normalizedx = ( ((x - MIN_CLICKS) / (MAX_CLICKS - MIN_CLICKS)) *
			(NO_INTERVALS - MIN_CLICKS) ) + MIN_CLICKS ;
		
		return (int)java.lang.Math.ceil((double)normalizedx);
	/**/
}
