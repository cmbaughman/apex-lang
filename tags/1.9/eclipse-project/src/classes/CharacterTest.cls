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
private class CharacterTest {

       private static String CHARS_ASCII_CONTROL = '\n\t\r\f';        
    private static String CHARS_ASCII_DIGITS = '0123456789';
    private static String CHARS_ASCII_UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    private static String CHARS_ASCII_LOWER = 'abcdefghijklmnopqrstuvwxyz';
    private static String CHARS_ASCII_PRINTABLE = ' !"#$%&\'()*+,-./' + CHARS_ASCII_DIGITS + ':;<=>?@' + CHARS_ASCII_UPPER + '[\\]^_`' + CHARS_ASCII_LOWER + '{|}~';
    private static String CHARS_ALL_ASCII = CHARS_ASCII_CONTROL + CHARS_ASCII_PRINTABLE;
    private static String CHARS_NON_ASCII = '€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþ';
    private static String CHARS_ASCII_NON_PRINTABLE = CHARS_ASCII_CONTROL + CHARS_NON_ASCII;

    private static testmethod void testValidateChar(){
        final String[] badCharStrings = new String[]{'','AB'};
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
    
    private static testmethod void testToTitleCase(){
        assertToTitleCase('\t','\t');
        assertToTitleCase('\n','\n');
        assertToTitleCase('\f','\f');
        assertToTitleCase('\r','\r');
        assertToTitleCase(' ',' ');
        assertToTitleCase('!','!');
        assertToTitleCase('"','"');
        assertToTitleCase('#','#');
        assertToTitleCase('$','$');
        assertToTitleCase('%','%');
        assertToTitleCase('&','&');
        assertToTitleCase('\'','\'');
        assertToTitleCase('(','(');
        assertToTitleCase(')',')');
        assertToTitleCase('*','*');
        assertToTitleCase('+','+');
        assertToTitleCase(',',',');
        assertToTitleCase('-','-');
        assertToTitleCase('.','.');
        assertToTitleCase('/','/');
        assertToTitleCase('0','0');
        assertToTitleCase('1','1');
        assertToTitleCase('2','2');
        assertToTitleCase('3','3');
        assertToTitleCase('4','4');
        assertToTitleCase('5','5');
        assertToTitleCase('6','6');
        assertToTitleCase('7','7');
        assertToTitleCase('8','8');
        assertToTitleCase('9','9');
        assertToTitleCase(':',':');
        assertToTitleCase(';',';');
        assertToTitleCase('<','<');
        assertToTitleCase('=','=');
        assertToTitleCase('>','>');
        assertToTitleCase('?','?');
        assertToTitleCase('@','@');
        assertToTitleCase('A','A');
        assertToTitleCase('B','B');
        assertToTitleCase('C','C');
        assertToTitleCase('D','D');
        assertToTitleCase('E','E');
        assertToTitleCase('F','F');
        assertToTitleCase('G','G');
        assertToTitleCase('H','H');
        assertToTitleCase('I','I');
        assertToTitleCase('J','J');
        assertToTitleCase('K','K');
        assertToTitleCase('L','L');
        assertToTitleCase('M','M');
        assertToTitleCase('N','N');
        assertToTitleCase('O','O');
        assertToTitleCase('P','P');
        assertToTitleCase('Q','Q');
        assertToTitleCase('R','R');
        assertToTitleCase('S','S');
        assertToTitleCase('T','T');
        assertToTitleCase('U','U');
        assertToTitleCase('V','V');
        assertToTitleCase('W','W');
        assertToTitleCase('X','X');
        assertToTitleCase('Y','Y');
        assertToTitleCase('Z','Z');
        assertToTitleCase('[','[');
        assertToTitleCase('\\','\\');
        assertToTitleCase(']',']');
        assertToTitleCase('^','^');
        assertToTitleCase('_','_');
        assertToTitleCase('`','`');
        assertToTitleCase('a','A');
        assertToTitleCase('b','B');
        assertToTitleCase('c','C');
        assertToTitleCase('d','D');
        assertToTitleCase('e','E');
        assertToTitleCase('f','F');
        assertToTitleCase('g','G');
        assertToTitleCase('h','H');
        assertToTitleCase('i','I');
        assertToTitleCase('j','J');
        assertToTitleCase('k','K');
        assertToTitleCase('l','L');
        assertToTitleCase('m','M');
        assertToTitleCase('n','N');
        assertToTitleCase('o','O');
        assertToTitleCase('p','P');
        assertToTitleCase('q','Q');
        assertToTitleCase('r','R');
        assertToTitleCase('s','S');
        assertToTitleCase('t','T');
        assertToTitleCase('u','U');
        assertToTitleCase('v','V');
        assertToTitleCase('w','W');
        assertToTitleCase('x','X');
        assertToTitleCase('y','Y');
        assertToTitleCase('z','Z');
        assertToTitleCase('{','{');
        assertToTitleCase('|','|');
        assertToTitleCase('}','}');
        assertToTitleCase('~','~');
    }    
    
    private static void assertToTitleCase(String aCharacter, String expected){
        String actual = Character.toTitleCase(aCharacter);
        System.assert(actual==expected, 'Character.toTitleCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testToLowerCase(){
        assertToLowerCase('\t','\t');
        assertToLowerCase('\n','\n');
        assertToLowerCase('\f','\f');
        assertToLowerCase('\r','\r');
        assertToLowerCase(' ',' ');
        assertToLowerCase('!','!');
        assertToLowerCase('"','"');
        assertToLowerCase('#','#');
        assertToLowerCase('$','$');
        assertToLowerCase('%','%');
        assertToLowerCase('&','&');
        assertToLowerCase('\'','\'');
        assertToLowerCase('(','(');
        assertToLowerCase(')',')');
        assertToLowerCase('*','*');
        assertToLowerCase('+','+');
        assertToLowerCase(',',',');
        assertToLowerCase('-','-');
        assertToLowerCase('.','.');
        assertToLowerCase('/','/');
        assertToLowerCase('0','0');
        assertToLowerCase('1','1');
        assertToLowerCase('2','2');
        assertToLowerCase('3','3');
        assertToLowerCase('4','4');
        assertToLowerCase('5','5');
        assertToLowerCase('6','6');
        assertToLowerCase('7','7');
        assertToLowerCase('8','8');
        assertToLowerCase('9','9');
        assertToLowerCase(':',':');
        assertToLowerCase(';',';');
        assertToLowerCase('<','<');
        assertToLowerCase('=','=');
        assertToLowerCase('>','>');
        assertToLowerCase('?','?');
        assertToLowerCase('@','@');
        assertToLowerCase('A','a');
        assertToLowerCase('B','b');
        assertToLowerCase('C','c');
        assertToLowerCase('D','d');
        assertToLowerCase('E','e');
        assertToLowerCase('F','f');
        assertToLowerCase('G','g');
        assertToLowerCase('H','h');
        assertToLowerCase('I','i');
        assertToLowerCase('J','j');
        assertToLowerCase('K','k');
        assertToLowerCase('L','l');
        assertToLowerCase('M','m');
        assertToLowerCase('N','n');
        assertToLowerCase('O','o');
        assertToLowerCase('P','p');
        assertToLowerCase('Q','q');
        assertToLowerCase('R','r');
        assertToLowerCase('S','s');
        assertToLowerCase('T','t');
        assertToLowerCase('U','u');
        assertToLowerCase('V','v');
        assertToLowerCase('W','w');
        assertToLowerCase('X','x');
        assertToLowerCase('Y','y');
        assertToLowerCase('Z','z');
        assertToLowerCase('[','[');
        assertToLowerCase('\\','\\');
        assertToLowerCase(']',']');
        assertToLowerCase('^','^');
        assertToLowerCase('_','_');
        assertToLowerCase('`','`');
        assertToLowerCase('a','a');
        assertToLowerCase('b','b');
        assertToLowerCase('c','c');
        assertToLowerCase('d','d');
        assertToLowerCase('e','e');
        assertToLowerCase('f','f');
        assertToLowerCase('g','g');
        assertToLowerCase('h','h');
        assertToLowerCase('i','i');
        assertToLowerCase('j','j');
        assertToLowerCase('k','k');
        assertToLowerCase('l','l');
        assertToLowerCase('m','m');
        assertToLowerCase('n','n');
        assertToLowerCase('o','o');
        assertToLowerCase('p','p');
        assertToLowerCase('q','q');
        assertToLowerCase('r','r');
        assertToLowerCase('s','s');
        assertToLowerCase('t','t');
        assertToLowerCase('u','u');
        assertToLowerCase('v','v');
        assertToLowerCase('w','w');
        assertToLowerCase('x','x');
        assertToLowerCase('y','y');
        assertToLowerCase('z','z');
        assertToLowerCase('{','{');
        assertToLowerCase('|','|');
        assertToLowerCase('}','}');
        assertToLowerCase('~','~');
    }
    
    private static void assertToLowerCase(String aCharacter, String expected){
        String actual = Character.toLowerCase(aCharacter);
        System.assert(actual==expected, 'Character.toLowerCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testIsTitleCase(){
        //test: global static Boolean isTitleCase(String character){ 
        assertIsTitleCase('\t',FALSE);
        assertIsTitleCase('\n',FALSE);
        assertIsTitleCase('\f',FALSE);
        assertIsTitleCase('\r',FALSE);
        assertIsTitleCase(' ',FALSE);
        assertIsTitleCase('!',FALSE);
        assertIsTitleCase('"',FALSE);
        assertIsTitleCase('#',FALSE);
        assertIsTitleCase('$',FALSE);
        assertIsTitleCase('%',FALSE);
        assertIsTitleCase('&',FALSE);
        assertIsTitleCase('\'',FALSE);
        assertIsTitleCase('(',FALSE);
        assertIsTitleCase(')',FALSE);
        assertIsTitleCase('*',FALSE);
        assertIsTitleCase('+',FALSE);
        assertIsTitleCase(',',FALSE);
        assertIsTitleCase('-',FALSE);
        assertIsTitleCase('.',FALSE);
        assertIsTitleCase('/',FALSE);
        assertIsTitleCase('0',FALSE);
        assertIsTitleCase('1',FALSE);
        assertIsTitleCase('2',FALSE);
        assertIsTitleCase('3',FALSE);
        assertIsTitleCase('4',FALSE);
        assertIsTitleCase('5',FALSE);
        assertIsTitleCase('6',FALSE);
        assertIsTitleCase('7',FALSE);
        assertIsTitleCase('8',FALSE);
        assertIsTitleCase('9',FALSE);
        assertIsTitleCase(':',FALSE);
        assertIsTitleCase(';',FALSE);
        assertIsTitleCase('<',FALSE);
        assertIsTitleCase('=',FALSE);
        assertIsTitleCase('>',FALSE);
        assertIsTitleCase('?',FALSE);
        assertIsTitleCase('@',FALSE);
        assertIsTitleCase('A',TRUE);
        assertIsTitleCase('B',TRUE);
        assertIsTitleCase('C',TRUE);
        assertIsTitleCase('D',TRUE);
        assertIsTitleCase('E',TRUE);
        assertIsTitleCase('F',TRUE);
        assertIsTitleCase('G',TRUE);
        assertIsTitleCase('H',TRUE);
        assertIsTitleCase('I',TRUE);
        assertIsTitleCase('J',TRUE);
        assertIsTitleCase('K',TRUE);
        assertIsTitleCase('L',TRUE);
        assertIsTitleCase('M',TRUE);
        assertIsTitleCase('N',TRUE);
        assertIsTitleCase('O',TRUE);
        assertIsTitleCase('P',TRUE);
        assertIsTitleCase('Q',TRUE);
        assertIsTitleCase('R',TRUE);
        assertIsTitleCase('S',TRUE);
        assertIsTitleCase('T',TRUE);
        assertIsTitleCase('U',TRUE);
        assertIsTitleCase('V',TRUE);
        assertIsTitleCase('W',TRUE);
        assertIsTitleCase('X',TRUE);
        assertIsTitleCase('Y',TRUE);
        assertIsTitleCase('Z',TRUE);
        assertIsTitleCase('[',FALSE);
        assertIsTitleCase('\\',FALSE);
        assertIsTitleCase(']',FALSE);
        assertIsTitleCase('^',FALSE);
        assertIsTitleCase('_',FALSE);
        assertIsTitleCase('`',FALSE);
        assertIsTitleCase('a',FALSE);
        assertIsTitleCase('b',FALSE);
        assertIsTitleCase('c',FALSE);
        assertIsTitleCase('d',FALSE);
        assertIsTitleCase('e',FALSE);
        assertIsTitleCase('f',FALSE);
        assertIsTitleCase('g',FALSE);
        assertIsTitleCase('h',FALSE);
        assertIsTitleCase('i',FALSE);
        assertIsTitleCase('j',FALSE);
        assertIsTitleCase('k',FALSE);
        assertIsTitleCase('l',FALSE);
        assertIsTitleCase('m',FALSE);
        assertIsTitleCase('n',FALSE);
        assertIsTitleCase('o',FALSE);
        assertIsTitleCase('p',FALSE);
        assertIsTitleCase('q',FALSE);
        assertIsTitleCase('r',FALSE);
        assertIsTitleCase('s',FALSE);
        assertIsTitleCase('t',FALSE);
        assertIsTitleCase('u',FALSE);
        assertIsTitleCase('v',FALSE);
        assertIsTitleCase('w',FALSE);
        assertIsTitleCase('x',FALSE);
        assertIsTitleCase('y',FALSE);
        assertIsTitleCase('z',FALSE);
        assertIsTitleCase('{',FALSE);
        assertIsTitleCase('|',FALSE);
        assertIsTitleCase('}',FALSE);
        assertIsTitleCase('~',FALSE);
    }
    
    private static void assertIsTitleCase(String aCharacter, Boolean expected){
        Boolean actual = Character.isTitleCase(aCharacter);
        System.assert(actual==expected, 'Character.isTitleCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testToUpperCase(){
        //test: global static String toUpperCase(String ch){
        assertToUpperCase('\t','\t');
        assertToUpperCase('\n','\n');
        assertToUpperCase('\f','\f');
        assertToUpperCase('\r','\r');
        assertToUpperCase(' ',' ');
        assertToUpperCase('!','!');
        assertToUpperCase('"','"');
        assertToUpperCase('#','#');
        assertToUpperCase('$','$');
        assertToUpperCase('%','%');
        assertToUpperCase('&','&');
        assertToUpperCase('\'','\'');
        assertToUpperCase('(','(');
        assertToUpperCase(')',')');
        assertToUpperCase('*','*');
        assertToUpperCase('+','+');
        assertToUpperCase(',',',');
        assertToUpperCase('-','-');
        assertToUpperCase('.','.');
        assertToUpperCase('/','/');
        assertToUpperCase('0','0');
        assertToUpperCase('1','1');
        assertToUpperCase('2','2');
        assertToUpperCase('3','3');
        assertToUpperCase('4','4');
        assertToUpperCase('5','5');
        assertToUpperCase('6','6');
        assertToUpperCase('7','7');
        assertToUpperCase('8','8');
        assertToUpperCase('9','9');
        assertToUpperCase(':',':');
        assertToUpperCase(';',';');
        assertToUpperCase('<','<');
        assertToUpperCase('=','=');
        assertToUpperCase('>','>');
        assertToUpperCase('?','?');
        assertToUpperCase('@','@');
        assertToUpperCase('A','A');
        assertToUpperCase('B','B');
        assertToUpperCase('C','C');
        assertToUpperCase('D','D');
        assertToUpperCase('E','E');
        assertToUpperCase('F','F');
        assertToUpperCase('G','G');
        assertToUpperCase('H','H');
        assertToUpperCase('I','I');
        assertToUpperCase('J','J');
        assertToUpperCase('K','K');
        assertToUpperCase('L','L');
        assertToUpperCase('M','M');
        assertToUpperCase('N','N');
        assertToUpperCase('O','O');
        assertToUpperCase('P','P');
        assertToUpperCase('Q','Q');
        assertToUpperCase('R','R');
        assertToUpperCase('S','S');
        assertToUpperCase('T','T');
        assertToUpperCase('U','U');
        assertToUpperCase('V','V');
        assertToUpperCase('W','W');
        assertToUpperCase('X','X');
        assertToUpperCase('Y','Y');
        assertToUpperCase('Z','Z');
        assertToUpperCase('[','[');
        assertToUpperCase('\\','\\');
        assertToUpperCase(']',']');
        assertToUpperCase('^','^');
        assertToUpperCase('_','_');
        assertToUpperCase('`','`');
        assertToUpperCase('a','A');
        assertToUpperCase('b','B');
        assertToUpperCase('c','C');
        assertToUpperCase('d','D');
        assertToUpperCase('e','E');
        assertToUpperCase('f','F');
        assertToUpperCase('g','G');
        assertToUpperCase('h','H');
        assertToUpperCase('i','I');
        assertToUpperCase('j','J');
        assertToUpperCase('k','K');
        assertToUpperCase('l','L');
        assertToUpperCase('m','M');
        assertToUpperCase('n','N');
        assertToUpperCase('o','O');
        assertToUpperCase('p','P');
        assertToUpperCase('q','Q');
        assertToUpperCase('r','R');
        assertToUpperCase('s','S');
        assertToUpperCase('t','T');
        assertToUpperCase('u','U');
        assertToUpperCase('v','V');
        assertToUpperCase('w','W');
        assertToUpperCase('x','X');
        assertToUpperCase('y','Y');
        assertToUpperCase('z','Z');
        assertToUpperCase('{','{');
        assertToUpperCase('|','|');
        assertToUpperCase('}','}');
        assertToUpperCase('~','~');
    }    
    
    private static void assertToUpperCase(String aCharacter, String expected){
        String actual = Character.toUpperCase(aCharacter);
        System.assert(actual==expected, 'Character.toUpperCase(\'' + aCharacter + '\') returned ' + actual);
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

    private static testmethod void testIsDigit(){
        //test: global static Boolean isDigit(String character){ 
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiDigit(StringUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiDigit(StringUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiDigit(StringUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiDigit(StringUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiDigit(String charactr, Boolean expected){
        Boolean actual = Character.isDigit(charactr); 
        System.assert(actual==expected, 'Character.isDigit(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsLetter(){
        //test: global static Boolean isLetter(String character){ 
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsLetter(StringUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsLetter(StringUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsLetter(StringUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsLetter(StringUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsLetter(String charactr, Boolean expected){
        Boolean actual = Character.isLetter(charactr); 
        System.assert(actual==expected, 'Character.isLetter(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsLetterOrDigit(){
        //test: global static Boolean isLetterOrDigit(String character){
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsLetterOrDigit(StringUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsLetterOrDigit(StringUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsLetterOrDigit(StringUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsLetterOrDigit(StringUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     
    
    private static void assertIsLetterOrDigit(String charactr, Boolean expected){
        Boolean actual = Character.isLetterOrDigit(charactr); 
        System.assert(actual==expected, 'Character.isLetterOrDigit(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsWhitespace(){
        //test: global static Boolean isWhitespace(String character){
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsWhitespace(StringUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsWhitespace(StringUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsWhitespace(StringUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsWhitespace(StringUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_CONTROL.length(); i++){
            assertIsWhitespace(StringUtils.charAt(CHARS_ASCII_CONTROL,i), true);        
        }
    }     
    
    private static void assertIsWhitespace(String charactr, Boolean expected){
        Boolean actual = Character.isWhitespace(charactr); 
        System.assert(actual==expected, 'Character.isWhitespace(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testGetType(){
        //test: global static Integer getType(String character){
        assertGetType('¿', Character.UNASSIGNED); 
        assertGetType(Character.toChar(0), Character.CONTROL); 
        assertGetType(Character.toChar(9), Character.CONTROL); 
        assertGetType(Character.toChar(10), Character.CONTROL); 
        assertGetType(Character.toChar(12), Character.CONTROL); 
        assertGetType(Character.toChar(13), Character.CONTROL); 
        assertGetType(Character.toChar(32), Character.SPACE_SEPARATOR); 
        assertGetType(Character.toChar(33), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(34), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(35), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(36), Character.CURRENCY_SYMBOL); 
        assertGetType(Character.toChar(37), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(38), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(39), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(40), Character.START_PUNCTUATION); 
        assertGetType(Character.toChar(41), Character.END_PUNCTUATION); 
        assertGetType(Character.toChar(42), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(43), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(44), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(45), Character.DASH_PUNCTUATION); 
        assertGetType(Character.toChar(46), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(47), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(48), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(49), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(50), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(51), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(52), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(53), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(54), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(55), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(56), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(57), Character.DECIMAL_DIGIT_NUMBER); 
        assertGetType(Character.toChar(58), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(59), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(60), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(61), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(62), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(63), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(64), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(65), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(66), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(67), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(68), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(69), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(70), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(71), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(72), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(73), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(74), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(75), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(76), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(77), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(78), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(79), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(80), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(81), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(82), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(83), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(84), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(85), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(86), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(87), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(88), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(89), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(90), Character.UPPERCASE_LETTER); 
        assertGetType(Character.toChar(91), Character.START_PUNCTUATION); 
        assertGetType(Character.toChar(92), Character.OTHER_PUNCTUATION); 
        assertGetType(Character.toChar(93), Character.END_PUNCTUATION); 
        assertGetType(Character.toChar(94), Character.MODIFIER_SYMBOL); 
        assertGetType(Character.toChar(95), Character.CONNECTOR_PUNCTUATION); 
        assertGetType(Character.toChar(96), Character.MODIFIER_SYMBOL); 
        assertGetType(Character.toChar(97), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(98), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(99), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(100), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(101), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(102), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(103), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(104), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(105), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(106), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(107), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(108), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(109), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(110), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(111), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(112), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(113), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(114), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(115), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(116), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(117), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(118), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(119), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(120), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(121), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(122), Character.LOWERCASE_LETTER ); 
        assertGetType(Character.toChar(123), Character.START_PUNCTUATION); 
        assertGetType(Character.toChar(124), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(125), Character.END_PUNCTUATION); 
        assertGetType(Character.toChar(126), Character.MATH_SYMBOL); 
        assertGetType(Character.toChar(127), Character.CONTROL); 
    }     
    
    private static void assertGetType(String charactr, Integer expected){
        Integer actual = Character.getType(charactr); 
        System.assert(actual==expected, 'Character.getType(\'' + charactr + '\') returned ' + actual
            + ', expected ' + expected);
    }
            
            
}