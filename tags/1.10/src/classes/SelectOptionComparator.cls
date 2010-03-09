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
global class SelectOptionComparator implements ObjectComparator{
	
	global Boolean sortDescending{get;set;}
	global Boolean sortAscending{get{return !sortDescending;}}
	global Boolean sortOnLabel{get;set;}
	global Boolean sortOnValue{get{return !sortOnLabel;}}
	
	global SelectOptionComparator(){
		this(true,true);
	}

	global SelectOptionComparator(Boolean sortDescending){
		this(sortDescending,true);
	}

	global SelectOptionComparator(Boolean sortDescending, Boolean sortOnLabel){
		this.sortDescending = sortDescending;
		this.sortOnLabel = sortOnLabel;
	}

	global Integer compare(Object object1, Object object2){
        if(object1==null){
            return sortDescending ? -1 : 1;
        } else if(object2==null){
            return sortDescending ? 1 : -1;
        }
		if(		!(object1 instanceof SelectOptionWrapper) 
        	|| 	!(object2 instanceof SelectOptionWrapper)){
        	throw new IllegalArgumentException('Invalid type');
        }
        SelectOption o1 = ((SelectOptionWrapper)object1).selectOption;
        SelectOption o2 = ((SelectOptionWrapper)object2).selectOption;
        String s1 = sortOnLabel ? o1.getLabel() : o1.getValue(); 
        String s2 = sortOnLabel ? o2.getLabel() : o2.getValue(); 
    	if(s1 < s2){ 
    		return sortDescending ? -1 : 1; 
    	} else if(s1 == s2){ 
    		return 0; 
    	} else { 
    		return sortDescending ? 1 : -1; 
    	} 
    }

	global static List<SelectOption> sort(List<SelectOption> theList){
		return sort(theList,true);
	}

	global static List<SelectOption> sort(List<SelectOption> theList, Boolean sortDescending){
		return sort(theList,sortDescending,true);
	}	
	
	global static List<SelectOption> sort(List<SelectOption> theList, Boolean sortDescending, Boolean sortOnLabel){
		if(theList != null && theList.size() > 0){
			//convert to wrapper list
			List<SelectOptionWrapper> wrapperList = new List<SelectOptionWrapper>();
			for(SelectOption option : theList){
				wrapperList.add(new SelectOptionWrapper(option));
			}
			//sort
			wrapperList = (List<SelectOptionWrapper>) ArrayUtils.qsort(wrapperList, new SelectOptionComparator(sortDescending,sortOnLabel));
			//convert back
			theList.clear();
			for(SelectOptionWrapper wrapper : wrapperList){
				theList.add(wrapper.selectOption);
			}
		}
		return theList;
	}
		
    
}