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

    global static final Integer MAX_INTEGER = 2147483647;//Math.round(Math.pow(2.0,31.0)-1);
    global static final Integer MIN_INTEGER = -2147483647;//Math.round(Math.pow(2.0,31.0));
    
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
    /*
    global static String toString(Integer i, Integer radix){
        return longToString(i,radix);
    }

//27
// 25/10 = 2.5 > 1
// 5/1 = 5
//27/16 = 1
// 11/1 = 9

//27
//12
//
    global static String toString(Long l, Integer radix){
        //l=27
        //radix=16
        Boolean isNegative = false;
        if(l < 0){
            isNegative = true;
            l = Math.abs(l);
        }
        String retwurnValue = '';
        final String CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Integer index = 0;
        for(Integer i = 0; i < 63; i++){
            index = 
            index = (l / Math.pow(radix,i)).intValue();
            returnValue += CHARS.substring(index,index+1);
        }
        return '-' + returnValue;
    }
    
    /*
    
    27 < f(x) = number ^ radix
    
    
    radix 10
    
    min power
    
    12 2
    11 2
    10 1
    
    */
    
    
    /*
    global static String toBinary(Long number){
        
        Integer power = 1;
        while(number > 0){
            
        }
        binary = StringUtils.trim(binary);
        if(!StringUtils.containsOnly(binary,'01')){
            throw new IllegalArgumentException('invalid binary string: ' + binary);
        }
        final String BINARY_LENGTH = StringUtils.length(binary);
        Integer position = BINARY_LENGTH;
        Long sum = 0;
        for(Integer i = 0; i<BINARY_LENGTH; i++){
            sum +=
                Integer.valueOf(binary.substring((BINARY_LENGTH - i - 1),(BINARY_LENGTH - i))
                * Math.pow(2,(StringUtils.length(binary) - position)));            
        }
        return sum;
    }
    */
}