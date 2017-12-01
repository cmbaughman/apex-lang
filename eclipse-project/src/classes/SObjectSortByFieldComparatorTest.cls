/* ============================================================
 * This code is part of the "apex-lang" open source project available at:
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
                .compare(new Foo__c(name='test123'),new Foo__c(name='test123'));
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void test_compare_nulls(){
        final SObjectSortByFieldComparator comparator = new SObjectSortByFieldComparator('name');
        System.assertEquals(-1,comparator.compare(null,new Foo__c(name='test123'))); 
        System.assertEquals(0,comparator.compare(null,null)); 
        System.assertEquals(1,comparator.compare(new Foo__c(name='test123'),null)); 
    }
    
    private static testmethod void test_compare_integer_on_Foos(){
        Foo__c a1 = new Foo__c(name='abc',NumberDecimal__c=2);
        Foo__c a2 = new Foo__c(name='efg',NumberDecimal__c=1);
        final SObjectSortByFieldComparator comparator = new SObjectSortByFieldComparator('NumberDecimal__c');
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
    
    private static testmethod void test_compare_string_on_Foos(){
        Foo__c a1 = new Foo__c(name='abc',NumberDecimal__c=2);
        Foo__c a2 = new Foo__c(name='efg',NumberDecimal__c=1);
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
             new Foo__c(name='A',NumberDecimal__c=2)
            ,new Foo__c(name='D',NumberDecimal__c=3)
            ,new Foo__c(name='C',NumberDecimal__c=0)
            ,new Foo__c(name='B',NumberDecimal__c=1)
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
             new Foo__c(name='A',NumberDecimal__c=2)
            ,new Foo__c(name='D',NumberDecimal__c=3)
            ,new Foo__c(name='C',NumberDecimal__c=0)
            ,new Foo__c(name='B',NumberDecimal__c=1)
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
             new Foo__c(name='A',NumberDecimal__c=2)
            ,new Foo__c(name='D',NumberDecimal__c=3)
            ,new Foo__c(name='C',NumberDecimal__c=0)
            ,new Foo__c(name='B',NumberDecimal__c=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted,'NumberDecimal__c');
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals(0,sorted.get(0).get('NumberDecimal__c'));
        System.assertEquals(1,sorted.get(1).get('NumberDecimal__c'));
        System.assertEquals(2,sorted.get(2).get('NumberDecimal__c'));
        System.assertEquals(3,sorted.get(3).get('NumberDecimal__c'));
    }

    private static testmethod void test_qsort_ListSObject_String_Boolean(){
        final List<SObject> unsorted = new List<SObject>{
             new Foo__c(name='A',NumberDecimal__c=2)
            ,new Foo__c(name='D',NumberDecimal__c=3)
            ,new Foo__c(name='C',NumberDecimal__c=0)
            ,new Foo__c(name='B',NumberDecimal__c=1)
        };
        final List<SObject> sorted = SObjectSortByFieldComparator.qsort(unsorted,'NumberDecimal__c',false);
        System.assertNotEquals(null,sorted);
        System.assertEquals(4,sorted.size());
        System.assertEquals(3,sorted.get(0).get('NumberDecimal__c'));
        System.assertEquals(2,sorted.get(1).get('NumberDecimal__c'));
        System.assertEquals(1,sorted.get(2).get('NumberDecimal__c'));
        System.assertEquals(0,sorted.get(3).get('NumberDecimal__c'));
    }
    
}