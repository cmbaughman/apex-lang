@IsTest
private class TestCharacter {

   	private static String CHARS_ASCII_CONTROL = '\n\t\r\f';		
	private static String CHARS_ASCII_DIGITS = '0123456789';
	private static String CHARS_ASCII_UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	private static String CHARS_ASCII_LOWER = 'abcdefghijklmnopqrstuvwxyz';
	private static String CHARS_ASCII_PRINTABLE = ' !"#$%&\'()*+,-./' + CHARS_ASCII_DIGITS + ':;<=>?@' + CHARS_ASCII_UPPER + '[\\]^_`' + CHARS_ASCII_LOWER + '{|}~';
	private static String CHARS_ALL_ASCII = CHARS_ASCII_CONTROL + CHARS_ASCII_PRINTABLE;
    private static String CHARS_NON_ASCII = '€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþ';
	private static String CHARS_ASCII_NON_PRINTABLE = CHARS_ASCII_CONTROL + CHARS_NON_ASCII;

    private static testmethod void testValidateChar(){
    	final String[] badCharStrings = new String[]{null,'','AB'};
    	for(String badCharString : badCharStrings){
    		try{
    			Character.validateChar(badCharString);
    			System.assert(false,'Exception should have been thrown for invalid char: ' + badCharString);
    		} catch(Exception e){}
    	}
    	Character.validateChar('B');
    }
    
    private static testmethod void testIsUpperCase(){
    	final String UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    	for(Integer i = 0; i < UPPER.length(); i++){
	    	assertIsUpperCase(UPPER.substring(i,i+1), true);
    	}
    	final String LOWER = 'abcdefghijklmnopqrstuvwxyz';
    	for(Integer i = 0; i < LOWER.length(); i++){
	    	assertIsUpperCase(LOWER.substring(i,i+1), false);
    	}
    }    
    
    private static void assertIsUpperCase(String aCharacter, Boolean expected){
    	Boolean actual = Character.isUpperCase(aCharacter);
    	System.assert(actual==expected, 'Character.isUpperCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testIsLowerCase(){
    	final String UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    	for(Integer i = 0; i < UPPER.length(); i++){
	    	assertIsLowerCase(UPPER.substring(i,i+1), false);
    	}
    	final String LOWER = 'abcdefghijklmnopqrstuvwxyz';
    	for(Integer i = 0; i < LOWER.length(); i++){
	    	assertIsLowerCase(LOWER.substring(i,i+1), true);
    	}
    }    
    
    private static void assertIsLowerCase(String aCharacter, Boolean expected){
    	Boolean actual = Character.isLowerCase(aCharacter);
    	System.assert(actual==expected, 'Character.isLowerCase(\'' + aCharacter + '\') returned ' + actual);
    }

	private static testmethod void testToAscii(){
    	//test: global static Integer toAscii(String character){
    	assertToAscii('\t',9);
    	assertToAscii('\n',10);
    	assertToAscii('\f',12);
    	assertToAscii('\r',13);
    	for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
    		assertToAscii(StringUtils.charAt(CHARS_ASCII_PRINTABLE,i), i+32);
    	}
	}
	
	private static void assertToAscii(String charactr, Integer expected){
		Integer actual = Character.toAscii(charactr); 
    	System.assert(actual==expected, 'Character.toAscii(' + charactr + ') returned \'' 
    		+ actual + '\'; expected \'' +expected + '\'');
	}

	private static testmethod void testToChar(){
    	//test: global static String toChar(Integer ascii){
    	assertToChar(-1,null);
    	assertToChar(0,null);
    	assertToChar(128,null);
    	assertToChar(9,'\t');
    	assertToChar(10,'\n');
    	assertToChar(12,'\f');
    	assertToChar(13,'\r');
    	for(Integer i = 32; i < 128; i++){
    		assertToChar(i,StringUtils.charAt(CHARS_ASCII_PRINTABLE,i-32));
    	}
	}

	private static void assertToChar(Integer ascii, String expected){
		String actual = Character.toChar(ascii); 
    	System.assert(actual==expected, 'Character.toChar(' + ascii + ') returned \'' 
    		+ actual + '\'; expected \'' +expected + '\'');
	}

	private static testmethod void testIsAscii(){
    	//test: global static boolean isAscii(String character) {
    	for(Integer i = 0; i < CHARS_ALL_ASCII.length(); i++){
			assertIsAscii(StringUtils.charAt(CHARS_ALL_ASCII,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAscii(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void assertIsAscii(String charactr, Boolean expected){
		Boolean actual = Character.isAscii(charactr); 
    	System.assert(actual==expected, 'Character.isAscii(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiPrintable(){
    	//test: global static boolean isAsciiPrintable(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
			assertIsAsciiPrintable(StringUtils.charAt(CHARS_ASCII_PRINTABLE,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_NON_PRINTABLE.length(); i++){
			assertIsAsciiPrintable(StringUtils.charAt(CHARS_ASCII_NON_PRINTABLE,i), false);		
    	}
	}     

	private static void assertIsAsciiPrintable(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiPrintable(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiPrintable(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiControl(){
    	//test: global static boolean isAsciiControl(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_CONTROL.length(); i++){
			asertIsAsciiControl(StringUtils.charAt(CHARS_ASCII_CONTROL,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
			asertIsAsciiControl(StringUtils.charAt(CHARS_ASCII_PRINTABLE,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			asertIsAsciiControl(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void asertIsAsciiControl(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiControl(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiControl(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiAlpha(){
    	//test: global static boolean isAsciiAlpha(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
			assertIsAsciiAlpha(StringUtils.charAt(CHARS_ASCII_UPPER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
			assertIsAsciiAlpha(StringUtils.charAt(CHARS_ASCII_LOWER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
			assertIsAsciiAlpha(StringUtils.charAt(CHARS_ASCII_DIGITS,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAsciiAlpha(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void assertIsAsciiAlpha(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiAlpha(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiAlpha(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiAlphaUpper(){
    	//test: global static boolean isAsciiAlphaUpper(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
			assertIsAsciiAlphaUpper(StringUtils.charAt(CHARS_ASCII_UPPER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
			assertIsAsciiAlphaUpper(StringUtils.charAt(CHARS_ASCII_LOWER,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
			assertIsAsciiAlphaUpper(StringUtils.charAt(CHARS_ASCII_DIGITS,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAsciiAlphaUpper(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void assertIsAsciiAlphaUpper(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiAlphaUpper(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiAlphaUpper(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiAlphaLower(){
    	//test: global static boolean isAsciiAlphaLower(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
			assertIsAsciiAlphaLower(StringUtils.charAt(CHARS_ASCII_UPPER,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
			assertIsAsciiAlphaLower(StringUtils.charAt(CHARS_ASCII_LOWER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
			assertIsAsciiAlphaLower(StringUtils.charAt(CHARS_ASCII_DIGITS,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAsciiAlphaLower(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void assertIsAsciiAlphaLower(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiAlphaLower(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiAlphaLower(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiNumeric(){
    	//test: global static boolean isAsciiNumeric(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
			assertIsAsciiNumeric(StringUtils.charAt(CHARS_ASCII_UPPER,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
			assertIsAsciiNumeric(StringUtils.charAt(CHARS_ASCII_LOWER,i), false);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
			assertIsAsciiNumeric(StringUtils.charAt(CHARS_ASCII_DIGITS,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAsciiNumeric(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     

	private static void assertIsAsciiNumeric(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiNumeric(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiNumeric(\'' + charactr + '\') returned ' + actual);
	}
			
	private static testmethod void testIsAsciiAlphanumeric(){
    	//test: global static boolean isAsciiAlphanumeric(String character) {
    	for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
			assertIsAsciiAlphanumeric(StringUtils.charAt(CHARS_ASCII_UPPER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
			assertIsAsciiAlphanumeric(StringUtils.charAt(CHARS_ASCII_LOWER,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
			assertIsAsciiAlphanumeric(StringUtils.charAt(CHARS_ASCII_DIGITS,i), true);		
    	}
    	for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
			assertIsAsciiAlphanumeric(StringUtils.charAt(CHARS_NON_ASCII,i), false);		
    	}
	}     
	
	private static void assertIsAsciiAlphanumeric(String charactr, Boolean expected){
		Boolean actual = Character.isAsciiAlphanumeric(charactr); 
    	System.assert(actual==expected, 'Character.isAsciiAlphanumeric(\'' + charactr + '\') returned ' + actual);
	}
			
}