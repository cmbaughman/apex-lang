@IsTest
private class TestNumberUtils {
	
    private static testmethod void testMaxIntegerValue(){
    	System.assert(NumberUtils.MAX_INTEGER == 2147483647);
    }
    private static testmethod void testMinIntegerValue(){
    	System.assert(NumberUtils.MIN_INTEGER == -2147483647);
    }

}