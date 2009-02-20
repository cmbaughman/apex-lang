global class TestCharacter {


    global static testmethod void testValidateChar(){
    	final String[] badCharStrings = new String[]{null,'','AB'};
    	for(String badCharString : badCharStrings){
    		try{
    			Character.validateChar(badCharString);
    			System.assert(false,'Exception should have been thrown for invalid char: ' + badCharString);
    		} catch(Exception e){}
    	}
    	Character.validateChar('B');
    }
    
    global static testmethod void testIsUpperCase(){
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
    
    global static testmethod void testIsLowerCase(){
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
    

}