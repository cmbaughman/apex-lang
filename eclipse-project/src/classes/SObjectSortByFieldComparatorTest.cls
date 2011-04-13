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
    
    private static testmethod void test_qsort_ListSObject(){
        final List<SObject> unsorted = new List<SObject>{
             new Account(name='A',NumberOfEmployees=2)
            ,new Account(name='D',NumberOfEmployees=3)
            ,new Account(name='C',NumberOfEmployees=0)
            ,new Account(name='B',NumberOfEmployees=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted);
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals('A',sorted.get(0).get('name'));
        System.assertEquals('B',sorted.get(1).get('name'));
        System.assertEquals('C',sorted.get(2).get('name'));
        System.assertEquals('D',sorted.get(3).get('name'));
    }
    
    private static testmethod void test_qsort_ListSObject_Boolean(){
        final List<SObject> unsorted = new List<SObject>{
             new Account(name='A',NumberOfEmployees=2)
            ,new Account(name='D',NumberOfEmployees=3)
            ,new Account(name='C',NumberOfEmployees=0)
            ,new Account(name='B',NumberOfEmployees=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted,false);
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals('D',sorted.get(0).get('name'));
        System.assertEquals('C',sorted.get(1).get('name'));
        System.assertEquals('B',sorted.get(2).get('name'));
        System.assertEquals('A',sorted.get(3).get('name'));
    }

    private static testmethod void test_qsort_ListSObject_String(){
        final List<SObject> unsorted = new List<SObject>{
             new Account(name='A',NumberOfEmployees=2)
            ,new Account(name='D',NumberOfEmployees=3)
            ,new Account(name='C',NumberOfEmployees=0)
            ,new Account(name='B',NumberOfEmployees=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted,'NumberOfEmployees');
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals(0,sorted.get(0).get('NumberOfEmployees'));
        System.assertEquals(1,sorted.get(1).get('NumberOfEmployees'));
        System.assertEquals(2,sorted.get(2).get('NumberOfEmployees'));
        System.assertEquals(3,sorted.get(3).get('NumberOfEmployees'));
    }

    private static testmethod void test_qsort_ListSObject_String_Boolean(){
        final List<SObject> unsorted = new List<SObject>{
             new Account(name='A',NumberOfEmployees=2)
            ,new Account(name='D',NumberOfEmployees=3)
            ,new Account(name='C',NumberOfEmployees=0)
            ,new Account(name='B',NumberOfEmployees=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted,'NumberOfEmployees',false);
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals(3,sorted.get(0).get('NumberOfEmployees'));
        System.assertEquals(2,sorted.get(1).get('NumberOfEmployees'));
        System.assertEquals(1,sorted.get(2).get('NumberOfEmployees'));
        System.assertEquals(0,sorted.get(3).get('NumberOfEmployees'));
    }

}