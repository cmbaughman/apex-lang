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
    
    private static testmethod void testRemove(){
    	//test: global static String remove(String str, String remove) {
		assertRemove(null, null, null);
		assertRemove('', null, '');
		assertRemove('xyz', null, 'xyz');
		assertRemove('xyz', '', 'xyz');
		assertRemove('queued', 'ue', 'qd');
		assertRemove('queued', 'zz', 'queued');
    	
    }

    private static void assertRemove(String str, String remove, String expected) {
    	String actual = StringUtils.remove(str,remove);
    	System.assert(actual==expected, 'StringUtils.remove(\'' + str + '\',\'' + remove 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStart(){
    	//test: global static String removeStart(String str, String remove) {
		assertRemoveStart(null, null, null);
		assertRemoveStart('', null, '');
		assertRemoveStart('xyz', null, 'xyz');
		assertRemoveStart('www.domain.com', 'www.', 'domain.com');
		assertRemoveStart('domain.com', 'www.', 'domain.com');
		assertRemoveStart('www.domain.com', 'domain', 'www.domain.com');
		assertRemoveStart('abc', '', 'abc');
    }

    private static void assertRemoveStart(String str, String remove, String expected) {
    	String actual = StringUtils.removeStart(str,remove);
    	System.assert(actual==expected, 'StringUtils.removeStart(\'' + str + '\',\'' + remove 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStartIgnoreCase(){
    	//test: global static String removeStartIgnoreCase(String str, String remove) {
		assertRemoveStartIgnoreCase(null, null, null);
		assertRemoveStartIgnoreCase('', null, '');
		assertRemoveStartIgnoreCase('xyz', null, 'xyz');
		assertRemoveStartIgnoreCase('www.domain.com', 'www.', 'domain.com');
		assertRemoveStartIgnoreCase('www.domain.com', 'WWW.', 'domain.com');
		assertRemoveStartIgnoreCase('domain.com', 'www.', 'domain.com');
		assertRemoveStartIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
		assertRemoveStartIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveStartIgnoreCase(String str, String remove, String expected) {
    	String actual = StringUtils.removeStartIgnoreCase(str,remove);
    	System.assert(actual==expected, 'StringUtils.removeStartIgnoreCase(\'' + str + '\',\'' + remove 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEnd(){
    	//test: global static String removeEnd(String str, String remove) {
		assertRemoveEnd(null, null, null);
		assertRemoveEnd('', null, '');
		assertRemoveEnd('xyz', null, 'xyz');
		assertRemoveEnd('www.domain.com', '.com.', 'www.domain.com');
		assertRemoveEnd('www.domain.com', '.com', 'www.domain');
		assertRemoveEnd('www.domain.com', 'domain', 'www.domain.com');
		assertRemoveEnd('abc', '', 'abc');
    }

    private static void assertRemoveEnd(String str, String remove, String expected) {
    	String actual = StringUtils.removeEnd(str,remove);
    	System.assert(actual==expected, 'StringUtils.removeEnd(\'' + str + '\',\'' + remove 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEndIgnoreCase(){
    	//test: global static String removeEndIgnoreCase(String str, String remove) {
		assertRemoveEndIgnoreCase(null, null, null);
		assertRemoveEndIgnoreCase('', null, '');
		assertRemoveEndIgnoreCase('xyz', null, 'xyz');
		assertRemoveEndIgnoreCase('www.domain.com', '.com.', 'www.domain.com');
		assertRemoveEndIgnoreCase('www.domain.com', '.com', 'www.domain');
		assertRemoveEndIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
		assertRemoveEndIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveEndIgnoreCase(String str, String remove, String expected) {
    	String actual = StringUtils.removeEndIgnoreCase(str,remove);
    	System.assert(actual==expected, 'StringUtils.removeEndIgnoreCase(\'' + str + '\',\'' + remove 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRegionMatchesCaseSensitive(){
	    //test: global static boolean regionMatches(String str, boolean ignoreCase,
		//			Integer toffset, String other, Integer ooffset, Integer len){
		assertRegionMatchesCaseSensitive(null, 0, null, 0, 0, true);
		assertRegionMatchesCaseSensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
		assertRegionMatchesCaseSensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, false);
    }

    private static void assertRegionMatchesCaseSensitive(String str, Integer toffset, 
    	String other, Integer ooffset, Integer len, Boolean expected) {
    	Boolean actual = StringUtils.regionMatches(str,toffset,other,ooffset,len);
    	System.assert(actual==expected, 'StringUtils.regionMatches(\'' 
    		+ str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
    		+ ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatchesCaseInsensitive(){
	    //test: global static boolean regionMatches(String str, boolean ignoreCase,
		//			Integer toffset, String other, Integer ooffset, Integer len){
		assertRegionMatchesCaseInsensitive(null, 0, null, 0, 0, true);
		assertRegionMatchesCaseInsensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
		assertRegionMatchesCaseInsensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, true);
    }

    private static void assertRegionMatchesCaseInsensitive(String str, Integer toffset, 
    	String other, Integer ooffset, Integer len, Boolean expected) {
    	Boolean actual = StringUtils.regionMatchesIgnoreCase(str,toffset,other,ooffset,len);
    	System.assert(actual==expected, 'StringUtils.regionMatchesIgnoreCase(\'' 
    		+ str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
    		+ ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatches(){
	    //test: global static boolean regionMatches(String str, boolean ignoreCase,
		//			Integer toffset, String other, Integer ooffset, Integer len){
		assertRegionMatches(null, false, 0, null, 0, 0, true);
		assertRegionMatches('aaaxyzaaa', false, 3, 'aaaaxyzaa', 4, 3, true);
		assertRegionMatches('aaaXYZaaa', false, 3, 'aaaaxyzaa', 4, 3, false);
		assertRegionMatches('aaaXYZaaa', true, 3, 'aaaaxyzaa', 4, 3, true);
		assertRegionMatches(
			'Java is a wonderful language',
		  // 0    5    10   15   20   25   
			false, 20, 
			'It is an object-oriented language', 25, 6, true);
		  // 0    5    10   15   20   25   30
    }

    private static void assertRegionMatches(String str, boolean ignoreCase, Integer toffset, 
    	String other, Integer ooffset, Integer len, Boolean expected) {
    	Boolean actual = StringUtils.regionMatches(str,ignoreCase,toffset,other,ooffset,len);
    	System.assert(actual==expected, 'StringUtils.regionMatches(\'' 
    		+ str + '\',' + ignoreCase + ',' + toffset + ',\'' 
    		+ other + '\',' + ooffset + ',' + len 
    		+ ') returned ' + actual + '; expected ' + expected );
    }

	private static testmethod void testReplaceThreeArgs(){
		//test: global static String replace(String text, String searchString, String replacement) {

		assertReplaceThreeArgs(null, null, null, null);
		assertReplaceThreeArgs('', null, null, '');
		assertReplaceThreeArgs('any', null, null, 'any');
		assertReplaceThreeArgs('any', null, null, 'any');
		assertReplaceThreeArgs('any', '', null, 'any');
		assertReplaceThreeArgs('aba', 'a', null, 'aba');
		assertReplaceThreeArgs('aba', 'a', '', 'b');
		assertReplaceThreeArgs('aba', 'a', 'z', 'zbz');
	}

	private static void assertReplaceThreeArgs(String text, String searchString, String replacement, String expected){
    	String actual = StringUtils.replace(text,searchString,replacement);
    	System.assert(actual==expected, 'StringUtils.replace(\'' + text + '\',\'' 
    		+ searchString + '\',\'' + replacement + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}

	private static testmethod void testReplaceFourArgs(){
		//test: global static String replace(String text, String searchString, String replacement, Integer max) {
		assertReplaceFourArgs(null, null, null, -1, null);
		assertReplaceFourArgs('', null, null, -1, '');
		assertReplaceFourArgs('any', null, null, -1, 'any');
		assertReplaceFourArgs('any', null, null, -1, 'any');
		assertReplaceFourArgs('any', '', null, -1, 'any');
		assertReplaceFourArgs('any', null, null, 0, 'any');
		assertReplaceFourArgs('abaa', 'a', null, -1, 'abaa');
		assertReplaceFourArgs('abaa', 'a', '', -1, 'b');
		assertReplaceFourArgs('abaa', 'a', 'z', 0, 'abaa');
		assertReplaceFourArgs('abaa', 'a', 'z', 1, 'zbaa');
		assertReplaceFourArgs('abaa', 'a', 'z', 2, 'zbza');
		assertReplaceFourArgs('abaa', 'a', 'z', -1, 'zbzz');
	}

	private static void assertReplaceFourArgs(String text, String searchString, String replacement, Integer max, String expected){
    	String actual = StringUtils.replace(text,searchString,replacement,max);
    	System.assert(actual==expected, 'StringUtils.replace(\'' + text + '\',\'' 
    		+ searchString + '\',\'' + replacement + '\',' + max + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}

	private static testmethod void testReplaceEachThreeArgs(){
		//test: global static String replaceEach(String text, String[] searchList, String[] replacementList) {
		assertReplaceEachThreeArgs(null, null, null, null);
		assertReplaceEachThreeArgs('', null, null, '');
		assertReplaceEachThreeArgs('aba', null, null, 'aba');
		assertReplaceEachThreeArgs('aba', new String[0], null, 'aba');
		assertReplaceEachThreeArgs('aba', null, new String[0], 'aba');
		assertReplaceEachThreeArgs('aba', new String[]{'a'}, null, 'aba');
		assertReplaceEachThreeArgs('aba', new String[]{'a'}, new String[]{''}, 'b');
		assertReplaceEachThreeArgs('aba', new String[]{null}, new String[]{'a'}, 'aba');
		assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, 'wcte');
		assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, 'dcte');
	}

	private static void assertReplaceEachThreeArgs(String text, String[] searchList, String[] replacementList, String expected){
    	String actual = StringUtils.replaceEach(text,searchList,replacementList);
    	System.assert(actual==expected, 'StringUtils.replaceEach(\'' + text + '\',' 
    		+ toString(searchList) + ',' + toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}

	private static testmethod void testReplaceEachRepeatedly(){
		//test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
		assertReplaceEachRepeatedly(null, null, null, false,null);
		assertReplaceEachRepeatedly('', null, null, false,'');
		assertReplaceEachRepeatedly('aba', null, null, false,'aba');
		assertReplaceEachRepeatedly('aba', new String[0], null, false,'aba');
		assertReplaceEachRepeatedly('aba', null, new String[0], false,'aba');
		assertReplaceEachRepeatedly('aba', new String[]{'a'}, null, false,'aba');
		assertReplaceEachRepeatedly('aba', new String[]{'a'}, new String[]{''}, false,'b');
		assertReplaceEachRepeatedly('aba', new String[]{null}, new String[]{'a'}, false,'aba');
		assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, false,'wcte');
		assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, false,'dcte');
		assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, true,'tcte');
		assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,'dcabe');
	}

	private static void assertReplaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat, String expected){
    	String actual = StringUtils.replaceEachRepeatedly(text,searchList,replacementList,repeat);
    	System.assert(actual==expected, 'StringUtils.replaceEachRepeatedly(\'' + text + '\',' 
    		+ toString(searchList) + ',' + toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	} 
 
	private static testmethod void testReplaceEachFiveArgExceptions(){
		//test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
		IllegalStateException illegalState = null;
		try{
			StringUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,-1);
		}catch(IllegalStateException e){
			illegalState = e;
		}
		System.assertNotEquals(null,illegalState);

		IllegalArgumentException illegalArgument = null;
		try{
			StringUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'ab'}, false,0);
		}catch(IllegalArgumentException e){
			illegalArgument = e;
		}
		System.assertNotEquals(null,illegalArgument);
	}

    private static testmethod void testStartsWith(){
    	//test:global static boolean startsWith(String str, String prefix) 
		assertStartsWith(null, null, true);
		assertStartsWith(null, 'abcdef', false);
		assertStartsWith('abc', null, false);
		assertStartsWith('abc', 'abcdef', false);
		assertStartsWith('abcdef', 'abc', true);
		assertStartsWith('ABCDEF', 'abc', false);
    }

    private static void assertStartsWith(String str, String prefix, Boolean expected) {
    	Boolean actual = StringUtils.startsWith(str,prefix);
    	System.assert(actual==expected, 'StringUtils.startsWith(\'' + str + '\',\'' + prefix 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testStartsWithIgnoreCase(){
    	//test:global static boolean startsWithIgnoreCase(String str, String prefix) 
		assertStartsWithIgnoreCase(null, null, true);
		assertStartsWithIgnoreCase(null, 'abcdef', false);
		assertStartsWithIgnoreCase('abc', null, false);
		assertStartsWithIgnoreCase('abcdef', 'abc', true);
		assertStartsWithIgnoreCase('ABCDEF', 'abc', true); 
    }

    private static void assertStartsWithIgnoreCase(String str, String prefix, Boolean expected) {
    	Boolean actual = StringUtils.startsWithIgnoreCase(str,prefix);
    	System.assert(actual==expected, 'StringUtils.startsWithIgnoreCase(\'' + str + '\',\'' + prefix 
    		+ '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static String toString(Object[] objectArray){
    	if(objectArray == null){
    		return '{}';	
    	}
    	String returnValue = '{';
        for(Integer i = 0; i < objectArray.size(); i++){
	    	if(i!=0){ returnValue += ','; }
	    	returnValue += '\'' + objectArray[i] + '\'';
        }
    	returnValue += '}';
    	return returnValue; 
    }
    

}