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