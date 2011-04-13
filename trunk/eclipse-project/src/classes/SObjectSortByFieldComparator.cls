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
global class SObjectSortByFieldComparator implements ISObjectComparator{

    //==================================================
    // PROPERTIES
    //==================================================
    private static final PrimitiveComparator primitiveComparator = new PrimitiveComparator();
    
    global String  sortBy        {get;set;}
    global Boolean sortAscending {get;set;}

    //==================================================
    // CONSTRUCTOR  
    //==================================================
    global SObjectSortByFieldComparator(
        String sortBy
    ){
        this(sortBy,null);
    }

    global SObjectSortByFieldComparator(
         String  sortBy
        ,Boolean sortAscending
    ){
        this.sortBy         = sortBy;
        this.sortAscending  = sortAscending;
    }

    //==================================================
    // METHODS
    //==================================================
    global Integer compare(SObject object1, SObject object2){
        if(object1==null && object2 == null){
            return 0;
        } else if(object1==null){
            return -1;
        } else if(object2==null){
            return 1;
        }
        if(StringUtils.isBlank(sortBy)) throw new IllegalStateException('sortBy cannot be blank');
        Integer returnValue = primitiveComparator.compare(
             object1.get(sortBy)
            ,object2.get(sortBy)
        );
        if(sortAscending != null && !sortAscending){
            if(returnValue == -1){
                returnValue = 1;
            } else if(returnValue == 1){
                returnValue = -1;
            }
        }
        return returnValue;
    }

    global static List<SObject> qsort(List<SObject> objects){
        return qsort(objects,null,null);           
    }

    global static List<SObject> qsort(List<SObject> objects, String sortBy){
        return qsort(objects,sortBy,null);           
    }

    global static List<SObject> qsort(List<SObject> objects, Boolean sortAscending){
        return qsort(objects,null,sortAscending);           
    }

    global static List<SObject> qsort(List<SObject> objects, String sortBy, Boolean sortAscending){
        if(StringUtils.isBlank(sortBy)) sortBy = 'name';
        if(sortAscending == null) sortAscending = true;
        return qsort(objects,new SObjectSortByFieldComparator(sortBy,sortAscending));           
    }

    global static List<SObject> qsort(List<SObject> objects, SObjectSortByFieldComparator comparator){
        return ArrayUtils.qsort(objects,comparator);
    }
}