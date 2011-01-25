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
private class ArrayUtilsTest {

    private static testmethod void testObjectToString(){ 
        //test: global static List<String> objectToString(List<Object> objectList){ 
        assertObjectToString(null, null);
        assertObjectToString(new List<Object>{}, new List<String>{});
        final String str1 = 'xyz';
        final String str2 = 'abc';
        assertObjectToString(new List<Object>{str1}, new List<String>{str1});
        assertObjectToString(new List<Object>{str1,str2}, new List<String>{str1,str2});
    }
    
    private static void assertObjectToString(List<Object> objectList, List<String> expected){
    	ArrayUtils.assertArraysAreEqual(expected, ArrayUtils.objectToString(objectList));
    }

    private static testmethod void testLowerCase(){
        //test:  global static List<String> lowerCase(List<String> strs)
        ArrayUtils.assertArraysAreEqual(null,ArrayUtils.lowerCase(null)); 
        ArrayUtils.assertArraysAreEqual(new String[]{null},ArrayUtils.lowerCase(new String[]{null})); 
        ArrayUtils.assertArraysAreEqual(new String[]{' '},ArrayUtils.lowerCase(new String[]{' '})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'abc','xyz'},ArrayUtils.lowerCase(new String[]{'abc','xyz'})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'abc','xyz'},ArrayUtils.lowerCase(new String[]{'Abc','xYz'})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'abc','xyz'},ArrayUtils.lowerCase(new String[]{'ABC','XYZ'})); 
    }

    private static testmethod void testUpperCase(){
        //test:  global static List<String> upperCase(List<String> strs)
        ArrayUtils.assertArraysAreEqual(null,ArrayUtils.lowerCase(null)); 
        ArrayUtils.assertArraysAreEqual(new String[]{null},ArrayUtils.upperCase(new String[]{null})); 
        ArrayUtils.assertArraysAreEqual(new String[]{' '},ArrayUtils.upperCase(new String[]{' '})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'ABC','XYZ'},ArrayUtils.upperCase(new String[]{'abc','xyz'})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'ABC','XYZ'},ArrayUtils.upperCase(new String[]{'Abc','xYz'})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'ABC','XYZ'},ArrayUtils.upperCase(new String[]{'ABC','XYZ'})); 
    }
    
    private static testmethod void testTrim(){
        //test:  global static List<String> trim(List<String> strs)
        ArrayUtils.assertArraysAreEqual(null,ArrayUtils.trim(null)); 
        ArrayUtils.assertArraysAreEqual(new String[]{null},ArrayUtils.trim(new String[]{null})); 
        ArrayUtils.assertArraysAreEqual(new String[]{''},ArrayUtils.trim(new String[]{' \n\t '})); 
    }

    private static testmethod void testReverseObject(){
        //test: global static Object[] reverse(Object[] anArray) 
        Object[] nullArray = null;
        ArrayUtils.assertArraysAreEqual(null,ArrayUtils.reverse(nullArray)); 
        ArrayUtils.assertArraysAreEqual(new String[]{},ArrayUtils.reverse(new String[]{}));
        ArrayUtils.assertArraysAreEqual(new String[]{'a'},ArrayUtils.reverse(new String[]{'a'}));
        ArrayUtils.assertArraysAreEqual(new String[]{'ab', 'c'},ArrayUtils.reverse(new String[]{'c','ab'}));
        ArrayUtils.assertArraysAreEqual(new String[]{'a', 'b', 'c'},ArrayUtils.reverse(new String[]{'c','b','a'}));
    }

    private static testmethod void testReverseSObject(){
        //test: global static SObject[] reverse(SObject[] anArray) 
        SObject[] nullArray = null;
        Account x = new Account(name='x');
        Account y = new Account(name='y');
        Account z = new Account(name='z');
        ArrayUtils.assertArraysAreEqual(null,ArrayUtils.reverse(nullArray)); 
        ArrayUtils.assertArraysAreEqual(new Account[]{},ArrayUtils.reverse(new Account[]{}));
        ArrayUtils.assertArraysAreEqual(new Account[]{x},ArrayUtils.reverse(new Account[]{x}));
        ArrayUtils.assertArraysAreEqual(new Account[]{x,y},ArrayUtils.reverse(new Account[]{y, x}));
        ArrayUtils.assertArraysAreEqual(new Account[]{x,y,z},ArrayUtils.reverse(new Account[]{z,y,x}));
    }

    private static testmethod void testIsEmpty(){
        //test: global static Boolean isEmpty(Object[] objectArray){
        String[] aNull = null;
        Account[] aNull2 = null;
        DecimalRange[] aNull3 = null;
        System.assertEquals(true,    ArrayUtils.isEmpty(aNull)); 
        System.assertEquals(true,    ArrayUtils.isEmpty(new String[]{})); 
        System.assertEquals(false,    ArrayUtils.isEmpty(new String[]{'a'})); 
        System.assertEquals(false,    ArrayUtils.isEmpty(new String[]{'a','b'})); 
        System.assertEquals(true,    ArrayUtils.isEmpty(new Integer[]{})); 
        System.assertEquals(false,    ArrayUtils.isEmpty(new Integer[]{1})); 
        System.assertEquals(false,    ArrayUtils.isEmpty(new Integer[]{1,2})); 
        System.assertEquals(true,    ArrayUtils.isEmpty(aNull2)); 
        System.assertEquals(true,    ArrayUtils.isEmpty(new Account[]{}));  
        System.assertEquals(false,    ArrayUtils.isEmpty(new Account[]{new Account(name='test')}));  
        System.assertEquals(true,    ArrayUtils.isEmpty(new Contact[]{}));  
        System.assertEquals(false,    ArrayUtils.isEmpty(new Contact[]{new Contact(lastname='test')}));  
        System.assertEquals(true,    ArrayUtils.isEmpty(aNull3)); 
        System.assertEquals(true,    ArrayUtils.isEmpty(new DecimalRange[]{}));  
        System.assertEquals(false,    ArrayUtils.isEmpty(new DecimalRange[]{new DecimalRange(1,1)}));  
    }
    
    private static testmethod void testIsNotEmpty(){
        //test: global static Boolean isNotEmpty(Object[] objectArray){
        String[] aNull = null;
        Account[] aNull2 = null;
        DecimalRange[] aNull3 = null;
        System.assertEquals(false,    ArrayUtils.isNotEmpty(aNull)); 
        System.assertEquals(false,    ArrayUtils.isNotEmpty(new String[]{})); 
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new String[]{'a'})); 
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new String[]{'a','b'})); 
        System.assertEquals(false,    ArrayUtils.isNotEmpty(new Integer[]{})); 
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new Integer[]{1})); 
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new Integer[]{1,2})); 
        System.assertEquals(false,    ArrayUtils.isNotEmpty(aNull2)); 
        System.assertEquals(false,    ArrayUtils.isNotEmpty(new Account[]{}));  
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new Account[]{new Account(name='test')}));  
        System.assertEquals(false,    ArrayUtils.isNotEmpty(new Contact[]{}));  
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new Contact[]{new Contact(lastname='test')}));  
        System.assertEquals(false,    ArrayUtils.isNotEmpty(aNull3)); 
        System.assertEquals(false,    ArrayUtils.isNotEmpty(new DecimalRange[]{}));  
        System.assertEquals(true,    ArrayUtils.isNotEmpty(new DecimalRange[]{new DecimalRange(1,1)}));  
    }
    
    private static testmethod void testPluck(){
        //test: global static Object[] pluck(SObject[] objectArray, String fieldName)
        assertPluck(null,'name',new Object[]{});
        assertPluck(new Account[]{new Account(name='abc123'),new Account(name='xyz456')},null,new Object[]{});
        assertPluck(new Account[]{new Account(name='abc123'),new Account(name='xyz456')},'name',
            new String[]{'abc123','xyz456'});
    }    
    
    private static void assertPluck(SObject[] objectArray, String fieldName, Object[] expected){
        Object[] actual = ArrayUtils.pluck(objectArray, fieldName);
        ArrayUtils.assertArraysAreEqual(expected, actual);    
    }

    private static testmethod void testMergeObjectArrays(){
        //test: global static Object[] mergex(Object[] array1, Object[] array2)
        Object[] nullArray = null;
        System.assertEquals(null,ArrayUtils.mergex(nullArray,nullArray));
        ArrayUtils.assertArraysAreEqual(new Object[]{},ArrayUtils.mergex(new Object[]{},nullArray));
        ArrayUtils.assertArraysAreEqual(new Object[]{},ArrayUtils.mergex(nullArray,new Object[]{}));
        Object x = 'x';
        Object y = 'y';
        Object z = 'z';
        Object ten = 10;
        ArrayUtils.assertArraysAreEqual(new Object[]{x,y,z,ten},ArrayUtils.mergex(new Object[]{x,y},new Object[]{z,ten}));
    }    
    
    private static testmethod void testMergeSObjectArrays(){
        //test: global static SObject[] mergex(SObject[] array1, SObject[] array2)
        SObject[] nullArray = null;
        System.assertEquals(null,ArrayUtils.mergex(nullArray,nullArray));
        ArrayUtils.assertArraysAreEqual(new Account[]{},ArrayUtils.mergex(new Account[]{},nullArray));
        ArrayUtils.assertArraysAreEqual(new Contact[]{},ArrayUtils.mergex(nullArray,new Contact[]{}));
        ArrayUtils.assertArraysAreEqual(new Account[]{},ArrayUtils.mergex(new Account[]{},new Account[]{}));
        Account x = new Account(name='x');
        Account y = new Account(name='y');
        Account z = new Account(name='z');
        Account ten = new Account(name='10');
        ArrayUtils.assertArraysAreEqual(new Account[]{x,y,z,ten},ArrayUtils.mergex(new Account[]{x,y},new Account[]{z,ten}));
    }    
    
    private static testmethod void testCreateEmptySObjectList(){
        //test: global static List<SObject> createEmptySObjectList(SObject prototype)
        System.assertEquals(null,ArrayUtils.createEmptySObjectList(null));
        ArrayUtils.assertArraysAreEqual(new Account[]{},ArrayUtils.createEmptySObjectList(new Account()));
    }

    
    
    private static testmethod void testQSortSObjects(){
        List<Account> listToSort = new Account[]{new Account(name='test9'),
                                                 new Account(name='test5'),
                                                 new Account(name='test3'),
                                                 new Account(name='test7'),
                                                 new Account(name='test8'),
                                                 new Account(name='test1'),
                                                 new Account(name='test2')};
                                                    
        ArrayUtils.qsort(listToSort, new SObjectSortByNameComparator());
        System.assertNotEquals(null, listToSort);
        System.assertEquals(7, listToSort.size());
        System.assertEquals('test1', listToSort[0].Name);
        System.assertEquals('test2', listToSort[1].Name);
        System.assertEquals('test3', listToSort[2].Name); 
        
    }
    private static testmethod void testQSortForceDotComPrimitives(){
        List<Double> listToSort = new Double[]{4,1.22,-5.4,1.22,3.2};
        ArrayUtils.qsort(listToSort);
        System.assertNotEquals(null, listToSort);
        System.assertEquals(5, listToSort.size());

        System.assertEquals(-5.4,     listToSort[0]);
        System.assertEquals(1.22,     listToSort[1]);
        System.assertEquals(1.22,    listToSort[2]);
        System.assertEquals(3.2,     listToSort[3]);
        System.assertEquals(4,         listToSort[4]);

        ArrayUtils.qsort(listToSort, false);
        System.assertNotEquals(null, listToSort);
        System.assertEquals(5, listToSort.size());

        System.assertEquals(4,         listToSort[0]);
        System.assertEquals(3.2,     listToSort[1]);
        System.assertEquals(1.22,     listToSort[2]);
        System.assertEquals(1.22,    listToSort[3]);
        System.assertEquals(-5.4,     listToSort[4]);
    }  
    
    private static testmethod void testQSortCustomClasses(){
        DecimalRange r1 = new DecimalRange(-10,10);
        DecimalRange r2 = new DecimalRange(1,2);
        DecimalRange r3 = new DecimalRange(1.3,10);
        DecimalRange r4 = new DecimalRange(1.5,1.7);
        DecimalRange r5 = new DecimalRange(10,10);
        DecimalRange r6 = new DecimalRange(12,15);
        List<DecimalRange> listToSort = new DecimalRange[]{r4,r5,r1,r2,r3,r6};
        
        ArrayUtils.qsort(listToSort,new DecimalRangeComparator());
        System.assertNotEquals(null, listToSort);
        System.assertEquals(6, listToSort.size());
        System.assertEquals(r1.min(), listToSort.get(0).min());
        System.assertEquals(r2.min(), listToSort.get(1).min());
        System.assertEquals(r3.min(), listToSort.get(2).min());
    }  

    private static testmethod void testToString(){
        List<Object> aList = null;
        ArrayUtils.toString(aList);
        aList = new DecimalRange[]{};
        ArrayUtils.toString(aList);
        aList = new DecimalRange[]{new DecimalRange(12,15),new DecimalRange(12,15)};
        ArrayUtils.toString(aList);
    }

    private static testmethod void testMergeForceDotComPrimitives(){
        List<Object> l1 = new List<Object>();
        for(Integer i = 0; i < ArrayUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(i);
        }
        Boolean exceptionThrown = false;
        try{
            ArrayUtils.merg(l1, new Integer[]{1});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);

        Double[] d1 = new Double[]{1,2,3};
        Double[] d2 = new Double[]{4,5,6};
        List<Object> merged = ArrayUtils.merg(d1, d2);
        System.assertNotEquals(null,merged);
        System.assertEquals(6,merged.size());
        System.assertEquals(1,merged.get(0));
        System.assertEquals(4,merged.get(3));
    }
    
    private static testmethod void testSubsetCustomClasses(){
        Object[] iobjs = new DecimalRange[]{
            new DecimalRange(1,1),new DecimalRange(2,2),new DecimalRange(3,3)};
        List<Object> returned = ArrayUtils.subset(iobjs, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(1,((DecimalRange)returned.get(0)).min());
        System.assertEquals(2,((DecimalRange)returned.get(1)).min());
        
    }

    private static testmethod void testMergeCustomClasses(){
        List<Object> l1 = new List<Object>();
        for(Integer i = 0; i < ArrayUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(new DecimalRange(i,i));
        }
        Boolean exceptionThrown = false;
        try{
            ArrayUtils.merg(l1, new DecimalRange[]{new DecimalRange(1,1)});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);

        DecimalRange[] d1 = new DecimalRange[]{new DecimalRange(1,1),new DecimalRange(2,2)};
        DecimalRange[] d2 = new DecimalRange[]{new DecimalRange(3,3),new DecimalRange(4,4)};
        List<Object> merged = ArrayUtils.merg(d1, d2);
        System.assertNotEquals(null,merged);
        System.assertEquals(4,merged.size());
        System.assertEquals(1,((DecimalRange)merged.get(0)).min());
        System.assertEquals(3,((DecimalRange)merged.get(2)).min());
    }
    
    private static testmethod void testSubsetSObjects(){
        SObject[] sobjs = new Contact[]{
            new Contact(lastname='1'),
            new Contact(lastname='2'),
            new Contact(lastname='3')};
        List<SObject> returned = ArrayUtils.subset(sobjs, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals('1',((Contact)returned.get(0)).lastname);
        System.assertEquals('2',((Contact)returned.get(1)).lastname);
    }

    private static testmethod void testMergeSObjects(){
        List<SObject> l1 = new List<Contact>();
        for(Integer i = 0; i < ArrayUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(new Contact());
        }
        Boolean exceptionThrown = false;
        try{
            ArrayUtils.merg(l1, new Contact[]{new Contact()});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);
        l1 = null;
        List<SObject> merged = ArrayUtils.merg(l1,l1);
        System.assertEquals(null,merged);
        
        Contact[] c1 = new Contact[]{new Contact(lastname='1'),new Contact(lastname='2')};
        merged = ArrayUtils.merg(l1,c1);
        Contact[] c2 = new Contact[]{new Contact(lastname='3'),new Contact(lastname='4')};
        merged = ArrayUtils.merg(c1, c2);
        System.assertNotEquals(null,merged);
        System.assertEquals(4,merged.size());
        System.assertEquals('1',((Contact)merged.get(0)).lastname);
        System.assertEquals('2',((Contact)merged.get(1)).lastname);
        System.assertEquals('3',((Contact)merged.get(2)).lastname);
        System.assertEquals('4',((Contact)merged.get(3)).lastname);
    }
    
    private static testmethod void testSubsetForceDotComPrimitives(){
        Double[] prim = new Double[]{1,2,3};
        List<Object> returned = ArrayUtils.subset(prim, 3);
        System.assertNotEquals(null,returned);
        System.assertEquals(3,returned.size());
        System.assertEquals(1,returned.get(0));
        System.assertEquals(2,returned.get(1));
        System.assertEquals(3,returned.get(2));

        returned = ArrayUtils.subset(prim, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(1,returned.get(0));
        System.assertEquals(2,returned.get(1));

        returned = ArrayUtils.subset(prim, 1);
        System.assertNotEquals(null,returned);
        System.assertEquals(1,returned.size());
        System.assertEquals(1,returned.get(0));

        returned = ArrayUtils.subset(prim,1,3);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(2,returned.get(0));
        System.assertEquals(3,returned.get(1));

        returned = ArrayUtils.subset(prim,-1,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());

        returned = ArrayUtils.subset(prim,10,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());

        returned = ArrayUtils.subset(prim,0,20);
        System.assertNotEquals(null,returned);
        System.assertEquals(3,returned.size());

        prim = null;
        returned = ArrayUtils.subset(prim,0,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());


            //subset({1,2,3},0,3)={1,2,3}
    //subset({1,2,3},1,3)={2,3}
    //subset({1,2,3},2,3)={3}
    //subset({1,2,3},3,3)={}
    //subset({1,2,3},0,2)={1,2}
    //subset({1,2,3},1,2)={2,3}
    //subset({1,2,3},2,2)={3}
        
    }
        
}