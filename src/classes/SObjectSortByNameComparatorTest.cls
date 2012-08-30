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
@IsTest
private class SObjectSortByNameComparatorTest {

    private static testmethod void testCompareBadInput(){
        ISObjectComparator comparator = new SObjectSortByNameComparator();
        System.assertEquals(-1,comparator.compare(null,new Foo__c(name='test123'))); 
        System.assertEquals(0,comparator.compare(null,null)); 
        System.assertEquals(1,comparator.compare(new Foo__c(name='test123'),null)); 
    }
    
    private static testmethod void testCompareWithFoos(){
        Foo__c a1 = new Foo__c(name='abc');
        Foo__c a2 = new Foo__c(name='efg');
        ISObjectComparator comparator = new SObjectSortByNameComparator();
        System.assert(0 > comparator.compare(a1,a2)); 
        System.assert(0 == comparator.compare(a1,a1)); 
        System.assert(0 < comparator.compare(a2,a1)); 
    }
    
}