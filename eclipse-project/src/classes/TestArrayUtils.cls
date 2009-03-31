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

    
}