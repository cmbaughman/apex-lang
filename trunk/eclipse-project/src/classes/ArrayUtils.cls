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
    
    global static SObject[] reverse(SObject[] anArray) {
        if (anArray == null) {
            return null;
        }
        Integer i = 0;
        Integer j = anArray.size() - 1;
        SObject tmp;
        while (j > i) {
            tmp = anArray[j];
            anArray[j] = anArray[i];
            anArray[i] = tmp;
            j--;
            i++;
        }
        return anArray;
    }
    
    global static Object[] mergex(Object[] array1, Object[] array2){
    	if(array1 == null){ return array2; }
    	if(array2 == null){ return array1; }
    	Object[] merged = new Object[array1.size() + array2.size()];
    	for(Integer i = 0; i < array1.size(); i++){
    		merged[i] = array1[i];
    	}
    	for(Integer i = 0; i < array2.size(); i++){
    		merged[i+array1.size()] = array2[i];
    	}
    	return merged;
    }   
     
    global static SObject[] mergex(SObject[] array1, SObject[] array2){
    	if(array1 == null){ return array2; }
    	if(array2 == null){ return array1; }
    	if(array1.size() <= 0){ return array2; }
    	List<SObject> merged = createEmptySObjectList(array1[0]);
    	for(SObject sObj : array1){ merged.add(sObj); }
    	for(SObject sObj : array2){ merged.add(sObj); }
    	return merged;
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
	
    global static Boolean isNotEmpty(Object[] objectArray){
    	return !isEmpty(objectArray);
    }
	
    global static Boolean isNotEmpty(SObject[] objectArray){
    	return !isEmpty(objectArray);
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
    
    global static String toString(SObject[] objectArray){
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
    
    global static void assertArraysAreEqual(SObject[] expected, SObject[] actual){
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
    
	global static List<SObject> createEmptySObjectList(SObject prototype){
		if(prototype == null){
			return null;
		}
		return Database.query(
			'select Id from ' 
			+ StringUtils.split(''+prototype,':')[0] 
			+ ' where Id = \'0015000000Mrr40\' LIMIT 0'); // use dummy Id to ensure no return
	}
	
	//===============================================
	//LIST/ARRAY SORTING
	//===============================================
	global static void sortx(List<Object> theList, ObjectComparator comparator) {
		sortx(theList,comparator,true);
	}
	
	global static void sortx(List<Object> theList, ObjectComparator comparator, Boolean sortAsc) {
		sortRec(theList, 0, (theList == null ? 0 : theList.size()-1),comparator,sortAsc);
	}
	
	global static void sortx(List<IComparable> theList) {
		sortx(theList,true);
	}
	
	global static void sortx(List<IComparable> theList, Boolean sortAsc) {
		sortRec(theList, 0, (theList == null ? 0 : theList.size()-1),sortAsc);
	}
	
	global static void sortx(List<SObject> theList, SObjectComparator comparator) {
		sortx(theList,comparator,true);
	}
    
	global static void sortx(List<SObject> theList, SObjectComparator comparator,Boolean sortAsc ) {
		sortRec(theList,  0, (theList == null ? 0 : theList.size()-1),comparator,sortAsc);
	}
    
	private static void sortRec(List<IComparable> theList,  
								Integer lo0, 
								Integer hi0,
								Boolean sortAsc){
		Integer lo = lo0;
        Integer hi = hi0;
     
        if (lo >= hi) {
            return;
        } else if( lo == hi - 1 ) {
        
            if (( theList[lo].compareTo(theList[hi])>0 && sortAsc) || 
            	  (theList[lo].compareTo(theList[hi])<0 && !sortAsc)	
            	) {
                 IComparable prs = theList[lo];
                 theList[lo]         = theList[hi];
                 theList[hi]         = prs;
            }
            return;
        }

        IComparable pivot = theList[(lo + hi) / 2];
        theList[(lo + hi) / 2] = theList[hi];
        theList[hi] = pivot;

        while( lo < hi ) {
            while ((theList[lo].compareTo(pivot)<=0 && lo < hi && sortAsc) || 
            	   (theList[lo].compareTo(pivot)>=0 && lo < hi && !sortAsc)
            	  ) { lo++; }
            while (( pivot.compareTo(theList[hi])<=0 && lo < hi && sortAsc) ||
            	   ( pivot.compareTo(theList[hi]) >=0 && lo < hi && !sortAsc)
            	  ) { hi--; }
            
            if( lo < hi ){
                IComparable prs = theList[lo];
                 theList[lo]   = theList[hi];
                 theList[hi]    = prs;
            }
        }

        theList[hi0] = theList[hi];
        theList[hi] = pivot;
        
        sortRec(theList, lo0, lo-1,sortAsc);
        sortRec(theList, hi+1, hi0,sortAsc);
	}
    
	private static void sortRec(List<SObject> theList,
								Integer lo0, 
								Integer hi0, 
								SObjectComparator comparator,
								Boolean sortAsc){
		Integer lo = lo0;
        Integer hi = hi0;
     
        if (lo >= hi) {
            return;
        } else if( lo == hi - 1 ) {
        
            if (( comparator.compare(theList[lo],theList[hi])>0 && sortAsc) || 
            	  (comparator.compare(theList[lo],theList[hi])<0 && !sortAsc)	
            	) {
                 SObject prs = theList[lo];
                 theList[lo]         = theList[hi];
                 theList[hi]         = prs;
            }
            return;
        }

        SObject pivot = theList[(lo + hi) / 2];
        theList[(lo + hi) / 2] = theList[hi];
        theList[hi] = pivot;

        while( lo < hi ) {
            while ((comparator.compare(theList[lo], pivot)<=0 && lo < hi && sortAsc) || 
            	   (comparator.compare(theList[lo], pivot)>=0 && lo < hi && !sortAsc)
            	  ) { lo++; }
            while (( comparator.compare(pivot,theList[hi])<=0 && lo < hi && sortAsc) ||
            	   ( comparator.compare(pivot,theList[hi])>=0 && lo < hi && !sortAsc)
            	  ) { hi--; }
            
            if( lo < hi ){
                 SObject prs = theList[lo];
                 theList[lo]   = theList[hi];
                 theList[hi]    = prs;
            }
        }

        theList[hi0] = theList[hi];
        theList[hi] = pivot;
        
        sortRec(theList, lo0, lo-1,comparator,sortAsc);
        sortRec(theList, hi+1, hi0,comparator,sortAsc);
	}

	private static void sortRec(List<Object> theList,
								Integer lo0, 
								Integer hi0, 
								ObjectComparator comparator,
								Boolean sortAsc){
		Integer lo = lo0;
        Integer hi = hi0;
     
        if (lo >= hi) {
            return;
        } else if( lo == hi - 1 ) {
        
            if (( comparator.compare(theList[lo],theList[hi])>0 && sortAsc) || 
            	  (comparator.compare(theList[lo],theList[hi])<0 && !sortAsc)	
            	) {
                 Object prs = theList[lo];
                 theList[lo]         = theList[hi];
                 theList[hi]         = prs;
            }
            return;
        }

        Object pivot = theList[(lo + hi) / 2];
        theList[(lo + hi) / 2] = theList[hi];
        theList[hi] = pivot;

        while( lo < hi ) {
            while ((comparator.compare(theList[lo], pivot)<=0 && lo < hi && sortAsc) || 
            	   (comparator.compare(theList[lo], pivot)>=0 && lo < hi && !sortAsc)
            	  ) { lo++; }
            while (( comparator.compare(pivot,theList[hi])<=0 && lo < hi && sortAsc) ||
            	   ( comparator.compare(pivot,theList[hi])>=0 && lo < hi && !sortAsc)
            	  ) { hi--; }
            
            if( lo < hi ){
                 Object prs = theList[lo];
                 theList[lo]   = theList[hi];
                 theList[hi]    = prs;
            }
        }

        theList[hi0] = theList[hi];
        theList[hi] = pivot;
        
        sortRec(theList, lo0, lo-1,comparator,sortAsc);
        sortRec(theList, hi+1, hi0,comparator,sortAsc);
	}	
}