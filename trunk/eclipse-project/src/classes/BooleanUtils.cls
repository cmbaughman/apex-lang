/**
 * Port of the BooleanUtils class from Java to Apex.  This
 * class is part of the Apache Commons Lang project available
 * at http://commons.apache.org/lang/.
 */

global class BooleanUtils {

	global static Boolean isFalse(Boolean bool)
	{
		if(bool==null)
			return false;
		else
			return !bool;
	}
	
	global static Boolean isNotFalse(Boolean bool)
	{
		if(bool==null)
			return true;
		else
			return bool;
	}
	
	global static Boolean isNotTrue(Boolean bool)
	{
		if(bool==null)
			return true;
		else
			return bool;
	}
	
	global static Boolean isTrue(Boolean bool)
	{
		if(bool==null)
			return false;
		else
			return bool;
	}
	
	global static Boolean negate(Boolean bool)
	{
		if(bool==null)
			return null;
		else
			return !bool;
	}

}