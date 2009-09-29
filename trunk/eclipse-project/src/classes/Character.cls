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
global class Character {

    global static final IntegerRange UPPERCASE_ASCII_RANGE = new IntegerRange(65,90);
    global static final IntegerRange LOWERCASE_ASCII_RANGE = new IntegerRange(97,122);
    global static final IntegerRange DIGIT_ASCII_RANGE = new IntegerRange(48,57);
    
    //global static final Integer COMBINING_SPACING_MARK = 1;
    global static final Integer CONNECTOR_PUNCTUATION = 2;
    global static final Integer CONTROL = 3;
    global static final Integer CURRENCY_SYMBOL = 4;
    global static final Integer DASH_PUNCTUATION = 5;
    global static final Integer DECIMAL_DIGIT_NUMBER = 6;
    //global static final Integer ENCLOSING_MARK = 7;
    global static final Integer END_PUNCTUATION = 8;
    //global static final Integer FINAL_QUOTE_PUNCTUATION = 9;
    //global static final Integer FORMAT = 10;
    //global static final Integer INITIAL_QUOTE_PUNCTUATION = 11;
    //global static final Integer LETTER_NUMBER = 12;
    //global static final Integer LINE_SEPARATOR = 13;
    global static final Integer LOWERCASE_LETTER = 14;
    global static final Integer MATH_SYMBOL = 15;
    //global static final Integer MODIFIER_LETTER = 16;
    global static final Integer MODIFIER_SYMBOL = 17;
    //global static final Integer NON_SPACING_MARK = 18;
    //global static final Integer OTHER_LETTER = 19;
    //global static final Integer OTHER_NUMBER = 20;
    global static final Integer OTHER_PUNCTUATION = 21;
    //global static final Integer OTHER_SYMBOL = 22;
    //global static final Integer PARAGRAPH_SEPARATOR = 23;
    //global static final Integer PRIVATE_USE = 24;
    global static final Integer SPACE_SEPARATOR = 25;
    global static final Integer START_PUNCTUATION = 26;
    //global static final Integer SURROGATE = 27;
    //global static final Integer TITLECASE_LETTER = 28;
    global static final Integer UNASSIGNED = 29;
    global static final Integer UPPERCASE_LETTER = 30;

    private static final Map<String,Integer> charToAscii = new Map<String,Integer>();
    private static final Map<Integer,String> asciiToChar = new Map<Integer,String>();
    private static final Map<Integer,Integer> asciiToType = new Map<Integer,Integer>();
    
    
    global static Integer getType(String character){
        validateChar(character);
        Integer ascii = toAscii(character);
        if(asciiToType.containsKey(ascii)){
            return asciiToType.get(ascii);
        }
        return UNASSIGNED; 
    }
    
    global static Integer toAscii(String character){
        validateChar(character);
        if(charToAscii.containsKey(character)){
            return charToAscii.get(character);
        }
        return -1; 
    }
    
    global static String toChar(Integer ascii){
        if(ascii <= 0 || ascii > 127){
            return null;    
        }
        if(asciiToChar.containsKey(ascii)){
            return asciiToChar.get(ascii);
        }
        return null; 
    }
    
    global static String toTitleCase(String ch){
        if(inAsciiRange(ch,LOWERCASE_ASCII_RANGE)){
            return toChar(toAscii(ch)-32);
        }
        return ch; 
    }
    
    global static String toUpperCase(String ch){
        return toTitleCase(ch); 
    }
    
    global static String toLowerCase(String ch){
        if(inAsciiRange(ch,UPPERCASE_ASCII_RANGE)){
            return toChar(toAscii(ch)+32);
        }
        return ch; 
    }
    
    global static Boolean isUpperCase(String character){ 
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isTitleCase(String character){ 
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isLowerCase(String character){ 
        return inAsciiRange(character,LOWERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isDigit(String character){ 
        return inAsciiRange(character,DIGIT_ASCII_RANGE); 
    }

    global static Boolean isLetter(String character){ 
        return isLowerCase(character) || isUpperCase(character);
    }
    
    global static Boolean isLetterOrDigit(String character){
        return isLetter(character) || isDigit(character);
    }
    
    global static Boolean isWhitespace(String character){
        validateChar(character);
        return 
            ' '.equals(character)
            || '\n'.equals(character)
            || '\t'.equals(character)
            || '\f'.equals(character)
            || '\r'.equals(character)
            ;        
    }
    
    global static boolean isAscii(String character) {
        Integer ascii = toAscii(character);
        return ascii >= 0 && ascii < 128;
    }
    
    global static boolean isAsciiPrintable(String character) {
        Integer ascii = toAscii(character);
        return ascii >= 32 && ascii < 127;
    }
    
    global static boolean isAsciiControl(String character) {
        Integer ascii = toAscii(character);
        return (ascii >= 0 && ascii < 32) || ascii == 127;
    }
    
    global static boolean isAsciiAlpha(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE) || inAsciiRange(character,LOWERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphaUpper(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphaLower(String character) {
        return inAsciiRange(character,LOWERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiNumeric(String character) {
        return inAsciiRange(character,DIGIT_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphanumeric(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE) 
            || inAsciiRange(character,LOWERCASE_ASCII_RANGE)
            || inAsciiRange(character,DIGIT_ASCII_RANGE);
    }
        
    global static void validateChar(String character){
        if(character != null && character.length() != 1){
            throw new InvalidCharacterStringException('Invalid charcter string: ' + character);
        }
    }

    private static Boolean inAsciiRange(String character, IntegerRange range){
        return range == null ? false : range.contains(toAscii(character));
    }
    
    static{
        charToAscii.put(null, 0);
        charToAscii.put('\t', 9);
        charToAscii.put('\n', 10);
        charToAscii.put('\f', 12);
        charToAscii.put('\r', 13);
        charToAscii.put(' ', 32);
        charToAscii.put('!', 33);
        charToAscii.put('"', 34);
        charToAscii.put('#', 35);
        charToAscii.put('$', 36);
        charToAscii.put('%', 37);
        charToAscii.put('&', 38);
        charToAscii.put('\'', 39);
        charToAscii.put('(', 40);
        charToAscii.put(')', 41);
        charToAscii.put('*', 42);
        charToAscii.put('+', 43);
        charToAscii.put(',', 44);
        charToAscii.put('-', 45);
        charToAscii.put('.', 46);
        charToAscii.put('/', 47);
        charToAscii.put('0', 48);
        charToAscii.put('1', 49);
        charToAscii.put('2', 50);
        charToAscii.put('3', 51);
        charToAscii.put('4', 52);
        charToAscii.put('5', 53);
        charToAscii.put('6', 54);
        charToAscii.put('7', 55);
        charToAscii.put('8', 56);
        charToAscii.put('9', 57);
        charToAscii.put(':', 58);
        charToAscii.put(';', 59);
        charToAscii.put('<', 60);
        charToAscii.put('=', 61);
        charToAscii.put('>', 62);
        charToAscii.put('?', 63);
        charToAscii.put('@', 64);
        charToAscii.put('A', 65);
        charToAscii.put('B', 66);
        charToAscii.put('C', 67);
        charToAscii.put('D', 68);
        charToAscii.put('E', 69);
        charToAscii.put('F', 70);
        charToAscii.put('G', 71);
        charToAscii.put('H', 72);
        charToAscii.put('I', 73);
        charToAscii.put('J', 74);
        charToAscii.put('K', 75);
        charToAscii.put('L', 76);
        charToAscii.put('M', 77);
        charToAscii.put('N', 78);
        charToAscii.put('O', 79);
        charToAscii.put('P', 80);
        charToAscii.put('Q', 81);
        charToAscii.put('R', 82);
        charToAscii.put('S', 83);
        charToAscii.put('T', 84);
        charToAscii.put('U', 85);
        charToAscii.put('V', 86);
        charToAscii.put('W', 87);
        charToAscii.put('X', 88);
        charToAscii.put('Y', 89);
        charToAscii.put('Z', 90);
        charToAscii.put('[', 91);
        charToAscii.put('\\', 92);
        charToAscii.put(']', 93);
        charToAscii.put('^', 94);
        charToAscii.put('_', 95);
        charToAscii.put('`', 96);
        charToAscii.put('a', 97);
        charToAscii.put('b', 98);
        charToAscii.put('c', 99);
        charToAscii.put('d', 100);
        charToAscii.put('e', 101);
        charToAscii.put('f', 102);
        charToAscii.put('g', 103);
        charToAscii.put('h', 104);
        charToAscii.put('i', 105);
        charToAscii.put('j', 106);
        charToAscii.put('k', 107);
        charToAscii.put('l', 108);
        charToAscii.put('m', 109);
        charToAscii.put('n', 110);
        charToAscii.put('o', 111);
        charToAscii.put('p', 112);
        charToAscii.put('q', 113);
        charToAscii.put('r', 114);
        charToAscii.put('s', 115);
        charToAscii.put('t', 116);
        charToAscii.put('u', 117);
        charToAscii.put('v', 118);
        charToAscii.put('w', 119);
        charToAscii.put('x', 120);
        charToAscii.put('y', 121);
        charToAscii.put('z', 122);
        charToAscii.put('{', 123);
        charToAscii.put('|', 124);
        charToAscii.put('}', 125);
        charToAscii.put('~', 126);
        for(String key : charToAscii.keySet()){
            asciiToChar.put(charToAscii.get(key), key);    
        }

        asciiToType.put(0, CONTROL);
        asciiToType.put(9, CONTROL);
        asciiToType.put(10, CONTROL);
        asciiToType.put(12, CONTROL);
        asciiToType.put(13, CONTROL);
        asciiToType.put(32, SPACE_SEPARATOR);
        asciiToType.put(33, OTHER_PUNCTUATION);
        asciiToType.put(34, OTHER_PUNCTUATION);
        asciiToType.put(35, OTHER_PUNCTUATION);
        asciiToType.put(36, CURRENCY_SYMBOL);
        asciiToType.put(37, OTHER_PUNCTUATION);
        asciiToType.put(38, OTHER_PUNCTUATION);
        asciiToType.put(39, OTHER_PUNCTUATION);
        asciiToType.put(40, START_PUNCTUATION);
        asciiToType.put(41, END_PUNCTUATION);
        asciiToType.put(42, OTHER_PUNCTUATION);
        asciiToType.put(43, MATH_SYMBOL);
        asciiToType.put(44, OTHER_PUNCTUATION);
        asciiToType.put(45, DASH_PUNCTUATION);
        asciiToType.put(46, OTHER_PUNCTUATION);
        asciiToType.put(47, OTHER_PUNCTUATION);
        asciiToType.put(48, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(49, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(50, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(51, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(52, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(53, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(54, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(55, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(56, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(57, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(58, OTHER_PUNCTUATION);
        asciiToType.put(59, OTHER_PUNCTUATION);
        asciiToType.put(60, MATH_SYMBOL);
        asciiToType.put(61, MATH_SYMBOL);
        asciiToType.put(62, MATH_SYMBOL);
        asciiToType.put(63, OTHER_PUNCTUATION);
        asciiToType.put(64, OTHER_PUNCTUATION);
        asciiToType.put(65, UPPERCASE_LETTER);
        asciiToType.put(66, UPPERCASE_LETTER);
        asciiToType.put(67, UPPERCASE_LETTER);
        asciiToType.put(68, UPPERCASE_LETTER);
        asciiToType.put(69, UPPERCASE_LETTER);
        asciiToType.put(70, UPPERCASE_LETTER);
        asciiToType.put(71, UPPERCASE_LETTER);
        asciiToType.put(72, UPPERCASE_LETTER);
        asciiToType.put(73, UPPERCASE_LETTER);
        asciiToType.put(74, UPPERCASE_LETTER);
        asciiToType.put(75, UPPERCASE_LETTER);
        asciiToType.put(76, UPPERCASE_LETTER);
        asciiToType.put(77, UPPERCASE_LETTER);
        asciiToType.put(78, UPPERCASE_LETTER);
        asciiToType.put(79, UPPERCASE_LETTER);
        asciiToType.put(80, UPPERCASE_LETTER);
        asciiToType.put(81, UPPERCASE_LETTER);
        asciiToType.put(82, UPPERCASE_LETTER);
        asciiToType.put(83, UPPERCASE_LETTER);
        asciiToType.put(84, UPPERCASE_LETTER);
        asciiToType.put(85, UPPERCASE_LETTER);
        asciiToType.put(86, UPPERCASE_LETTER);
        asciiToType.put(87, UPPERCASE_LETTER);
        asciiToType.put(88, UPPERCASE_LETTER);
        asciiToType.put(89, UPPERCASE_LETTER);
        asciiToType.put(90, UPPERCASE_LETTER);
        asciiToType.put(91, START_PUNCTUATION);
        asciiToType.put(92, OTHER_PUNCTUATION);
        asciiToType.put(93, END_PUNCTUATION);
        asciiToType.put(94, MODIFIER_SYMBOL);
        asciiToType.put(95, CONNECTOR_PUNCTUATION);
        asciiToType.put(96, MODIFIER_SYMBOL);
        asciiToType.put(97, LOWERCASE_LETTER );
        asciiToType.put(98, LOWERCASE_LETTER );
        asciiToType.put(99, LOWERCASE_LETTER );
        asciiToType.put(100, LOWERCASE_LETTER );
        asciiToType.put(101, LOWERCASE_LETTER );
        asciiToType.put(102, LOWERCASE_LETTER );
        asciiToType.put(103, LOWERCASE_LETTER );
        asciiToType.put(104, LOWERCASE_LETTER );
        asciiToType.put(105, LOWERCASE_LETTER );
        asciiToType.put(106, LOWERCASE_LETTER );
        asciiToType.put(107, LOWERCASE_LETTER );
        asciiToType.put(108, LOWERCASE_LETTER );
        asciiToType.put(109, LOWERCASE_LETTER );
        asciiToType.put(110, LOWERCASE_LETTER );
        asciiToType.put(111, LOWERCASE_LETTER );
        asciiToType.put(112, LOWERCASE_LETTER );
        asciiToType.put(113, LOWERCASE_LETTER );
        asciiToType.put(114, LOWERCASE_LETTER );
        asciiToType.put(115, LOWERCASE_LETTER );
        asciiToType.put(116, LOWERCASE_LETTER );
        asciiToType.put(117, LOWERCASE_LETTER );
        asciiToType.put(118, LOWERCASE_LETTER );
        asciiToType.put(119, LOWERCASE_LETTER );
        asciiToType.put(120, LOWERCASE_LETTER );
        asciiToType.put(121, LOWERCASE_LETTER );
        asciiToType.put(122, LOWERCASE_LETTER );
        asciiToType.put(123, START_PUNCTUATION);
        asciiToType.put(124, MATH_SYMBOL);
        asciiToType.put(125, END_PUNCTUATION);
        asciiToType.put(126, MATH_SYMBOL);
        asciiToType.put(127, CONTROL);
    }    
    
}