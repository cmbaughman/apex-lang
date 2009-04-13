/* ============================================================
 * This code is part of the "apex-lang" open source project avaiable at:
 * 
 *      http://code.google.com/p/apex-lang/
 *
 * This code is licensed under the Apache License, Version 2.0.  You may obtain a 
 * copy of the License at:
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * ============================================================
 */
global class ArrayUtils {
	
	global static String[] EMPTY_STRING_ARRAY = new String[]{};
	
    global static Object[] reverse(Object[] anArray) {
        if (anArray == null) {
            return null;
        }
        Integer i = 0;
        Integer j = anArray.size() - 1;
        Object tmp;
        while (j > i) {
            tmp = anArray[j];
            anArray[j] = anArray[i];
            anArray[i] = tmp;
            j--;
            i++;
        }
        return anArray;
    }
    
    global static Boolean isEmpty(Object[] objectArray){
    	if(objectArray == null){
    		return true;
    	}
    	return objectArray.size() == 0;
    }
	
    global static Boolean isEmpty(SObject[] objectArray){
    	if(objectArray == null){
    		return true;
    	}
    	return objectArray.size() == 0;
    }
	
   	global static Object[] pluck(SObject[] objectArray, String fieldName){
    	if(isEmpty(objectArray) || StringUtils.isBlank(fieldName)){
    		return new Object[]{};
    	}
    	Object[] plucked = new Object[objectArray.size()];
    	for(Integer i = 0; i < objectArray.size(); i++){
    		plucked[i] = objectArray[i].get(fieldName);
    	}
    	return plucked;
    }
	
    global static String toString(Object[] objectArray){
    	if(objectArray == null){
    		return 'null';	
    	}
    	String returnValue = '{';
        for(Integer i = 0; i < objectArray.size(); i++){
	    	if(i!=0){ returnValue += ','; }
	    	returnValue += '\'' + objectArray[i] + '\'';
        }
    	returnValue += '}';
    	return returnValue; 
    }
    
    global static void assertArraysAreEqual(Object[] expected, Object[] actual){
    	//check to see if one param is null but the other is not
    	System.assert((expected == null && actual == null)|| (expected != null && actual != null),
    		'Assertion failed, the following two arrays are not equal.  Expected: ' 
    				+ ArrayUtils.toString(expected) + ', Actual: ' + ArrayUtils.toString(actual));
    	if(expected != null && actual != null){
	    	System.assert(expected.size() == actual.size(), 'Assertion failed, the following two arrays are not equal.  Expected: ' 
    				+ ArrayUtils.toString(expected) + ', Actual: ' + ArrayUtils.toString(actual));
    		for(Integer i = 0; i < expected.size(); i++){
    			System.assert(expected[i] == actual[i], 'Assertion failed, the following two arrays are not equal.  Expected: ' 
    				+ ArrayUtils.toString(expected) + ', Actual: ' + ArrayUtils.toString(actual));
    		}
    	}
    }
    
    
}