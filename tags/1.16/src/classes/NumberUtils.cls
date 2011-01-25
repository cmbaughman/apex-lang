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
global class NumberUtils {

    global static final Integer MAX_INTEGER = 2147483647;
    global static final Integer MIN_INTEGER = -2147483647;
    global static final IntegerRange MAX_INTEGER_RANGE = new IntegerRange(NumberUtils.MIN_INTEGER,NumberUtils.MAX_INTEGER);
    
    global static final Long MAX_LONG = 9223372036854775807L;
    global static final Long MIN_LONG = -9223372036854775807L;
    global static final LongRange MAX_LONG_RANGE = new LongRange(NumberUtils.MIN_LONG,NumberUtils.MAX_LONG);
    
    global static Integer parseInt(String str, Integer radix){
        return parseLong(str,radix).intValue();
    }
    
    global static Long parseLong(String str, Integer radix){
        str = StringUtils.upperCase(StringUtils.trim(str));
        if(StringUtils.isBlank(str)){
            throw new NumberFormatException();
        }
        if(radix < 2 || radix > 36){
            throw new IllegalArgumentException('invalid radix parameter: ' + radix + '; radix must be >= 2 and <= 36');
        }
        Boolean isNegative = false;
        if(StringUtils.startsWith(str, '-')){
            isNegative = true;
            str = StringUtils.removeStart(str, '-');
        }
        String validChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0,radix);
        if(!StringUtils.containsOnly(str,validChars)){
            throw new NumberFormatException('Invalid characters found in number: ' + str + ', with radix = ' + radix);
        }
        final Integer LENGTH = StringUtils.length(str);
        Long returnValue = 0;
        for(Integer i = 0; i < LENGTH; i++){
            returnValue +=
                (validChars.indexOf(str.substring(LENGTH-i-1,LENGTH-i))
                * Math.pow(radix,i)).longValue();
        }
        if(isNegative){
            returnValue = -returnValue;
        }
        return returnValue;
    }
    
    
    
    global static String toBinaryString(Integer i){
        return toString(i,2);
    }

    global static String toOctalString(Integer i){
        return toString(i,8);
    }
    
    global static String toHexString(Integer i){
        return toString(i,16);
    }

    global static String toString(Integer i, Integer radix){
    	if(i == null){
            return null;
    	}
    	return toString((Long)i,radix);
    }

    global static String toBinaryString(Long l){
        return toString(l,2);
    }

    global static String toOctalString(Long l){
        return toString(l,8);
    }

    global static String toHexString(Long l){
        return toString(l,16);
    }

    global static String toString(Long l, Integer radix){
    	if(l == null){
    		return null;
    	}
        if(radix < 2 || radix > 36){
            throw new IllegalArgumentException('invalid radix parameter: ' + radix + '; radix must be >= 2 and <= 36');
        }
        return (l<0 ? '-' : '') + toStringPrivate(Math.abs(l),radix,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0,radix));
    }

    private static String toStringPrivate(Long l, Integer radix, String validChars){
        Integer r = Math.mod(l,radix).intValue();
        String result;
        if(l-r == 0){ 
            result = StringUtils.charAt(validChars,r);
        }else{ 
            result = toStringPrivate(((l-r)/radix),radix,validChars) + StringUtils.charAt(validChars,r);
        }
        return result;
    	
    }

}