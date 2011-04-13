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
private class SObjectSortByFieldComparatorTest {

    private static testmethod void test_compare_throws_IllegalStateException(){
        Boolean exceptionCaught = false;
        try{
            new SObjectSortByFieldComparator(null)
                .compare(new Account(name='test123'),new Account(name='test123'));
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void test_compare_nulls(){
        final SObjectSortByFieldComparator comparator = new SObjectSortByFieldComparator('name');
        System.assertEquals(-1,comparator.compare(null,new Account(name='test123'))); 
        System.assertEquals(0,comparator.compare(null,null)); 
        System.assertEquals(1,comparator.compare(new Account(name='test123'),null)); 
    }
    
    private static testmethod void test_compare_integer_on_accounts(){
        Account a1 = new Account(name='abc',NumberOfEmployees=2);
        Account a2 = new Account(name='efg',NumberOfEmployees=1);
        final SObjectSortByFieldComparator comparator = new SObjectSortByFieldComparator('NumberOfEmployees');
        System.assertEquals(1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(-1,comparator.compare(a2,a1)); 

        comparator.sortAscending = false;
        System.assertEquals(-1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(1,comparator.compare(a2,a1)); 

        comparator.sortAscending = true;
        System.assertEquals(1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(-1,comparator.compare(a2,a1)); 

        comparator.sortAscending = null;
        System.assertEquals(1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(-1,comparator.compare(a2,a1)); 
    }
    
    private static testmethod void test_compare_string_on_accounts(){
        Account a1 = new Account(name='abc',NumberOfEmployees=2);
        Account a2 = new Account(name='efg',NumberOfEmployees=1);
        final SObjectSortByFieldComparator comparator = new SObjectSortByFieldComparator('name');
        System.assertEquals(-1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(1,comparator.compare(a2,a1)); 

        comparator.sortAscending = false;
        System.assertEquals(1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(-1,comparator.compare(a2,a1)); 

        comparator.sortAscending = true;
        System.assertEquals(-1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(1,comparator.compare(a2,a1)); 

        comparator.sortAscending = null;
        System.assertEquals(-1,comparator.compare(a1,a2)); 
        System.assertEquals(0,comparator.compare(a1,a1)); 
        System.assertEquals(1,comparator.compare(a2,a1)); 
    }
    

    
}