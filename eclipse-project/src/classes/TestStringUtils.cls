global class TestStringUtils {

    global static testmethod void testLowerCase(){
    	assertLowerCase(null, null);
    	assertLowerCase('ABC', 'abc');
    	assertLowerCase('abc', 'abc');
    	assertLowerCase('aBc', 'abc');
    }    
    
    private static void assertLowerCase(String str, String expected){
    	String actual = StringUtils.lowerCase(str);
    	System.assert(actual==expected, 'StringUtils.lowerCase(\'' + str + '\') returned ' + actual);
    }
    
    global static testmethod void testUpperCase(){
    	assertUpperCase(null, null);
    	assertUpperCase('ABC', 'ABC');
    	assertUpperCase('abc', 'ABC');
    	assertUpperCase('aBc', 'ABC');
    }    
    
    private static void assertUpperCase(String str, String expected){
    	String actual = StringUtils.upperCase(str);
    	System.assert(actual==expected, 'StringUtils.upperCase(\'' + str + '\') returned ' + actual);
    }
    
    global static testmethod void testCapitalize(){
    	assertCapitalize(null, null);
    	assertCapitalize('ABC', 'ABC');
    	assertCapitalize('abc', 'Abc');
    	assertCapitalize('aBc', 'ABc');
    }    
    
    private static void assertCapitalize(String str, String expected){
    	String actual = StringUtils.capitalize(str);
    	System.assert(actual==expected, 'StringUtils.capitalize(\'' + str + '\') returned ' + actual);
    }
    
    global static testmethod void testUncapitalize(){
    	assertUncapitalize(null, null);
    	assertUncapitalize('ABC', 'aBC');
    	assertUncapitalize('abc', 'abc');
    	assertUncapitalize('aBc', 'aBc');
    }    
    
    private static void assertUncapitalize(String str, String expected){
    	String actual = StringUtils.uncapitalize(str);
    	System.assert(actual==expected, 'StringUtils.uncapitalize(\'' + str + '\') returned ' + actual);
    }
    
    global static testmethod void testSwapCase(){
    	assertSwapCase(null, null);
    	assertSwapCase('', '');
    	assertSwapCase('The dog has a BONE', 'tHE DOG HAS A bone');
    }    
    
    private static void assertSwapCase(String str, String expected){
    	String actual = StringUtils.swapCase(str);
    	System.assert(actual==expected, 'StringUtils.swapCase(\'' + str + '\') returned ' + actual);
    }
    
    global static testmethod void testIsBlank(){
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

    global static testmethod void testIsNotBlank(){
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
    
    global static testmethod void testTrim(){
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
     
    
    
    global static testmethod void testJoinStrings(){
    	assertJoinStrings(null, null, null);
    	assertJoinStrings(new Set<String>(), ':', null);
    	assertJoinStrings(new Set<String>{'a','b','c'}, ':', 'a:c:b');
    	assertJoinStrings(new Set<String>{' ','b','c'}, ':', 'c:b');
    }

    private static void assertJoinStrings(Set<String> strings, String separator, String expectedReturnValue){
    	String actual = StringUtils.joinStrings(strings,separator);
    	System.assert(actual==expectedReturnValue,
    		'StringUtils.joinStrings(Set<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + 
    			actual + '; expected: ' + expectedReturnValue);
    }
    
    global static testmethod void testEndsWith(){
		assertEndsWith(null, null, true);
        assertEndsWith('abcdef', null, false);
        assertEndsWith(null, 'def', false);
        assertEndsWith('abcdef', 'def', true);
        assertEndsWith('ABCDEF', 'def', false);
    }

    global static testmethod void testEndsWithIgnoreCase(){
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

    global static testmethod void testContains(){
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
    
    global static testmethod void testContainsIgnoreCase(){
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
    
}