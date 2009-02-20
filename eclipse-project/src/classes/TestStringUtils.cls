@IsTest
private class TestStringUtils {

    private static testmethod void testAbbreviateTwoArgs(){
		assertAbbreviateTwoArgs(null, 		-1, null, 		false);
		assertAbbreviateTwoArgs('', 		4, 	'',			false);
		assertAbbreviateTwoArgs('abcdefg', 	6, 	'abc...',	false);
		assertAbbreviateTwoArgs('abcdefg', 	7, 	'abcdefg',	false);
		assertAbbreviateTwoArgs('abcdefg', 	8, 	'abcdefg', 	false);
		assertAbbreviateTwoArgs('abcdefg', 	4, 	'a...', 	false);
		assertAbbreviateTwoArgs('abcdefg', 	3, 	null, 		true);
    }    
    
    private static void assertAbbreviateTwoArgs(String str, Integer maxWidth, 
    	String expected, Boolean excepExpected){

    	String actual = null;
    	Boolean excepActual = false;
    	try{
    		actual = StringUtils.abbreviate(str,maxWidth);
    	} catch (IllegalArgumentException e){
    		excepActual = true;
    	}
    	if(excepExpected && excepActual){
    		return;
    	}
    	System.assert(excepExpected == excepActual, 'StringUtils.abbreviate(\'' 
    		+ str + '\',' + maxWidth + ') ' 
    		+ (excepExpected ? 'did not throw' : 'unexpectedly threw') 
    		+ ' IllegalArgumentException');
    	if(!excepExpected && !excepActual){
	    	System.assert(actual==expected, 'StringUtils.abbreviate(\'' + str + '\',' 
	    		+ maxWidth + ') returned ' + actual + '; expected ' + expected);
    	}
    }
    
    private static testmethod void testAbbreviateThreeArgs(){
		assertAbbreviateThreeArgs(null, 				-1,	-1, 	null, 			false);
		assertAbbreviateThreeArgs('', 					0, 	4, 		'',				false);
		assertAbbreviateThreeArgs('abcdefghijklmno',	-1, 10, 	'abcdefg...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	0, 	10, 	'abcdefg...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	1, 	10, 	'abcdefg...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	4, 	10, 	'abcdefg...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	5, 	10, 	'...fghi...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	6, 	10, 	'...ghij...',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	8, 	10, 	'...ijklmno',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	10, 10, 	'...ijklmno',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	12, 10, 	'...ijklmno',	false);
		assertAbbreviateThreeArgs('abcdefghijklmno', 	20, 10, 	'...ijklmno',	false);
		assertAbbreviateThreeArgs('abcdefghij', 		0, 	3,		null,			true);
		assertAbbreviateThreeArgs('abcdefghij', 		5, 	6,		null,			true);
    }    
    
    private static void assertAbbreviateThreeArgs(String str, Integer offset, Integer maxWidth, 
    	String expected, Boolean excepExpected){

    	String actual = null;
    	Boolean excepActual = false;
    	try{
    		actual = StringUtils.abbreviate(str,offset,maxWidth);
    	} catch (IllegalArgumentException e){
    		excepActual = true;
    	}
    	if(excepExpected && excepActual){
    		return;
    	}
    	System.assert(excepExpected == excepActual, 'StringUtils.abbreviate(\'' 
    		+ str + '\',' + offset + ',' + maxWidth + ') ' 
    		+ (excepExpected ? 'did not throw' : 'unexpectedly threw') 
    		+ ' IllegalArgumentException');
    	if(!excepExpected && !excepActual){
	    	System.assert(actual==expected, 'StringUtils.abbreviate(\'' + str + '\',' 
	    		+ offset + ',' + maxWidth + ') returned ' + actual + '; expected ' + expected);
    	}
    }
 
    private static testmethod void testIndexOfAny(){
		//test: global static int indexOfAny(String str, String searchChars) {
		assertIndexOfAny(null, null, -1);
		assertIndexOfAny('', null, -1);
		assertIndexOfAny(null, '', -1);
		assertIndexOfAny('zzabyycdxx', 'za', 0);
		assertIndexOfAny('zzabyycdxx', 'by', 3);
		assertIndexOfAny('aba','z', -1);
    }    
    
    private static void assertIndexOfAny(String str, String searchChars, Integer expected){
    	Integer actual = StringUtils.indexOfAny(str,searchChars);
    	System.assert(actual==expected, 'StringUtils.indexOfAny(\'' + str + '\',' 
    		+ searchChars + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testIndexOfAnyStringArray(){
		//test: global static Integer indexOfAny(String str, String[] searchStrs) {
		assertIndexOfAnyStringArray(null, null, -1);
		assertIndexOfAnyStringArray(null, new String[]{}, -1);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{null}, -1);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'ab','cd'}, 2);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'cd','ab'}, 2);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'mn','op'}, -1);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'zab','aby'}, 1);
		assertIndexOfAnyStringArray('zzabyycdxx', new String[]{''}, 0);
		assertIndexOfAnyStringArray('', new String[]{''}, 0);
		assertIndexOfAnyStringArray('', new String[]{'a'}, -1);
    }    
    
    private static void assertIndexOfAnyStringArray(String str, String[] searchStrs, Integer expected){
    	Integer actual = StringUtils.indexOfAny(str,searchStrs);
    	System.assert(actual==expected, 'StringUtils.indexOfAny(\'' + str + '\',' 
    		+ toString(searchStrs) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testCenterTwoArgs(){
		assertCenterTwoArgs(null, 	-1,	null);
		assertCenterTwoArgs('', 	4,	'    ');
		assertCenterTwoArgs('ab', 	-1,	'ab');
		assertCenterTwoArgs('ab', 	4,	' ab ');
		assertCenterTwoArgs('abcd', 2,	'abcd');
		assertCenterTwoArgs('a', 	4,	' a  ');
    }    
    
    private static void assertCenterTwoArgs(String str, Integer size, String expected){
    	String actual = StringUtils.center(str,size);
    	System.assert(actual==expected, 'StringUtils.center(\'' + str + '\',' 
    		+ size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChompOneArg(){
		assertChompOneArg(null,				null);
		assertChompOneArg('',				'');
		assertChompOneArg('abc \r',			'abc ');
		assertChompOneArg('abc\n',			'abc');
		assertChompOneArg('abc\r\n',		'abc');
		assertChompOneArg('abc\r\n\r\n',	'abc\r\n');
		assertChompOneArg('abc\n\r',		'abc\n');
		assertChompOneArg('abc\n\rabc',		'abc\n\rabc');
		assertChompOneArg('\t',				'\t');
		assertChompOneArg('\r',				'');
		assertChompOneArg('\n',				'');
		assertChompOneArg('\r\n',			'');
    }    
    
    private static void assertChompOneArg(String str, String expected){
    	String actual = StringUtils.chomp(str);
    	System.assert(actual==expected, 'StringUtils.chomp(\'' + str + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChompTwoArgs(){
		assertChompTwoArgs(null, 		null, 		null);
		assertChompTwoArgs('', 			null, 		'');
		assertChompTwoArgs('foobar', 	'bar', 		'foo');
		assertChompTwoArgs('foobar', 	'baz', 		'foobar');
		assertChompTwoArgs('foo',		'foo', 		'');
		assertChompTwoArgs('foo ', 		'foo', 		'foo ');
		assertChompTwoArgs(' foo', 		'foo', 		' ');
		assertChompTwoArgs('foo', 		'foooo', 	'foo');
		assertChompTwoArgs('foo', 		'', 		'foo');
		assertChompTwoArgs('foo', 		null, 		'foo');
    }    
    
    private static void assertChompTwoArgs(String str, String separator, String expected){
    	String actual = StringUtils.chomp(str,separator);
    	System.assert(actual==expected, 'StringUtils.chomp(\'' + str + '\', \'' + separator + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    
    
    private static testmethod void testCenterThreeArgs(){
		assertCenterThreeArgs(null, 	-1, null, 	null);
		assertCenterThreeArgs('', 		4, 	' ',	 '    ');
		assertCenterThreeArgs('ab', 	-1, ' ', 	'ab');
		assertCenterThreeArgs('ab', 	4, 	' ', 	' ab ');
		assertCenterThreeArgs('abcd', 	2, 	' ', 	'abcd');
		assertCenterThreeArgs('a', 		4, 	' ', 	' a  ');
		assertCenterThreeArgs('a', 		4, 	'yz', 	'yayz');
		assertCenterThreeArgs('abc', 	7, 	null, 	'  abc  ');
		assertCenterThreeArgs('abc', 	7, 	'', 	'  abc  ');
    }    
    
    private static void assertCenterThreeArgs(String str, Integer size, String padStr, String expected){
    	String actual = StringUtils.center(str,size, padStr);
    	System.assert(actual==expected, 'StringUtils.center(\'' + str + '\',' 
    		+ size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChop(){
		assertChop(null,		null);
		assertChop('', 			'');
		assertChop('abc \r', 	'abc ');
		assertChop('abc\n', 	'abc');
		assertChop('abc\r\n', 	'abc');
		assertChop('abc', 		'ab');
		assertChop('abc\nabc', 	'abc\nab');
		assertChop('a', 		'');
		assertChop('\r', 		'');
		assertChop('\n', 		'');
		assertChop('\r\n', 		'');
    }    
    
    private static void assertChop(String str, String expected){
    	String actual = StringUtils.chop(str);
    	System.assert(actual==expected, 'StringUtils.chop(\'' + str + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testContainsAny(){
		assertContainsAny(null, 		null, 	false);
		assertContainsAny('', 			null, 	false);
		assertContainsAny(null, 		null, 	false);
		assertContainsAny(null, 		'', 	false);
		assertContainsAny('zzabyycdxx', 'za', 	true);
		assertContainsAny('zzabyycdxx', 'by', 	true);
		assertContainsAny('aba',		'z', 	false);
    }    
    
    private static void assertContainsAny(String str, String searchChars, Boolean expected){
    	Boolean actual = StringUtils.containsAny(str,searchChars);
    	System.assert(actual==expected, 'StringUtils.containsAny(\'' + str + '\',\'' + searchChars + '\') returned ' 
    		+ actual);
    }
    
    
    private static testmethod void testContainsNone(){
		//test: global static boolean containsNone(String str, String invalidChars) {
		assertContainsNone(null, 	null, 	true);
		assertContainsNone(null, 	null, 	true);
		assertContainsNone('', 		null, 	true);
		assertContainsNone('ab', 	'', 	true);
		assertContainsNone('abab', 	'xyz', 	true);
		assertContainsNone('ab1', 	'xyz', 	true);
		assertContainsNone('abz', 	'xyz', 	false);
    }    
    
    private static void assertContainsNone(String str, String invalidChars, Boolean expected){
    	Boolean actual = StringUtils.containsNone(str,invalidChars);
    	System.assert(actual==expected, 'StringUtils.containsNone(\'' + str + '\',\'' + invalidChars + '\') returned ' 
    		+ actual);
    }
    
    private static testmethod void testContainsOnly(){
	    //test: global static boolean containsOnly(String str, String valid) {
		assertContainsOnly(null, 	null,	false);
		assertContainsOnly(null, 	null,	false);
		assertContainsOnly('', 		null,	false);
		assertContainsOnly('', 		'',		true);
		assertContainsOnly('ab', 	'',		false);
		assertContainsOnly('abab', 	'abc',	true);
		assertContainsOnly('ab1', 	'abc',	false);
		assertContainsOnly('abz', 	'abc', 	false);
    }    
    
    private static void assertContainsOnly(String str, String valid, Boolean expected){
    	Boolean actual = StringUtils.containsOnly(str,valid);
    	System.assert(actual==expected, 'StringUtils.containsOnly(\'' + str + '\',\'' + valid + '\') returned ' 
    		+ actual);
    }
    
    private static testmethod void testCountMatches(){
		//test: global static Integer countMatches(String str, String sub) {
		assertCountMatches(null, null, 0);
		assertCountMatches('', null, 0);
		assertCountMatches('abba', null, 0);
		assertCountMatches('abba', '', 0);
		assertCountMatches('abba', 'a', 2);
		assertCountMatches('abba', 'ab', 1);
		assertCountMatches('abba', 'xxx', 0);
    }    
    
    private static void assertCountMatches(String str, String sub, Integer expected){
    	Integer actual = StringUtils.countMatches(str,sub);
    	System.assert(actual==expected, 'StringUtils.countMatches(\'' + str + '\',\'' + sub + '\') returned ' 
    		+ actual + '; expected ' + expected);
    }

    private static testmethod void testDefaultIfEmpty(){
		//test: global static String defaultIfEmpty(String str, String defaultStr) {
		assertDefaultIfEmpty(null, 'NULL', 'NULL');
		assertDefaultIfEmpty('', 'NULL', 'NULL');
		assertDefaultIfEmpty('bat', 'NULL', 'bat');
    }    
    
    private static void assertDefaultIfEmpty(String str, String defaultStr, String expected){
    	String actual = StringUtils.defaultIfEmpty(str,defaultStr);
    	System.assert(actual==expected, 'StringUtils.defaultIfEmpty(\'' + str + '\',\'' + defaultStr + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testDefaultStringOneArg(){
		//test: global static String defaultString(String str) {
		assertDefaultStringOneArg(null, '');
		assertDefaultStringOneArg('', '');
		assertDefaultStringOneArg('bat', 'bat');
    }    
    
    private static void assertDefaultStringOneArg(String str, String expected){
    	String actual = StringUtils.defaultString(str);
    	System.assert(actual==expected, 'StringUtils.defaultString(\'' + str + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testDefaultStringTwoArgs(){
		//test: global static String defaultString(String str, String defaultStr) {
		assertDefaultStringTwoArgs(null, 'NULL', 'NULL');
		assertDefaultStringTwoArgs('', 'NULL', '');
		assertDefaultStringTwoArgs('bat', 'NULL', 'bat');
    }    
    
    private static void assertDefaultStringTwoArgs(String str, String defaultStr, String expected){
    	String actual = StringUtils.defaultString(str,defaultStr);
    	System.assert(actual==expected, 'StringUtils.defaultString(\'' + str + '\',\'' + defaultStr + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }
    

    private static testmethod void testDeleteWhitespace(){
		//test: global static String deleteWhitespace(String str) {
		assertDeleteWhitespace(null, 			null);
		assertDeleteWhitespace('', 				'');
		assertDeleteWhitespace('abc', 			'abc');
		assertDeleteWhitespace('   ab  c  ', 	'abc');
    }    
    
    private static void assertDeleteWhitespace(String str, String expected){
    	String actual = StringUtils.deleteWhitespace(str);
    	System.assert(actual==expected, 'StringUtils.deleteWhitespace(\'' + str + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testDifference(){
    	//test: global static String difference(String str1, String str2) {
		assertDifference(null, 		null, 		null);
		assertDifference('', 		null, 		'');
		assertDifference('', 		'', 		'');
		assertDifference('', 		'abc', 		'abc');
		assertDifference('abc', 	'', 		'');
		assertDifference('abc', 	'abc', 		'');
		assertDifference('ab', 		'abxyz', 	'xyz');
		assertDifference('abcde', 	'abxyz',	'xyz');
		assertDifference('abcde', 	'xyz', 		'xyz');
    }    
    
    private static void assertDifference(String str1, String str2, String expected){
    	String actual = StringUtils.difference(str1,str2);
    	System.assert(actual==expected, 'StringUtils.difference(\'' + str1 + '\',\'' + str2 + '\') returned \'' 
    		+ actual + '\'; expected \'' + expected + '\'');
    }



    private static testmethod void testEquals(){
    	//test: global static Boolean equals(String str1, String str2) {
		assertEquals(null, 	null, 	true);
		assertEquals(null, 	'abc', 	false);
		assertEquals('abc', null, 	false);
		assertEquals('abc', 'abc', 	true);
		assertEquals('abc', 'ABC', 	false);
    }    
    
    private static void assertEquals(String str1, String str2, Boolean expected){
    	Boolean actual = StringUtils.equals(str1,str2); 
    	System.assert(actual==expected, 'StringUtils.equals(\'' + str1 + '\',\'' + str2 + '\') returned ' + actual);
    }

    private static testmethod void testEqualsIgnoreCase(){
    	//test: global static Boolean equalsIgnoreCase(String str1, String str2) {
		assertEqualsIgnoreCase(null, 	null, 	true);
		assertEqualsIgnoreCase(null, 	'abc', 	false);
		assertEqualsIgnoreCase('abc', 	null, 	false);
		assertEqualsIgnoreCase('abc', 	'abc', 	true);
		assertEqualsIgnoreCase('abc', 	'ABC', 	true);
    }    
    
    private static void assertEqualsIgnoreCase(String str1, String str2, Boolean expected){
    	Boolean actual = StringUtils.equalsIgnoreCase(str1,str2);
    	System.assert(actual==expected, 'StringUtils.equalsIgnoreCase(\'' + str1 + '\',\'' + str2 + '\') returned ' + actual);
    }

    private static testmethod void testIndexOf(){
    	//test: global static Integer indexOf(String str, String searchStr) {
		assertIndexOf(null, 		null, 	-1);
		assertIndexOf('', 			null, 	-1);
		assertIndexOf('aabaabaa', 	'a', 	0);
		assertIndexOf('aabaabaa', 	'b',	2);
     }    
    
    private static void assertIndexOf(String str1, String searchStr, Integer expected){
    	Integer actual = StringUtils.indexOf(str1,searchStr);
    	System.assert(actual==expected, 'StringUtils.indexOf(\'' + str1 + '\',\'' + searchStr + '\') returned ' 
    		+ actual + '; expected ' + expected);
    }

    private static testmethod void testIndexOfDifference(){
		//test: global static Integer indexOfDifference(String str1, String str2) {
		assertIndexOfDifference(null, 		null, 		-1);
		assertIndexOfDifference(null, 		'', 		0);
		assertIndexOfDifference('', 		null, 		0);
		assertIndexOfDifference('', 		'', 		-1);
		assertIndexOfDifference('', 		'abc', 		0);
		assertIndexOfDifference('abc', 		'', 		0);
		assertIndexOfDifference('abc', 		'abc', 		-1);
		assertIndexOfDifference('ab', 		'abxyz', 	2);
		assertIndexOfDifference('abcde', 	'abxyz', 	2);
		assertIndexOfDifference('abcde', 	'xyz', 		0);
    }    
    
    private static void assertIndexOfDifference(String str1, String str2, Integer expected){
    	Integer actual = StringUtils.indexOfDifference(str1,str2);
    	System.assert(actual==expected, 'StringUtils.indexOfDifference(\'' + str1 + '\',\'' + str2 + '\') returned ' 
    		+ actual + '; expected ' + expected);
    }
    
    private static testmethod void testIndexOfAnyBut(){
	    //test: global static int indexOfAnyBut(String str, String searchChars) {
		assertIndexOfAnyBut(null, 			null,	-1);
		assertIndexOfAnyBut('', 			null,	-1);
		assertIndexOfAnyBut(null, 			null,	-1);
		assertIndexOfAnyBut(null, 			'',		-1);
		assertIndexOfAnyBut('zzabyycdxx', 	'za',	3);
		assertIndexOfAnyBut('zzabyycdxx', 	'',		0);
		assertIndexOfAnyBut('aba',			'ab',	-1);
    }    
    
    private static void assertIndexOfAnyBut(String str, String searchChars, Integer expected){
    	Integer actual = StringUtils.indexOfAnyBut(str,searchChars);
    	System.assert(actual==expected, 'StringUtils.indexOfAnyBut(\'' + str + '\',\'' + searchChars + '\') returned ' 
    		+ actual + '; expected ' + expected);
    }
    
    private static testmethod void testLowerCase(){
    	assertLowerCase(null, null);
    	assertLowerCase('ABC', 'abc');
    	assertLowerCase('abc', 'abc');
    	assertLowerCase('aBc', 'abc');
    }    
    
    private static void assertLowerCase(String str, String expected){
    	String actual = StringUtils.lowerCase(str);
    	System.assert(actual==expected, 'StringUtils.lowerCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testUpperCase(){
    	assertUpperCase(null, null);
    	assertUpperCase('ABC', 'ABC');
    	assertUpperCase('abc', 'ABC');
    	assertUpperCase('aBc', 'ABC');
    }    
    
    private static void assertUpperCase(String str, String expected){
    	String actual = StringUtils.upperCase(str);
    	System.assert(actual==expected, 'StringUtils.upperCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testCapitalize(){
    	assertCapitalize(null, null);
    	assertCapitalize('ABC', 'ABC');
    	assertCapitalize('abc', 'Abc');
    	assertCapitalize('aBc', 'ABc');
    }    
    
    private static void assertCapitalize(String str, String expected){
    	String actual = StringUtils.capitalize(str);
    	System.assert(actual==expected, 'StringUtils.capitalize(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testUncapitalize(){
    	assertUncapitalize(null, null);
    	assertUncapitalize('ABC', 'aBC');
    	assertUncapitalize('abc', 'abc');
    	assertUncapitalize('aBc', 'aBc');
    }    
    
    private static void assertUncapitalize(String str, String expected){
    	String actual = StringUtils.uncapitalize(str);
    	System.assert(actual==expected, 'StringUtils.uncapitalize(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testSwapCase(){
    	assertSwapCase(null, null);
    	assertSwapCase('', '');
    	assertSwapCase('The dog has a BONE', 'tHE DOG HAS A bone');
    }    
    
    private static void assertSwapCase(String str, String expected){
    	String actual = StringUtils.swapCase(str);
    	System.assert(actual==expected, 'StringUtils.swapCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testIsEmpty(){
		assertIsEmpty(null, 	true);
		assertIsEmpty('',		true);
		assertIsEmpty(' ',		false);
		assertIsEmpty('bob',	false);
		assertIsEmpty('  bob  ',false);
    }    
    
    private static void assertIsEmpty(String str, Boolean expected){
    	Boolean actual = StringUtils.IsEmpty(str);
    	System.assert(actual==expected, 'StringUtils.IsEmpty(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testIsNotEmpty(){
		assertIsNotEmpty(null, 		false);
		assertIsNotEmpty('',		false);
		assertIsNotEmpty(' ',		true);
		assertIsNotEmpty('bob',		true);
		assertIsNotEmpty('  bob  ',	true);
    }    
    
    private static void assertIsNotEmpty(String str, Boolean expected){
    	Boolean actual = StringUtils.IsNotEmpty(str);
    	System.assert(actual==expected, 'StringUtils.IsNotEmpty(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsAlpha(){
    	//test: global static boolean isAlpha(String str) {
		assertIsAlpha(null, false);
		assertIsAlpha('', true);
		assertIsAlpha('  ', false);
		assertIsAlpha('abc', true);
		assertIsAlpha('ab2c', false);
		assertIsAlpha('ab-c', false);
	}

    private static void assertIsAlpha(String str, Boolean expected){
    	Boolean actual = StringUtils.isAlpha(str);
    	System.assert(actual==expected, 'StringUtils.isAlpha(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsAlphaSpace(){
    	//test: global static boolean isAlphaSpace(String str) {
		assertIsAlphaSpace(null, false);
		assertIsAlphaSpace('', true);
		assertIsAlphaSpace('  ', true);
		assertIsAlphaSpace('abc', true);
		assertIsAlphaSpace('ab c', true);
		assertIsAlphaSpace('ab2c', false);
		assertIsAlphaSpace('ab-c', false);
	}

    private static void assertIsAlphaSpace(String str, Boolean expected){
    	Boolean actual = StringUtils.isAlphaSpace(str);
    	System.assert(actual==expected, 'StringUtils.isAlphaSpace(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsAlphanumeric(){
    	//test: global static boolean isAlphanumeric(String str) {
		assertIsAlphanumeric(null, false);
		assertIsAlphanumeric('', true);
		assertIsAlphanumeric('  ', false);
		assertIsAlphanumeric('abc', true);
		assertIsAlphanumeric('ab c', false);
		assertIsAlphanumeric('ab2c', true);
		assertIsAlphanumeric('ab-c', false);
	}

    private static void assertIsAlphanumeric(String str, Boolean expected){
    	Boolean actual = StringUtils.isAlphanumeric(str);
    	System.assert(actual==expected, 'StringUtils.isAlphanumeric(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsAlphanumericSpace(){
    	//test: global static boolean isAlphanumericSpace(String str) {
		assertIsAlphanumericSpace(null, false);
		assertIsAlphanumericSpace('', true);
		assertIsAlphanumericSpace('  ', true);
		assertIsAlphanumericSpace('abc', true);
		assertIsAlphanumericSpace('ab c', true);
		assertIsAlphanumericSpace('ab2c', true);
		assertIsAlphanumericSpace('ab-c', false);
	}

    private static void assertIsAlphanumericSpace(String str, Boolean expected){
    	Boolean actual = StringUtils.isAlphanumericSpace(str);
    	System.assert(actual==expected, 'StringUtils.isAlphanumericSpace(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsAsciiPrintable(){
    	//test: global static boolean isAsciiPrintable(String str) {
		assertIsAsciiPrintable(null, false);
		assertIsAsciiPrintable('', true);
		assertIsAsciiPrintable(' ', true);
		assertIsAsciiPrintable('Ceki', true);
		assertIsAsciiPrintable('ab2c', true);
		assertIsAsciiPrintable('!ab-c~', true);
		assertIsAsciiPrintable(' ', true);
		assertIsAsciiPrintable('!', true);
		assertIsAsciiPrintable('~', true);
		assertIsAsciiPrintable('', false);
		assertIsAsciiPrintable('Ceki Gülcü', false);
	}

    private static void assertIsAsciiPrintable(String str, Boolean expected){
    	Boolean actual = StringUtils.isAsciiPrintable(str);
    	System.assert(actual==expected, 'StringUtils.isAsciiPrintable(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsNumeric(){
    	//test: global static boolean isNumeric(String str) {
		assertIsNumeric(null, false);
		assertIsNumeric('', true);
		assertIsNumeric('  ', false);
		assertIsNumeric('123', true);
		assertIsNumeric('12 3', false);
		assertIsNumeric('ab2c', false);
		assertIsNumeric('12-3', false);
		assertIsNumeric('12.3', false);
	}

    private static void assertIsNumeric(String str, Boolean expected){
    	Boolean actual = StringUtils.isNumeric(str);
    	System.assert(actual==expected, 'StringUtils.isNumeric(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsNumericSpace(){
    	//test: global static boolean isNumericSpace(String str) {
		assertIsNumericSpace(null, false);
		assertIsNumericSpace('', true);
		assertIsNumericSpace('  ', true);
		assertIsNumericSpace('123', true);
		assertIsNumericSpace('12 3', true);
		assertIsNumericSpace('ab2c', false);
		assertIsNumericSpace('12-3', false);
		assertIsNumericSpace('12.3', false);
	}

    private static void assertIsNumericSpace(String str, Boolean expected){
    	Boolean actual = StringUtils.isNumericSpace(str);
    	System.assert(actual==expected, 'StringUtils.isNumericSpace(\'' + str + '\') returned ' + actual);
    }

	private static testmethod void testIsWhitespace(){
    	//test: global static boolean isWhitespace(String str) {
		assertIsWhitespace(null, false);
		assertIsWhitespace('', true);
		assertIsWhitespace('  ', true);
		assertIsWhitespace('abc', false);
		assertIsWhitespace('ab2c', false);
		assertIsWhitespace('ab-c', false);
	}

    private static void assertIsWhitespace(String str, Boolean expected){
    	Boolean actual = StringUtils.isWhitespace(str);
    	System.assert(actual==expected, 'StringUtils.isWhitespace(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testLength(){
		assertLength(null, 		0);
		assertLength('',		0);
		assertLength(' ',		1);
		assertLength('bob',		3);
		assertLength('  bob  ',	7);
    }    
    
    private static void assertLength(String str, Integer expected){
    	Integer actual = StringUtils.length(str);
    	System.assert(actual==expected, 'StringUtils.length(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsBlank(){
    	assertOnIsBlank(true, null);
    	assertOnIsBlank(true, '');
    	assertOnIsBlank(true, '     ');
    	assertOnIsBlank(true, '\n');
    	assertOnIsBlank(false, 'x');
    	assertOnIsBlank(false, ' x');
    	assertOnIsBlank(false, 'asdfasdfasdf ');
    }
    
    private static void assertOnIsBlank(Boolean expectedReturnValue, String theString){
    	System.assert(StringUtils.isBlank(theString)==expectedReturnValue,
    		'StringUtils.isBlank(\'' + (theString == null ? 'null' : theString) + '\') returned ' + !expectedReturnValue);
    }

    private static testmethod void testIsNotBlank(){
    	assertOnIsNotBlank(false, null);
    	assertOnIsNotBlank(false, '');
    	assertOnIsNotBlank(false, '     ');
    	assertOnIsNotBlank(false, '\n');
    	assertOnIsNotBlank(true, 'x');
    	assertOnIsNotBlank(true, ' x');
    	assertOnIsNotBlank(true, 'asdfasdfasdf ');
    }
    
    private static void assertOnIsNotBlank(Boolean expectedReturnValue, String theString){
    	System.assert(StringUtils.isNotBlank(theString)==expectedReturnValue,
    		'StringUtils.isNotBlank(\'' + (theString == null ? 'null' : theString) + '\') returned ' + !expectedReturnValue);
    }
    
    private static testmethod void testTrim(){
    	assertTrim(null, null);
    	assertTrim('', '');
    	assertTrim('a', 'a');
    	assertTrim('\n', '');
    	assertTrim('   ', '');
    }
    
    private static void assertTrim(String str, String expected){
    	String actual = StringUtils.trim(str);
    	System.assert(actual==expected, 'StringUtils.trim(\'' + str + '\') returned [' + actual + '], expected [' + expected + ']');
    }
     
    
    
    private static testmethod void testJoinStrings(){
    	assertJoinStrings(null, null, null);
    	assertJoinStrings(new Set<String>(), ':', null);
    	assertJoinStrings(new Set<String>{'a','b','c'}, ':', 'a:c:b');
    	assertJoinStrings(new Set<String>{' ','b','c'}, ':', 'c:b');
    }

    private static void assertJoinStrings(Set<String> strings, String separator, String expectedReturnValue){
    	String actual = StringUtils.joinStrings(strings,separator);
    	if(strings == null || strings.size() <= 0){
        	System.assert(StringUtils.isBlank(expectedReturnValue), 'StringUtils.joinStrings(Set<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + actual);
    		return;
    	}
    	Set<String> actualAsSet = new Set<String>(StringUtils.split(actual,separator));
    	Set<String> expectedAsSet = new Set<String>(StringUtils.split(expectedReturnValue,separator));
    	System.debug('actualAsSet.containsAll(expectedAsSet): ' + actualAsSet.containsAll(expectedAsSet));
    	System.debug('expectedAsSet.containsAll(actualAsSet): ' + expectedAsSet.containsAll(actualAsSet));
    	System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet),
    		'StringUtils.joinStrings(Set<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + 
    			actual + '; expected: ' + expectedReturnValue);
    }
    
    private static testmethod void testJoinStringsList(){
    	assertJoinStringsList(null, null, null);
    	assertJoinStringsList(new List<String>(), ':', null);
    	assertJoinStringsList(new List<String>{'a','b','c'}, ':', 'a:c:b');
    	assertJoinStringsList(new List<String>{' ','b','c'}, ':', 'c:b');
    }

    private static void assertJoinStringsList(List<String> strings, String separator, String expectedReturnValue){
    	String actual = StringUtils.joinStrings(strings,separator);
    	if(strings == null || strings.size() <= 0){
        	System.assert(StringUtils.isBlank(expectedReturnValue), 'StringUtils.joinStrings(List<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + actual);
    		return;
    	}
    	Set<String> actualAsSet = new Set<String>(StringUtils.split(actual,separator));
    	Set<String> expectedAsSet = new Set<String>(StringUtils.split(expectedReturnValue,separator));
    	System.debug('actualAsSet.containsAll(expectedAsSet): ' + actualAsSet.containsAll(expectedAsSet));
    	System.debug('expectedAsSet.containsAll(actualAsSet): ' + expectedAsSet.containsAll(actualAsSet));
    	System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet),
    		'StringUtils.joinStrings(List<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + 
    			actual + '; expected: ' + expectedReturnValue);
    }
    
    private static testmethod void testEndsWith(){
		assertEndsWith(null, null, true);
        assertEndsWith('abcdef', null, false);
        assertEndsWith(null, 'def', false);
        assertEndsWith('abcdef', 'def', true);
        assertEndsWith('ABCDEF', 'def', false);
    }

    private static testmethod void testEndsWithIgnoreCase(){
		assertEndsWithIgnoreCase(null, null, true);
		assertEndsWithIgnoreCase('abcdef', null, false);
		assertEndsWithIgnoreCase(null, 'def', false);
		assertEndsWithIgnoreCase('abcdef', 'def', true);
		assertEndsWithIgnoreCase('ABCDEF', 'def', true);
		assertEndsWithIgnoreCase('ABCDEF', 'ABCDEFA', false);
    }    
    
    private static void assertEndsWith(String str, String suffix, Boolean expected){
        Boolean actual = StringUtils.endsWith(str,suffix);
        System.assert(actual==expected, 'StringUtils.endsWith(\'' + str + '\',\'' + suffix + '\') returned ' + actual);
    }
    
    private static void assertEndsWithIgnoreCase(String str, String suffix, Boolean expected){
        Boolean actual = StringUtils.endsWithIgnoreCase(str,suffix);
        System.assert(actual==expected, 'StringUtils.endsWithIgnoreCase(\'' + str + '\',\'' + suffix + '\') returned ' + actual);
    }

    private static testmethod void testContains(){
		assertContains(null, null, false);
		assertContains('abcdef', null, false);
		assertContains(null, 'def', false);
		assertContains('abcdef', 'ab', true);
		assertContains('abcdef', 'xab', false);
		assertContains('ABCDEF', 'AB', true);
		assertContains('ABCDEF', 'Ab', false);

		assertContains('abcdef', 'ef', true);
		assertContains('abcdef', 'xef', false);
		assertContains('ABCDEF', 'EF', true);
		assertContains('ABCDEF', 'Ef', false);

		assertContains('abcdef', 'cde', true);
		assertContains('abcdef', 'xcde', false);
		assertContains('ABCDEF', 'CDE', true);
		assertContains('ABCDEF', 'CDe', false);
    }    
    
    private static void assertContains(String str, String searchStr, Boolean expected){
        Boolean actual = StringUtils.contains(str,searchStr);
        System.assert(actual==expected, 'StringUtils.contains(\'' + str + '\',\'' + searchStr + '\') returned ' + actual);
    }
    
    private static testmethod void testContainsIgnoreCase(){
		assertContainsIgnoreCase(null, null, false);
		assertContainsIgnoreCase('abcdef', null, false);
		assertContainsIgnoreCase(null, 'def', false);
		assertContainsIgnoreCase('abcdef', 'ab', true);
		assertContainsIgnoreCase('abcdef', 'xab', false);
		assertContainsIgnoreCase('ABCDEF', 'AB', true);
		assertContainsIgnoreCase('ABCDEF', 'Ab', true);
    }    
    
    private static void assertContainsIgnoreCase(String str, String searchStr, Boolean expected){
        Boolean actual = StringUtils.containsIgnoreCase(str,searchStr);
        System.assert(actual==expected, 'StringUtils.containsIgnoreCase(\'' + str + '\',\'' + searchStr + '\') returned ' + actual);
    }

    private static testmethod void testSplitOneArg(){
		assertSplitOneArg(null, 		null);
		assertSplitOneArg('', 			new String[]{''});
		assertSplitOneArg('abc def', 	new String[]{'abc','def'});
		assertSplitOneArg('abc  def', 	new String[]{'abc','def'});
		assertSplitOneArg(' abc ', 		new String[]{'abc'});
    }    
    
    private static void assertSplitOneArg(String str, String[] expected){
        String[] actual = StringUtils.split(str);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.split(\'' + str + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.split(\'' + str + '\') returned ' + toString(actual));
        }
    }
    
    private static testmethod void testSplitOneArgPreserveAllTokens(){
		assertSplitOneArgPreserveAllTokens(null, 		null);
		assertSplitOneArgPreserveAllTokens('', 			new String[]{''});
		assertSplitOneArgPreserveAllTokens('abc def', 	new String[]{'abc','def'});
		assertSplitOneArgPreserveAllTokens('abc  def', 	new String[]{'abc','','def'});
		assertSplitOneArgPreserveAllTokens(' abc ', 	new String[]{'','abc',''});
		assertSplitOneArgPreserveAllTokens('a b c', 	new String[]{'a','b','c'});
    }    
    
    private static void assertSplitOneArgPreserveAllTokens(String str, String[] expected){
        String[] actual = StringUtils.splitPreserveAllTokens(str);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitPreserveAllTokens(\'' + str + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitPreserveAllTokens(\'' + str + '\') returned ' + toString(actual));
        }
    }

    private static testmethod void testCharAt(){
		assertCharAt(null, -1, null);
		assertCharAt(null, 0, null);
		assertCharAt('abc', -1, null);
		assertCharAt('abc', 3, null);
		assertCharAt('abc', 0, 'a');
		assertCharAt('abc', 2, 'c');
		assertCharAt('abcde', -2, null);
		assertCharAt('abcde', 0, 'a');
		assertCharAt('abcde', 1, 'b');
		assertCharAt('abcde', 4, 'e');
		assertCharAt('abcde', 5, null);
		assertCharAt('', 0, '');
		assertCharAt(' ', 0, ' ');
    }    
    
    private static void assertCharAt(String str, Integer index, String expected){
        String actual = StringUtils.charAt(str,index);
        System.assert(actual==expected, 'StringUtils.charAt(\'' + str + '\',' + index + ') returned ' + actual);
    }
    
    private static testmethod void testSplitTwoArgs(){
		assertSplitTwoArgs(null, 		null, 	null);
		assertSplitTwoArgs('', 			null, 	new String[]{''});
		assertSplitTwoArgs('', 			'abc', 	new String[]{''});
		assertSplitTwoArgs('a.b.c', 	'.',	new String[]{'a','b','c'});
		assertSplitTwoArgs('a..b.c',	'.', 	new String[]{'a','b','c'});
		assertSplitTwoArgs('a..b..c',	'..', 	new String[]{'a','b','c'});
		assertSplitTwoArgs('a:b:c', 	'.', 	new String[]{'a:b:c'});
		assertSplitTwoArgs('a b c', 	' ', 	new String[]{'a','b','c'});
    }    

    private static void assertSplitTwoArgs(String str, String separator, String[] expected){
        String[] actual = StringUtils.split(str,separator);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.split(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.split(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        }
    }

    private static testmethod void testSplitThreeArgs(){
		assertSplitThreeArgs(null, 			'', 	1, 	null);
		assertSplitThreeArgs('', 			'', 	1, 	new String[]{''});
		assertSplitThreeArgs('ab cd ef', 	null, 	0, 	new String[]{'ab', 'cd', 'ef'});
		assertSplitThreeArgs('ab   cd ef', 	null, 	0, 	new String[]{'ab', 'cd', 'ef'});
		assertSplitThreeArgs('ab:cd:ef', 	':', 	0, 	new String[]{'ab', 'cd', 'ef'});
		assertSplitThreeArgs('ab:cd:ef', 	':', 	2, 	new String[]{'ab', 'cd:ef'});
    }    
    
    private static void assertSplitThreeArgs(String str, String separator, Integer max, String[] expected){
        String[] actual = StringUtils.split(str,separator,max);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.split(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.split(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        }
    }
    
    private static testmethod void testSplitByWholeSeparatorTwoArg(){
		assertSplitByWholeSeparatorTwoArg(null, 			null, 	null);
		assertSplitByWholeSeparatorTwoArg('', 				null,	new String[]{''});
		assertSplitByWholeSeparatorTwoArg('ab cd ef', 		null,	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorTwoArg('ab cd ef', 		' ',	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorTwoArg('ab     cd ef', 	null,	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorTwoArg('ab:cd:ef', 		':',	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorTwoArg('ab-!-cd-!-ef', 	'-!-',	new String[]{'ab', 'cd', 'ef'});
    }    
    
    private static void assertSplitByWholeSeparatorTwoArg(String str, String separator, String[] expected){
        String[] actual = StringUtils.splitByWholeSeparator(str,separator);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        }
    }
    
    private static testmethod void testSplitPreserveAllTokensTwoArg(){
		//test global static String[] splitPreserveAllTokens(String str, String separatorChars) {
		assertSplitPreserveAllTokensTwoArg(null, 			null,	null);
		assertSplitPreserveAllTokensTwoArg('', 				null,	new String[]{''});
		assertSplitPreserveAllTokensTwoArg('abc def', 		null,	new String[]{'abc', 'def'});
		assertSplitPreserveAllTokensTwoArg('abc def', 		' ',	new String[]{'abc', 'def'});
		assertSplitPreserveAllTokensTwoArg('abc  def', 		' ',	new String[]{'abc', '', 'def'});
		assertSplitPreserveAllTokensTwoArg('ab:cd:ef', 		':',	new String[]{'ab', 'cd', 'ef'});
		assertSplitPreserveAllTokensTwoArg('ab:cd:ef:', 	':',	new String[]{'ab', 'cd', 'ef', ''});
		assertSplitPreserveAllTokensTwoArg('ab:cd:ef::', 	':',	new String[]{'ab', 'cd', 'ef', '', ''});
		assertSplitPreserveAllTokensTwoArg('ab::cd:ef', 	':',	new String[]{'ab', '', 'cd', 'ef'});
		assertSplitPreserveAllTokensTwoArg(':cd:ef', 		':',	new String[]{'', 'cd', 'ef'});
		assertSplitPreserveAllTokensTwoArg('::cd:ef', 		':',	new String[]{'', '', 'cd', 'ef'});
		assertSplitPreserveAllTokensTwoArg(':cd:ef:', 		':',	new String[]{'', 'cd', 'ef', ''});
    }

    private static void assertSplitPreserveAllTokensTwoArg(String str, String separator, String[] expected){
        String[] actual = StringUtils.splitPreserveAllTokens(str,separator);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        }
    }

    private static testmethod void testSplitPreserveAllTokensThreeArgs(){
		//test global static String[] splitPreserveAllTokens(String str, String separatorChars, Integer max) {
		assertSplitPreserveAllTokensThreeArgs(null, 		null,	-1, null);
		assertSplitPreserveAllTokensThreeArgs('', 			null, 	-1,	new String[]{''});
		assertSplitPreserveAllTokensThreeArgs('ab cd ef', 	null, 	0,	new String[]{'ab', 'cd', 'ef'});
		assertSplitPreserveAllTokensThreeArgs('ab   cd ef', null, 	0,	new String[]{'ab', '', '', 'cd', 'ef'});
		assertSplitPreserveAllTokensThreeArgs('ab:cd:ef', 	':', 	0,	new String[]{'ab', 'cd', 'ef'});
		assertSplitPreserveAllTokensThreeArgs('ab:cd:ef', 	':', 	2,	new String[]{'ab', 'cd:ef'});
		assertSplitPreserveAllTokensThreeArgs('ab::cd::ef', '::', 	2,	new String[]{'ab', ':cd::ef'});
		assertSplitPreserveAllTokensThreeArgs('ab   de fg', null, 	2,	new String[]{'ab', '  de fg'});
		assertSplitPreserveAllTokensThreeArgs('ab   de fg', null, 	3,	new String[]{'ab', '', ' de fg'});
		assertSplitPreserveAllTokensThreeArgs('ab   de fg', null, 	4,	new String[]{'ab', '', '', 'de fg'});
    }

    private static void assertSplitPreserveAllTokensThreeArgs(String str, String separatorChars, 
    	Integer max, String[] expected){

        String[] actual = StringUtils.splitPreserveAllTokens(str,separatorChars,max);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separatorChars + '\',' + max + ') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separatorChars + '\',' + max + ') returned ' + toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorThreeArgs(){
		//test global static String[] splitByWholeSeparator(String str, String separator, Integer max ) {
		
		assertTestSplitByWholeSeparatorThreeArgs(null, 			null, 	0, null);
		assertTestSplitByWholeSeparatorThreeArgs('', 				null,	0, new String[]{''});
		assertTestSplitByWholeSeparatorThreeArgs('ab cd ef', 		null,	0, new String[]{'ab', 'cd', 'ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab cd ef', 		' ',	0, new String[]{'ab', 'cd', 'ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab     cd ef', 	null,	0, new String[]{'ab', 'cd', 'ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef', 		':',	1, new String[]{'ab:cd:ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef', 		':',	2, new String[]{'ab', 'cd:ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef', 		':',	3, new String[]{'ab', 'cd', 'ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab-!-cd-!-ef', 	'-!-',	5, new String[]{'ab', 'cd', 'ef'});
		assertTestSplitByWholeSeparatorThreeArgs('ab-!-cd-!-ef', 	'-!-',	2, new String[]{'ab', 'cd-!-ef'});
    }
    private static void assertTestSplitByWholeSeparatorThreeArgs(String str, String separator, 
    	Integer max, String[] expected){

        String[] actual = StringUtils.splitByWholeSeparator(str,separator,max);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorPreserveAllTokensTwoArgs(){
		//test global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator) {
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs(null, 			null, 	null);
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('', 			null,	new String[]{''});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab cd ef', 	null,	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab cd ef', 	' ',	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab   cd ef', 	null,	new String[]{'ab', '', '', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab:cd:ef', 	':',	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab-!-cd-!-ef', '-!-',	new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab-!--!-cd-!-ef','-!-',	new String[]{'ab', '', 'cd', 'ef'});
    }
    private static void assertSplitByWholeSeparatorPreserveAllTokensTwoArgs(String str, String separator, String[] expected){

        String[] actual = StringUtils.splitByWholeSeparatorPreserveAllTokens(str,separator);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorPreserveAllTokensThreeArgs(){
		//test global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator, Integer max) {

		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs(null, 				null, 	0, null);
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('', 				null,	0, new String[]{''});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab cd ef', 		null,	0, new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab cd ef', 		' ',	0, new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab   cd ef', 		' ',	0, new String[]{'ab', '', '', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef', 		':',	1, new String[]{'ab:cd:ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef', 		':',	2, new String[]{'ab', 'cd:ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef', 		':',	3, new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab::cd:ef', 		':',	2, new String[]{'ab', ':cd:ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab-!-cd-!-ef', 	'-!-',	5, new String[]{'ab', 'cd', 'ef'});
		assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab-!-cd-!-ef', 	'-!-',	2, new String[]{'ab', 'cd-!-ef'});
    }
    private static void assertSplitByWholeSeparatorPreserveAllTokensThreeArgs(String str, String separator, 
    	Integer max, String[] expected){

        String[] actual = StringUtils.splitByWholeSeparatorPreserveAllTokens(str,separator,max);
        if(actual == null){
        	System.assert(expected == null, 'StringUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        	return;
        }
        for(Integer i = 0; i < actual.size(); i++){
        	System.assert(expected[i] == actual[i], 'StringUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + toString(actual));
        }
    }

    private static testmethod void testLeftPadTwoArgs(){
		// test: global static String leftPad(String str, Integer size) {
		assertLeftPadTwoArgs(null, 	-1,	null);
		assertLeftPadTwoArgs('', 	3, 	'   ');
		assertLeftPadTwoArgs('bat', 3, 	'bat');
		assertLeftPadTwoArgs('bat', 5, 	'  bat');
		assertLeftPadTwoArgs('bat', 1,	'bat');
		assertLeftPadTwoArgs('bat', -1,	'bat');
    }    
    
    private static void assertLeftPadTwoArgs(String str, Integer size, String expected){
    	String actual = StringUtils.leftPad(str,size);
    	System.assert(actual==expected, 'StringUtils.leftPad(\'' + str + '\',' 
    		+ size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testLeftPadThreeArgs(){
		//test: global static String leftPad(String str, Integer size, String padStr) {
		assertLeftPadThreeArgs(null, 	-1, null, 	null);
		assertLeftPadThreeArgs('', 		3, 	'z', 	'zzz'); 
		assertLeftPadThreeArgs('bat', 	3, 	'yz', 	'bat');
		assertLeftPadThreeArgs('bat', 	5, 	'yz', 	'yzbat');
		assertLeftPadThreeArgs('bat', 	8, 	'yz', 	'yzyzybat');
		assertLeftPadThreeArgs('bat', 	1, 	'yz', 	'bat');
		assertLeftPadThreeArgs('bat', 	-1, 'yz', 	'bat');
		assertLeftPadThreeArgs('bat', 	5, 	null, 	'  bat');
		assertLeftPadThreeArgs('bat', 	5, 	'', 	'  bat');
    }    

    private static void assertLeftPadThreeArgs(String str, Integer size, String padStr, String expected){
    	String actual = StringUtils.leftPad(str,size,padStr);
    	System.assert(actual==expected, 'StringUtils.leftPad(\'' + str + '\',' 
    		+ size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRightPadTwoArgs(){
		//test: global static String rightPad(String str, Integer size) {
		assertRightPadTwoArgs(null, 	-1, null);
		assertRightPadTwoArgs('', 		3, 	'   ');
		assertRightPadTwoArgs('bat', 	3, 	'bat');
		assertRightPadTwoArgs('bat', 	5, 	'bat  ');
		assertRightPadTwoArgs('bat', 	1, 	'bat');
		assertRightPadTwoArgs('bat', 	-1, 'bat');
    }    
    
    private static void assertRightPadTwoArgs(String str, Integer size, String expected){
    	String actual = StringUtils.rightPad(str,size);
    	System.assert(actual==expected, 'StringUtils.rightPad(\'' + str + '\',' 
    		+ size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRightPadThreeArgs(){
		//test: global static String rightPad(String str, Integer size, String padStr) {
		assertRightPadThreeArgs(null, 	-1, null, 	null);
		assertRightPadThreeArgs('', 	3, 	'', 	'   ');
		assertRightPadThreeArgs('', 	3, 	'z', 	'zzz');
		assertRightPadThreeArgs('bat', 	3, 	'z', 	'bat');
		assertRightPadThreeArgs('bat', 	5, 	'z', 	'batzz');
		assertRightPadThreeArgs('bat', 	1, 	'z', 	'bat');
		assertRightPadThreeArgs('bat', 	-1,	'z', 	'bat');
		assertRightPadThreeArgs('bat', 	6,	'abcd', 'batabc');
    }    
    
    private static void assertRightPadThreeArgs(String str, Integer size, String padStr, String expected){
    	String actual = StringUtils.rightPad(str,size,padStr);
    	System.assert(actual==expected, 'StringUtils.rightPad(\'' + str + '\',' 
    		+ size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testGetCommonPrefix(){
    	//test: global static String getCommonPrefix(List<String> strs) {
		assertGetCommonPrefix(null, 											'');
		assertGetCommonPrefix(null, 											'');
		assertGetCommonPrefix(new String[] {}, 									'');
		assertGetCommonPrefix(new String[] {'abc'}, 							'abc');
		assertGetCommonPrefix(new String[] {null, null}, 						'');
		assertGetCommonPrefix(new String[] {'', ''}, 							'');
		assertGetCommonPrefix(new String[] {'', null}, 							'');
		assertGetCommonPrefix(new String[] {'abc', null, null}, 				'');
		assertGetCommonPrefix(new String[] {null, null, 'abc'}, 				'');
		assertGetCommonPrefix(new String[] {'', 'abc'}, 						'');
		assertGetCommonPrefix(new String[] {'abc', ''}, 						'');
		assertGetCommonPrefix(new String[] {'abc', 'abc'}, 						'abc');
		assertGetCommonPrefix(new String[] {'abc', 'a'}, 						'a');
		assertGetCommonPrefix(new String[] {'ab', 'abxyz'}, 					'ab');
		assertGetCommonPrefix(new String[] {'abcde', 'abxyz'}, 					'ab');
		assertGetCommonPrefix(new String[] {'abcde', 'xyz'}, 					'');
		assertGetCommonPrefix(new String[] {'xyz', 'abcde'}, 					'');
		assertGetCommonPrefix(new String[] {'i am a machine', 'i am a robot'}, 	'i am a ');
    }    
    
    private static void assertGetCommonPrefix(String[] strs, String expected){
    	String actual = StringUtils.getCommonPrefix(strs);
    	System.assert(actual==expected, 'StringUtils.getCommonPrefix(' + toString(strs) 
    		+ ') returned \'' + actual + '\', expected \'' + expected + '\'');
    }

    private static testmethod void testIndexOfDifferenceArrayInput(){
    	//test: global static Integer indexOfDifference(String[] strs) {
		assertIndexOfDifferenceArrayInput(null, 											-1);
		assertIndexOfDifferenceArrayInput(new String[] {}, 									-1);
		assertIndexOfDifferenceArrayInput(new String[] {'abc'}, 							-1);
		assertIndexOfDifferenceArrayInput(new String[] {null, null}, 						-1);
		assertIndexOfDifferenceArrayInput(new String[] {'', ''}, 							-1);
		assertIndexOfDifferenceArrayInput(new String[] {'', null}, 							0);
		assertIndexOfDifferenceArrayInput(new String[] {'abc', null, null}, 				0);
		assertIndexOfDifferenceArrayInput(new String[] {null, null, 'abc'}, 				0);
		assertIndexOfDifferenceArrayInput(new String[] {'', 'abc'}, 						0);
		assertIndexOfDifferenceArrayInput(new String[] {'abc', ''},							0);
		assertIndexOfDifferenceArrayInput(new String[] {'abc', 'abc'}, 						-1);
		assertIndexOfDifferenceArrayInput(new String[] {'abc', 'a'}, 						1);
		assertIndexOfDifferenceArrayInput(new String[] {'ab', 'abxyz'}, 					2);
		assertIndexOfDifferenceArrayInput(new String[] {'abcde', 'abxyz'}, 					2);
		assertIndexOfDifferenceArrayInput(new String[] {'abcde', 'xyz'}, 					0);
		assertIndexOfDifferenceArrayInput(new String[] {'xyz', 'abcde'}, 					0);
		assertIndexOfDifferenceArrayInput(new String[] {'i am a machine', 'i am a robot'}, 	7);
    }    
    
    private static void assertIndexOfDifferenceArrayInput(String[] strs, Integer expected){
    	Integer actual = StringUtils.indexOfDifference(strs);
    	System.assert(actual==expected, 'StringUtils.indexOfDifference(' + toString(strs) 
    		+ ') returned ' + actual + '; expected ' + expected);
    }


    private static testmethod void testGetLevenshteinDistance(){
    	//test: global static Integer getLevenshteinDistance(String s, String t) {
		assertGetLevenshteinDistance(null, 			null, 		-1,	true);
		assertGetLevenshteinDistance(null, 			null, 		-1,	true);
		assertGetLevenshteinDistance('',			'', 		0,	false);
		assertGetLevenshteinDistance('',			'a', 		1,	false);
		assertGetLevenshteinDistance('aaapppp', 	'', 		7,	false);
		assertGetLevenshteinDistance('frog', 		'fog', 		1,	false);
		assertGetLevenshteinDistance('fly', 		'ant', 		3,	false);
		assertGetLevenshteinDistance('elephant', 	'hippo', 	7,	false);
		assertGetLevenshteinDistance('hippo', 		'elephant', 7,	false);
		assertGetLevenshteinDistance('hippo', 		'zzzzzzzz', 8,	false);
		assertGetLevenshteinDistance('hello', 		'hallo', 	1,	false);
    }    
    
    private static void assertGetLevenshteinDistance(String s, String t, 
    	Integer expected, Boolean excepExpected){

    	Integer actual = null;
    	Boolean excepActual = false;
    	try{
    		actual = StringUtils.getLevenshteinDistance(s,t);
    	} catch (IllegalArgumentException e){
    		excepActual = true;
    	}
    	if(excepExpected && excepActual){
    		return;
    	}
    	System.assert(excepExpected == excepActual, 'StringUtils.getLevenshteinDistance(\'' 
    		+ s + '\',\'' + t + '\') ' 
    		+ (excepExpected ? 'did not throw' : 'unexpectedly threw') 
    		+ ' IllegalArgumentException');
    	if(!excepExpected && !excepActual){
	    	System.assert(actual==expected, 'StringUtils.getLevenshteinDistance(\'' + s + '\',\'' 
	    		+ t + '\') returned ' + actual + '; expected ' + expected);
    	}
    }


     private static testmethod void testIndexOfThreeArgs(){
		//test: global static Integer indexOf(String str, String searchStr, Integer startPos) {
		assertIndexOfThreeArgs(null, 		null, 	-1, -1);
		assertIndexOfThreeArgs('', 			'', 	0, 	0);
		assertIndexOfThreeArgs('aabaabaa', 	'a', 	0, 	0);
		assertIndexOfThreeArgs('aabaabaa', 	'b', 	0, 	2);
		assertIndexOfThreeArgs('aabaabaa', 	'ab', 	0, 	1);
		assertIndexOfThreeArgs('aabaabaa', 	'b', 	3, 	5);
		assertIndexOfThreeArgs('aabaabaa', 	'b', 	9, 	-1);
		assertIndexOfThreeArgs('aabaabaa', 	'b', 	-1, 2);
		assertIndexOfThreeArgs('aabaabaa', 	'', 	2, 	2);
		assertIndexOfThreeArgs('abc', 		'', 	9, 	3);
    }    

    private static void assertIndexOfThreeArgs(String str, String searchStr, Integer startPos, Integer expected){
    	Integer actual = StringUtils.indexOf(str,searchStr,startPos);
    	System.assert(actual==expected, 'StringUtils.indexOf(\'' + str + '\',\'' 
    		+ searchStr + '\',' + startPos + ') returned ' + actual + '; expected ' + expected);
    }

    private static testmethod void testOrdinalIndexOf(){
		//test: global static Integer ordinalIndexOf(String str, String searchStr, Integer ordinal) {
		assertOrdinalIndexOf(null, 			null, 	-1, -1);
		assertOrdinalIndexOf('', 			'', 	-1, -1);
		assertOrdinalIndexOf('aabaabaa', 	'a', 	1, 	0);
		assertOrdinalIndexOf('aabaabaa', 	'a', 	2, 	1);
		assertOrdinalIndexOf('aabaabaa', 	'b', 	1, 	2);
		assertOrdinalIndexOf('aabaabaa', 	'b', 	2, 	5);
		assertOrdinalIndexOf('aabaabaa', 	'ab', 	1, 	1);
		assertOrdinalIndexOf('aabaabaa', 	'ab', 	2, 	4);
		assertOrdinalIndexOf('aabaabaa', 	'z', 	1, 	-1);
		assertOrdinalIndexOf('aabaabaa', 	'', 	1, 	0);
		assertOrdinalIndexOf('aabaabaa', 	'', 	2, 	0);
    }    

    private static void assertOrdinalIndexOf(String str, String searchStr, Integer ordinal, Integer expected){
    	Integer actual = StringUtils.ordinalIndexOf(str,searchStr,ordinal);
    	System.assert(actual==expected, 'StringUtils.ordinalIndexOf(\'' + str + '\',\'' 
    		+ searchStr + '\',' + ordinal + ') returned ' + actual + '; expected ' + expected);
    }

	private static testmethod void testValidateChar(){
		try{
			Character.validateChar('ab');  //should throw exception since string has > 1 chars
			System.assert(false,'Character.validateChar(\'ab\') did not throw InvalidCharacterStringException');
		}catch(InvalidCharacterStringException e){}
	}

    private static String toString(String[] aStringArray){
    	if(aStringArray == null){
    		return '{}';	
    	}
    	String returnValue = '{';
        for(Integer i = 0; i < aStringArray.size(); i++){
	    	if(i!=0){ returnValue += ','; }
	    	returnValue += '\'' + aStringArray[i] + '\'';
        }
    	returnValue += '}';
    	return returnValue;
    }
    
    
}