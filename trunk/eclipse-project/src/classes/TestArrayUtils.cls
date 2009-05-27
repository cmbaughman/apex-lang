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
private class TestArrayUtils {
	
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
		System.assertEquals(true,	ArrayUtils.isEmpty(aNull)); 
		System.assertEquals(true,	ArrayUtils.isEmpty(new String[]{})); 
		System.assertEquals(false,	ArrayUtils.isEmpty(new String[]{'a'})); 
		System.assertEquals(false,	ArrayUtils.isEmpty(new String[]{'a','b'})); 
		System.assertEquals(true,	ArrayUtils.isEmpty(new Integer[]{})); 
		System.assertEquals(false,	ArrayUtils.isEmpty(new Integer[]{1})); 
		System.assertEquals(false,	ArrayUtils.isEmpty(new Integer[]{1,2})); 
		System.assertEquals(true,	ArrayUtils.isEmpty(aNull2)); 
		System.assertEquals(true,	ArrayUtils.isEmpty(new Account[]{}));  
		System.assertEquals(false,	ArrayUtils.isEmpty(new Account[]{new Account(name='test')}));  
		System.assertEquals(true,	ArrayUtils.isEmpty(new Contact[]{}));  
		System.assertEquals(false,	ArrayUtils.isEmpty(new Contact[]{new Contact(lastname='test')}));  
    }
    
	private static testmethod void testIsNotEmpty(){
    	//test: global static Boolean isNotEmpty(Object[] objectArray){
    	String[] aNull = null;
    	Account[] aNull2 = null;
		System.assertEquals(false,	ArrayUtils.isNotEmpty(aNull)); 
		System.assertEquals(false,	ArrayUtils.isNotEmpty(new String[]{})); 
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new String[]{'a'})); 
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new String[]{'a','b'})); 
		System.assertEquals(false,	ArrayUtils.isNotEmpty(new Integer[]{})); 
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new Integer[]{1})); 
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new Integer[]{1,2})); 
		System.assertEquals(false,	ArrayUtils.isNotEmpty(aNull2)); 
		System.assertEquals(false,	ArrayUtils.isNotEmpty(new Account[]{}));  
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new Account[]{new Account(name='test')}));  
		System.assertEquals(false,	ArrayUtils.isNotEmpty(new Contact[]{}));  
		System.assertEquals(true,	ArrayUtils.isNotEmpty(new Contact[]{new Contact(lastname='test')}));  
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

	
	private static testmethod void testSortCustomObject(){
		List<IComparableTestClass> listToSort = new IComparableTestClass[]
													{new IComparableTestClass(5),
													 new IComparableTestClass(4),
													 new IComparableTestClass(6),
													 new IComparableTestClass(8),
													 new IComparableTestClass(1),
													 new IComparableTestClass(3)};
													
		ArrayUtils.sortx(listToSort);
		System.assertNotEquals(null, listToSort);
		System.assertEquals(6, listToSort.size());
		System.assertEquals(1, listToSort[0].attribute);
		System.assertEquals(3, listToSort[1].attribute);
		System.assertEquals(4, listToSort[2].attribute);
				
		
	}  
	
	private static testmethod void testSortStandardObject(){
		List<Double> listToSort = new Double[]{4,1.22,-5.4,1.22,3.2};
		ArrayUtils.sortx(listToSort, new PrimitiveComparator());
		System.assertNotEquals(null, listToSort);
		System.assertEquals(5, listToSort.size());

		System.assertEquals(-5.4, 	listToSort[0]);
		System.assertEquals(1.22, 	listToSort[1]);
		System.assertEquals(1.22,	listToSort[2]);
		System.assertEquals(3.2, 	listToSort[3]);
		System.assertEquals(4, 		listToSort[4]);

		ArrayUtils.sortx(listToSort, new PrimitiveComparator(), false);
		System.assertNotEquals(null, listToSort);
		System.assertEquals(5, listToSort.size());

		System.assertEquals(4, 		listToSort[0]);
		System.assertEquals(3.2, 	listToSort[1]);
		System.assertEquals(1.22, 	listToSort[2]);
		System.assertEquals(1.22,	listToSort[3]);
		System.assertEquals(-5.4, 	listToSort[4]);
	}  
	
	private static testmethod void testSortSObject(){
		List<Account> listToSort = new Account[]{new Account(name='test9'),
												 new Account(name='test5'),
												 new Account(name='test3'),
												 new Account(name='test7'),
												 new Account(name='test8'),
												 new Account(name='test1'),
												 new Account(name='test2')};
													
		ArrayUtils.sortx(listToSort, new SObjectComparatorTestClass());
		System.assertNotEquals(null, listToSort);
		System.assertEquals(7, listToSort.size());
		System.assertEquals('test1', listToSort[0].Name);
		System.assertEquals('test2', listToSort[1].Name);
		System.assertEquals('test3', listToSort[2].Name); 
		
	}    
}