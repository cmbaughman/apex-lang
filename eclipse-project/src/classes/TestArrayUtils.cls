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
	
	private static testmethod void testReverse(){
    	//test: global static Object[] reverse(Object[] anArray) 
		ArrayUtils.assertArraysAreEqual(null,ArrayUtils.reverse(null)); 
		ArrayUtils.assertArraysAreEqual(new String[]{},ArrayUtils.reverse(new String[]{}));
		ArrayUtils.assertArraysAreEqual(new String[]{'a'},ArrayUtils.reverse(new String[]{'a'}));
		ArrayUtils.assertArraysAreEqual(new String[]{'ab', 'c'},ArrayUtils.reverse(new String[]{'c','ab'}));
		ArrayUtils.assertArraysAreEqual(new String[]{'a', 'b', 'c'},ArrayUtils.reverse(new String[]{'c','b','a'}));
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

    
}