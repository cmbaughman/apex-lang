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
global class RandomStringUtils {

    global static String random(Integer count) {
        return random(count, false, false);
    }

    global static String randomAscii(Integer count) {
        return random(count, 32, 127, false, false);
    }
    
    global static String randomAlphabetic(Integer count) {
        return random(count, true, false);
    }
    
    global static String randomAlphanumeric(Integer count) {
        return random(count, true, true);
    }
    
    global static String randomNumeric(Integer count) {
        return random(count, false, true);
    }

    global static String random(Integer count, String chars) {
        return random(count, 0, (chars == null ? 0 : chars.length()), false, false, chars);
    }

    global static String random(Integer count, boolean letters, boolean numbers) {
        return random(count, 0, 0, letters, numbers);
    }
    
    global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers) {
        return random(count, startIndex, endIndex, letters, numbers, null);
    }

    global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars) {
        if (count <= 0) {
            return '';
        }
        if(chars == null && (letters || numbers)){
            chars = '';
            startIndex = 0;
            if(letters){
                endIndex += 52;
                for(Integer i = Character.toAscii('a'), max = Character.toAscii('z'); i <= max; i++){
                    chars += Character.toChar(i);
                }    
                for(Integer i = Character.toAscii('A'), max = Character.toAscii('Z'); i <= max; i++){
                    chars += Character.toChar(i);
                }    
            }
            if(numbers){
                endIndex += 10;
                for(Integer i = Character.toAscii('0'), max = Character.toAscii('9'); i <= max; i++){
                    chars += Character.toChar(i);
                }    
            }
        }
        IntegerRange allowableRange = null;
        if(chars == null){
            allowableRange = new IntegerRange(32,127);
        } else {
            allowableRange = new IntegerRange(0,chars.length());
        }
        if(!allowableRange.contains(new IntegerRange(startIndex,endIndex))){
            startIndex = allowableRange.min();
            endIndex = allowableRange.max();
        }    

        String buffer = '';
        String ch;
        Integer gap = endIndex - startIndex;
        Integer next = 0;
        
        while (count-- > 0) {
            next = Math.round(Math.floor(Math.random()*gap)) + startIndex;
            if (chars == null) {
                ch = Character.toChar(next);
            } else {
                ch = StringUtils.charAt(chars,next);
            }
            buffer += ch;
        }
        return buffer;
    }

    private static String kHexChars = '0123456789abcdefABCDEF';
    
    /**
     * Implementation ported from Java Library at http://jug.safehaus.org
     */
    global static String randomUUID(){
        String returnValue = '';
        Integer nextByte = 0;
        for(Integer i = 0; i < 16; i++){
            if(i==4 || i==6 || i==8 || i==10){
                returnValue += '-';
            }
            //generate a "byte"; i.e., number in range [-2^7,2^7-1]
            nextByte = (Math.round(Math.random() * 255)-128) & 255;

            if(i==6){
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }
            if(i==8){
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }
            
            returnValue += StringUtils.charAt(kHexChars,nextByte >> 4);
            returnValue += StringUtils.charAt(kHexChars,nextByte & 15);
        }
        return returnValue;
    }
    
}