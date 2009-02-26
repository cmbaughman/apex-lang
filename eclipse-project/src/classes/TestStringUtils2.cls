@IsTest
private class TestStringUtils2 {
    
     private static testmethod void testLeft(){
		//test: global static String left(String str, Integer len) {
		assertLeft(null, -1, null);
		assertLeft(null, 0, null);
		assertLeft('xyz', -1, '');
		assertLeft('', -1, '');
		assertLeft('', 0, '');
		assertLeft('abc', 0, '');
		assertLeft('abc', 2, 'ab');
		assertLeft('abc', 4, 'abc');
    }
    
    private static void assertLeft(String str, Integer len, String expected){
    	String actual = StringUtils.left(str,len);
    	System.assert(actual==expected, 'StringUtils.left(\'' + str + '\',' 
    		+ len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

	private static testmethod void testMid(){
		//test: global static String mid(String str, Integer pos, Integer len) {
		assertMid(null, 0, 0, null);
		assertMid('', 0, -1, '');
		assertMid('', 0, 0, '');
		assertMid('abc', 0, 2, 'ab');
		assertMid('abc', 0, 4, 'abc');
		assertMid('abc', 2, 4, 'c');
		assertMid('abc', 4, 2, '');
		assertMid('abc', -2, 2, 'ab');
		
    }

    private static void assertMid(String str, Integer pos, Integer len, String expected){
    	String actual = StringUtils.mid(str,pos,len);
    	System.assert(actual==expected, 'StringUtils.mid(\'' + str + '\',' + pos 
    		+ ',' + len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testOverlay(){
		//test: global static String overlay(String str, String overlay, Integer startIndex, Integer endIndex) {
		assertOverlay(null, null, 0, 0, null);
		assertOverlay('', 'abc', 0, 0, 'abc');
		assertOverlay('abcdef', null, 2, 4, 'abef');
		assertOverlay('abcdef', '', 2, 4, 'abef');
		assertOverlay('abcdef', '', 4, 2, 'abef');
		assertOverlay('abcdef', 'zzzz', 2, 4, 'abzzzzef');
		assertOverlay('abcdef', 'zzzz', 4, 2, 'abzzzzef');
		assertOverlay('abcdef', 'zzzz', -1, 4, 'zzzzef');
		assertOverlay('abcdef', 'zzzz', 2, 8, 'abzzzz');
		assertOverlay('abcdef', 'zzzz', -2, -3, 'zzzzabcdef');
		assertOverlay('abcdef', 'zzzz', 8, 10, 'abcdefzzzz');
		
    }

    private static void assertOverlay(String str, String overlay, Integer startIndex, Integer endIndex, String expected){
    	String actual = StringUtils.overlay(str,overlay,startIndex,endIndex);
    	System.assert(actual==expected, 'StringUtils.overlay(\'' + str + '\',\'' + overlay 
    		+ '\',' + startIndex + ',' + endIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }


}