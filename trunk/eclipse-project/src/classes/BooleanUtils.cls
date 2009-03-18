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
	
	global static Boolean toBoolanDefaultIfNull(Boolean bool, Boolean defaultVal)
	{
		if(bool==null)
			return defaultVal;
		else
			return bool;
	}
	
	global static Boolean toBoolean(Integer value)
	{
		if(value==null)
			return false;
		else
		{
			if(value==0)
				return false;
			else
				return true;
		}
	}
	
	
	/************************************/
	//Converts an int to a boolean specifying 
	//the conversion values.
	//    Parameters:
    //    value - the Integer to convert, may be null
    //    trueValue - the value to match for true, may be null
    //    falseValue - the value to match for false, may be null 
    //Returns:
    //    true or false 
    //Throws:
    //    java.lang.IllegalArgumentException - if no match
	/************************************/
	global static Boolean toBoolean(Integer value,
							Integer trueValue,
							Integer falseValue)
	{
		if(value==trueValue)
			return true;
		else if(value==falseValue)
			return false;
		else
			throw new IllegalArgumentException();
	}
	
	
	global static Boolean toInteger(Boolean bool)
	{
		if(bool==null)
			throw new IllegalArgumentException();
		else
		{
			if(bool)
				return true;
			else
				return false;
		}
	}
	
	
	global static String toStringYesNo(Boolean bool,
								  	   String trueString,
								  	   String falseString)
	{
		if(bool==null)
			return null;
		else
		{
			if(bool)
				return 'yes';
			else
				return 'no';
		}
	}
	
	global static String toString(Boolean bool,
								  String trueString,
								  String falseString)
	{
		if(bool)
			return trueString;
		else
			return falseString;
	}
	
	global static Boolean xor(Boolean[] boolArray)
	{
		if(boolArray==null || boolArray.size()==0)
			throw new IllegalArgumentException();
		else
		{
			Boolean firstItem=boolArray[0];
			for(Boolean bool:boolArray)
			{
				if(bool!=firstItem)
					return false;
			}
			return true;
		}	
	} 

}