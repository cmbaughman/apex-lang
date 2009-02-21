global class Character {

	global static final IntegerRange UPPERCASE_ASCII_RANGE = new IntegerRange(65,90);
	global static final IntegerRange LOWERCASE_ASCII_RANGE = new IntegerRange(97,122);
	global static final IntegerRange DIGIT_ASCII_RANGE = new IntegerRange(48,57);
	
	private static final Map<String,Integer> charToAscii = new Map<String,Integer>();
	private static final Map<Integer,String> asciiToChar = new Map<Integer,String>();
	
	static{
		charToAscii.put(null, 0);charToAscii.put('\t', 9);charToAscii.put('\n', 10);charToAscii.put('\f', 12);
		charToAscii.put('\r', 13);charToAscii.put(' ', 32);charToAscii.put('!', 33);charToAscii.put('"', 34);
		charToAscii.put('#', 35);charToAscii.put('$', 36);charToAscii.put('%', 37);charToAscii.put('&', 38);
		charToAscii.put('\'', 39);charToAscii.put('(', 40);charToAscii.put(')', 41);charToAscii.put('*', 42);
		charToAscii.put('+', 43);charToAscii.put(',', 44);charToAscii.put('-', 45);charToAscii.put('.', 46);
		charToAscii.put('/', 47);charToAscii.put('0', 48);charToAscii.put('1', 49);charToAscii.put('2', 50);
		charToAscii.put('3', 51);charToAscii.put('4', 52);charToAscii.put('5', 53);charToAscii.put('6', 54);
		charToAscii.put('7', 55);charToAscii.put('8', 56);charToAscii.put('9', 57);charToAscii.put(':', 58);
		charToAscii.put(';', 59);charToAscii.put('<', 60);charToAscii.put('=', 61);charToAscii.put('>', 62);
		charToAscii.put('?', 63);charToAscii.put('@', 64);charToAscii.put('A', 65);charToAscii.put('B', 66);
		charToAscii.put('C', 67);charToAscii.put('D', 68);charToAscii.put('E', 69);charToAscii.put('F', 70);
		charToAscii.put('G', 71);charToAscii.put('H', 72);charToAscii.put('I', 73);charToAscii.put('J', 74);
		charToAscii.put('K', 75);charToAscii.put('L', 76);charToAscii.put('M', 77);charToAscii.put('N', 78);
		charToAscii.put('O', 79);charToAscii.put('P', 80);charToAscii.put('Q', 81);charToAscii.put('R', 82);
		charToAscii.put('S', 83);charToAscii.put('T', 84);charToAscii.put('U', 85);charToAscii.put('V', 86);
		charToAscii.put('W', 87);charToAscii.put('X', 88);charToAscii.put('Y', 89);charToAscii.put('Z', 90);
		charToAscii.put('[', 91);charToAscii.put('\\', 92);charToAscii.put(']', 93);charToAscii.put('^', 94);
		charToAscii.put('_', 95);charToAscii.put('`', 96);charToAscii.put('a', 97);charToAscii.put('b', 98);
		charToAscii.put('c', 99);charToAscii.put('d', 100);charToAscii.put('e', 101);charToAscii.put('f', 102);
		charToAscii.put('g', 103);charToAscii.put('h', 104);charToAscii.put('i', 105);charToAscii.put('j', 106);
		charToAscii.put('k', 107);charToAscii.put('l', 108);charToAscii.put('m', 109);charToAscii.put('n', 110);
		charToAscii.put('o', 111);charToAscii.put('p', 112);charToAscii.put('q', 113);charToAscii.put('r', 114);
		charToAscii.put('s', 115);charToAscii.put('t', 116);charToAscii.put('u', 117);charToAscii.put('v', 118);
		charToAscii.put('w', 119);charToAscii.put('x', 120);charToAscii.put('y', 121);charToAscii.put('z', 122);
		charToAscii.put('{', 123);charToAscii.put('|', 124);charToAscii.put('}', 125);charToAscii.put('~', 126);
		for(String key : charToAscii.keySet()){
			asciiToChar.put(charToAscii.get(key), key);	
		}
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
	
	global static Boolean isUpperCase(String character){ 
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
		if(character == null || character.length() != 1){
			throw new InvalidCharacterStringException('Invalid charcter string: ' + character);
		}
	}

	private static Boolean inAsciiRange(String character, IntegerRange range){
		return range == null ? false : range.contains(toAscii(character));
	}
	
	
}