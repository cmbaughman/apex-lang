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
global class SObjectSortByNameComparator implements ISObjectComparator {
    
    global Integer compare(SObject record1, SObject record2){
        if(record1 == null || record1.get('Name') == null){
            if(record2 == null || record2.get('Name') == null){
                return 0;
            } else {
                return -1;
            }
        }
        if(record2 == null || record2.get('Name') == null){
            return 1;
        }
        return (''+record1.get('Name')).compareTo(''+record2.get('Name'));
    }
    
}