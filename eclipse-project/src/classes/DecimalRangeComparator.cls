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
global class DecimalRangeComparator implements ObjectComparator{

    global Integer compare(Object object1, Object object2){
        if(object1==null || !(object1 instanceof DecimalRange)
        || object2==null || !(object2 instanceof DecimalRange)){
            throw new IllegalArgumentException();
        }
        Decimal dr1 = ((DecimalRange) object1).min();
        Decimal dr2 = ((DecimalRange) object2).min();
        if(dr1 < dr2){
            return -1;
        } else if(dr1 == dr2){
            return 0;
        }else{
            return 1;
        }
    }

}