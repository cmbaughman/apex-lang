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
/**
 * Port of the StringUtils class from Java to Apex.  This
 * class is part of the Apache Commons Lang project available
 * at http://commons.apache.org/lang/.
 */
global class StringUtils {

    global static final String EMPTY = '';
    global static final String LF = '\n';
    global static final String CR = '\r';
    global static final Integer INDEX_NOT_FOUND = -1;

    private static final Integer PAD_LIMIT = 8192;

    global static String abbreviate(String str, Integer maxWidth) {
        return abbreviate(str, 0, maxWidth);
    }

    global static String abbreviate(String str, Integer offset, Integer maxWidth) {
        if (str == null) {
            return null;
        }
        if (maxWidth < 4) { 
            throw new IllegalArgumentException('Minimum abbreviation width is 4');
        }
        if (str.length() <= maxWidth) {
            return str;
        }
        if (offset > str.length()) {
            offset = str.length();
        }
        if ((str.length() - offset) < (maxWidth - 3)) {
            offset = str.length() - (maxWidth - 3);
        }
        if (offset <= 4) {
            return str.substring(0, maxWidth - 3) + '...';
        }
        if (maxWidth < 7) {
            throw new IllegalArgumentException('Minimum abbreviation width with offset is 7');
        }
        if ((offset + (maxWidth - 3)) < str.length()) {
            return '...' + abbreviate(str.substring(offset), maxWidth - 3);
        }
        return '...' + str.substring(str.length() - (maxWidth - 3));
    } 

    global static String capitalize(String str) {
        if(isBlank(str)){
            return str;
        }
        return upperCase(str.substring(0,1)) + str.substring(1);
    }
    
    global static String center(String str, Integer size) {
        return center(str, size, ' ');
    }

    global static String center(String str, Integer size, String padStr) {
        if (str == null || size <= 0) {
            return str;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str;
        }
        str = leftPad(str, strLen + padCharCount / 2, padStr);
        str = rightPad(str, size, padStr);
        return str;
    }

    global static String charAt(String str, Integer index) {
        if(str == null){
            return null;
        }
        if(str.length() <= 0){
            return str;    
        }
        if(index < 0 || index >= str.length()){
            return null;    
        }
        return str.substring(index, index+1);
    }
    
    global static String chomp(String str) {
        if (isEmpty(str)) {
            return str;
        }

        if (str.length() == 1) {
            String ch = charAt(str,0);
            if (ch == CR || ch == LF) {
                return EMPTY;
            }
            return str;
        }

        Integer lastIdx = str.length() - 1;
        String last = charAt(str, lastIdx);

        if (LF.equals(last)) {
            if (CR.equals(charAt(str,lastIdx - 1))) {
                lastIdx--;
            }
        } else if (!CR.equals(last)) {
            lastIdx++;
        }
        return str.substring(0, lastIdx);
    }

    global static String chomp(String str, String separator) {
        if (isEmpty(str) || separator == null) {
            return str;
        }
        if (str.endsWith(separator)) {
            return str.substring(0, str.length() - separator.length());
        }
        return str;
    }

    global static String chop(String str) {
        if (str == null) {
            return null;
        }
        Integer strLen = str.length();
        if (strLen < 2) {
            return EMPTY;
        }
        Integer lastIdx = strLen - 1;
        String ret = str.substring(0, lastIdx);
        String last = charAt(str, lastIdx);
        if (LF.equals(last)) {
            if (CR.equals(charAt(ret,lastIdx - 1))) {
                return ret.substring(0, lastIdx - 1);
            }
        }
        return ret;
    }

    global static Boolean contains(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return str.indexOf(searchStr,0) >= 0;
    }
    
    global static boolean containsAny(String str, String searchChars) {
        if (str == null || str.length() == 0 || searchChars == null || searchChars.length() == 0) {
            return false;
        }
        for (Integer i = 0; i < str.length(); i++) {
            if(searchChars.contains(charAt(str, i))){
                return true;    
            }
        }
        return false;
    }

    global static Boolean containsIgnoreCase(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return contains(str.toUpperCase(), searchStr.toUpperCase());
    }
    
    global static boolean containsNone(String str, String invalidChars) {
        if (str == null || invalidChars == null) {
            return true;
        }
        Integer strSize = str.length();
        Integer invalidSize = invalidChars.length();
        for (Integer i = 0; i < strSize; i++) {
            String ch = charAt(str, i);
            if(invalidChars.contains(ch)){
                return false;
            }
        }
        return true;
    }

    global static boolean containsOnly(String str, String valid) {
        if ((valid == null) || (str == null)) {
            return false;
        }
        if (str.length() == 0) {
            return true;
        }
        if (valid.length() == 0) {
            return false;
        }
        return indexOfAnyBut(str, valid) == -1;
    }

    global static Integer countMatches(String str, String sub) {
        if (isEmpty(str) || isEmpty(sub)) {
            return 0;
        }
        Integer count = 0;
        Integer idx = 0;
        while ((idx = str.indexOf(sub, idx)) != -1) {
            count++;
            idx += sub.length();
        }
        return count;
    }

    global static String defaultIfEmpty(String str, String defaultStr) {
        return StringUtils.isEmpty(str) ? defaultStr : str;
    }
    
    global static String defaultString(String str) {
        return str == null ? EMPTY : str;
    }

    global static String defaultString(String str, String defaultStr) {
        return str == null ? defaultStr : str;
    }

    global static String deleteWhitespace(String str) {
        if (isEmpty(str)) {
            return str;
        }
        String returnString = '';
        String currentChar = null;
        for (Integer i = 0; i < str.length(); i++) {
            currentChar = charAt(str,i);
            if (!Character.isWhitespace(currentChar)) {
                returnString += currentChar;
            }
        }
        return returnString;
    }

    global static String difference(String str1, String str2) {
        //'abc',''
        if (str1 == null) {
            return str2;
        }
        if (str2 == null) {
            return str1;
        }
        Integer at = indexOfDifference(str1, str2);
        if (at == -1) {
            return EMPTY;
        }
        if(at == 0){
            return str2;
        }
        return str2.substring(at);
    }

    global static Integer indexOfDifference(String str1, String str2) {
        if (str1 == str2) {
            return -1;
        }
        if (str1 == null || str2 == null) {
            return 0;
        }
        Integer i;
        for (i = 0; i < str1.length() && i < str2.length(); ++i) {
            if (charAt(str1,i) != charAt(str2,i)) {
                break;
            }
        }
        //if (i < str2.length() || i < str1.length()) {
            return i;
        //}
        //return -1;
    }
    
    global static Integer indexOfDifference(String[] strs) {
        if (strs == null || strs.size() <= 1) {
            return -1;
        }
        Boolean anyStringNull = false;
        Boolean allStringsNull = true;
        Integer listSize = strs.size();
        Integer shortestStrLen = NumberUtils.MAX_INTEGER;
        Integer longestStrLen = 0;

        // find the min and max string lengths; this avoids checking to make
        // sure we are not exceeding the length of the string each time through
        // the bottom loop.
        for (Integer i = 0; i < listSize; i++) {
            if (strs.get(i) == null) {
                anyStringNull = true;
                shortestStrLen = 0;
            } else {
                allStringsNull = false;
                shortestStrLen = Math.min(strs.get(i).length(), shortestStrLen);
                longestStrLen = Math.max(strs.get(i).length(), longestStrLen);
            }
        }

        // handle lists containing all nulls or all empty strings
        if (allStringsNull || (longestStrLen == 0 && !anyStringNull)) {
            return -1;
        }

        // handle lists containing some nulls or some empty strings
        if (shortestStrLen == 0) {
            return 0;
        }

        // find the position with the first difference across all strings
        Integer firstDiff = -1;
        for (Integer stringPos = 0; stringPos < shortestStrLen; stringPos++) {
            String comparisonChar = charAt(strs.get(0), stringPos);
            for (Integer arrayPos = 1; arrayPos < listSize; arrayPos++) {
                if (charAt(strs.get(arrayPos),stringPos) != comparisonChar) {
                    firstDiff = stringPos;
                    break;
                }
            }
            if (firstDiff != -1) {
                break;
            }
        }

        if (firstDiff == -1 && shortestStrLen != longestStrLen) {
            // we compared all of the characters up to the length of the
            // shortest string and didn't find a match, but the string lengths
            // vary, so return the length of the shortest string.
            return shortestStrLen;
        }
        return firstDiff;
    }
    

    global static Boolean equals(String str1, String str2) {
        return str1 == null ? str2 == null : str1.equals(str2);
    }

    global static Boolean equalsIgnoreCase(String str1, String str2) {
        return str1 == null ? str2 == null : str1.equalsIgnoreCase(str2);
    }

    global static Integer indexOf(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return -1;
        }
        return str.indexOf(searchStr);
    }

    global static Integer indexOf(String str, String searchStr, Integer startPos) {
        if (str == null || searchStr == null) {
            return -1;
        }
        if (searchStr.length() == 0 && startPos >= str.length()) {
            return str.length();
        }
        return str.indexOf(searchStr, startPos);
    }

    global static Integer ordinalIndexOf(String str, String searchStr, Integer ordinal) {
        //'','',-1
        if (str == null || searchStr == null || ordinal <= 0) {
            return INDEX_NOT_FOUND;
        }
        if (searchStr.length() == 0) {
            return 0;
        }
        Integer found = 0;
        Integer index = INDEX_NOT_FOUND;
        do {
            index = str.indexOf(searchStr, index + 1);
            if (index < 0) {
                return index;
            }
            found++;
        } while (found < ordinal);
        return index;
    }

    global static String getCommonPrefix(String[] strs) {
        if (strs == null || strs.size() == 0) {
            return EMPTY;
        }
        Integer smallestIndexOfDiff = indexOfDifference(strs);
        if (smallestIndexOfDiff == -1) {
            // all strings were identical
            if (strs.get(0) == null) {
                return EMPTY;
            }
            return strs.get(0);
        } else if (smallestIndexOfDiff == 0) {
            // there were no common initial characters
            return EMPTY;
        } else {
            // we found a common initial character sequence
            return strs.get(0).substring(0, smallestIndexOfDiff);
        }
    }  
    
    global static Integer getLevenshteinDistance(String s, String t) {
        if (s == null || t == null) {
            throw new IllegalArgumentException('Strings must not be null');
        }

        /*
           The difference between this impl. and the previous is that, rather 
           than creating and retaining a matrix of size s.length()+1 by t.length()+1, 
           we maintain two single-dimensional arrays of length s.length()+1.  The first, d,
           is the 'current working' distance array that maintains the newest distance cost
           counts as we iterate through the characters of String s.  Each time we increment
           the index of String t we are comparing, d is copied to p, the second int[].  Doing so
           allows us to retain the previous cost counts as required by the algorithm (taking 
           the minimum of the cost count to the left, up one, and diagonally up and to the left
           of the current cost count being calculated).  (Note that the arrays aren't really 
           copied anymore, just switched...this is clearly much better than cloning an array 
           or doing a System.arraycopy() each time  through the outer loop.)

           Effectively, the difference between the two implementations is this one does not 
           cause an out of memory condition when calculating the LD over two very large strings.
         */

        Integer n = s.length(); // length of s
        Integer m = t.length(); // length of t

        if (n == 0) {
            return m;
        } else if (m == 0) {
            return n;
        }

        if (n > m) {
            // swap the input strings to consume less memory
            String tmp = s;
            s = t;
            t = tmp;
            n = m;
            m = t.length();
        }

        Integer[] p = new Integer[n+1]; //'previous' cost array, horizontally
        Integer[] d = new Integer[n+1]; // cost array, horizontally
        Integer[] dSwap; //placeholder to assist in swapping p and d

        // indexes into strings s and t
        Integer i; // iterates through s
        Integer j; // iterates through t

        String t_j; // jth character of t

        Integer cost; // cost

        for (i = 0; i<=n; i++) {
            p[i] = i;
        }

        for (j = 1; j<=m; j++) {
            t_j = charAt(t,j-1);
            d[0] = j;

            for (i=1; i<=n; i++) {
                cost = charAt(s,i-1)==t_j ? 0 : 1;
                // minimum of cell to the left+1, to the top+1, diagonally left and up +cost
                d[i] = Math.min(Math.min(d[i-1]+1, p[i]+1),  p[i-1]+cost);
            }

            // copy current distance counts to 'previous row' distance counts
            dSwap = p;
            p = d;
            d = dSwap;
        }

        // our last action in the above loop was to switch d and p, so p now 
        // actually has the most recent cost counts
        return p[n];
    }

    global static Integer indexOfAnyBut(String str, String searchChars) {
        if (isEmpty(str) || searchChars == null) {
            return -1;
        }
        for (Integer i = 0; i < str.length(); i++) {
            if(searchChars.contains(charAt(str,i))){
                continue;    
            }
            return i;
        }
        return -1;
    }

    global static Boolean endsWith(String str, String suffix) {
        return endsWith(str, suffix, false);
    }
    
    private static Boolean endsWith(String str, String suffix, Boolean ignoreCase) {
        if (str == null || suffix == null) {
            return (str == null && suffix == null);
        }
        if (suffix.length() > str.length()) {
            return false;
        }
        Integer strOffset = str.length() - suffix.length();
        String ending = str.substring(strOffset, str.length());
        if(ignoreCase){
            return suffix.equalsIgnoreCase(ending);
        }
        return suffix.equals(ending);
    }
    
    global static Boolean endsWithIgnoreCase(String str, String suffix) {
        return endsWith(str, suffix, true);
    }
    
    global static Integer indexOfAny(String str, String searchChars) {
        if (isEmpty(str) || searchChars == null) {
            return -1;
        }
        for (Integer i = 0; i < str.length(); i++) {
            String ch = charAt(str,i);
            for (Integer j = 0; j < searchChars.length(); j++) {
                if (charAt(searchChars,j) == ch) {
                    return i;
                }
            }
        }
        return -1;
    }

    global static Integer indexOfAny(String str, String[] searchStrs) {
        if (str == null || searchStrs == null || searchStrs.size() == 0) {
            return -1;
        }
        Integer returnIndexOf = NumberUtils.MAX_INTEGER;

        Integer currentIndexOf = 0;
        for(String searchStr : searchStrs){
            if (searchStr == null) {
                continue;
            }
            currentIndexOf = str.indexOf(searchStr);
            if (currentIndexOf == -1) {
                continue;
            }

            if (currentIndexOf < returnIndexOf) {
                returnIndexOf = currentIndexOf;
            }
        }

        return (returnIndexOf == NumberUtils.MAX_INTEGER) ? -1 : returnIndexOf;
    }
     
    global static boolean isAlpha(String str) {
        if (str == null) {
            return false;
        }
        Integer size = str.length();
        for (Integer i = 0; i < size; i++) {
            if (Character.isLetter(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }

    global static boolean isAlphaSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((Character.isLetter(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    global static boolean isAlphanumeric(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (Character.isLetterOrDigit(charAt(str,i)) == false) {
                return false;
            }
        } 
        return true;
    }

    global static boolean isAlphanumericSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((Character.isLetterOrDigit(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    global static boolean isAsciiPrintable(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (Character.isAsciiPrintable(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }

    global static boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (Character.isDigit(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }

    global static boolean isNumericSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((Character.isDigit(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    global static boolean isWhitespace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((Character.isWhitespace(charAt(str,i)) == false)) {
                return false;
            }
        }
        return true;
    }
    
    global static boolean isBlank(String str) {
        return str == null || str.trim() == null || str.trim().length() == 0;
    }
    
    global static boolean isNotBlank(String str) {
        return !isBlank(str);
    }
    
    global static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    global static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    global static String joinArray(Object[] objectArray) {
        return joinArray(objectArray, null);
    }
    
    global static String joinArray(Object[] objectArray, String separator) {
        if (objectArray == null) {
            return null;
        }
        return joinArray(objectArray, separator, 0, objectArray.size());
    }

    global static String joinArray(Object[] objectArray, String separator, Integer startIndex, Integer endIndex) {
        if (objectArray == null) {
            return null;
        }
        if (separator == null) {
            separator = EMPTY;
        }

        String buf = '';
        if(startIndex < 0){
            startIndex = 0;
        }
        Boolean isFirst = true;
        for (Integer i = startIndex; i < endIndex && i < objectArray.size(); i++) {
            if(objectArray[i] != null) {
	            if(isFirst){
	                isFirst = false;
	            } else {
	                buf += separator;
	            }
	            buf += objectArray[i];
            }
        }
        return buf;
    }

    global static String joinStrings(Set<String> strings, String separator){
    	return joinSet(strings,separator);
    }

    global static String joinSet(Set<Blob> blobSet, String separator){ 
        return joinSet(SetUtils.blobToObject(blobSet),separator);
    }

    global static String joinSet(Set<Boolean> booleanSet, String separator){ 
        return joinSet(SetUtils.booleanToObject(booleanSet),separator);
    }

    global static String joinSet(Set<Date> dateSet, String separator){ 
        return joinSet(SetUtils.dateToObject(dateSet),separator);
    }

    global static String joinSet(Set<Datetime> datetimeSet, String separator){ 
        return joinSet(SetUtils.datetimeToObject(datetimeSet),separator);
    }

    global static String joinSet(Set<Decimal> decimalSet, String separator){ 
        return joinSet(SetUtils.decimalToObject(decimalSet),separator);
    }

    global static String joinSet(Set<Double> doubleSet, String separator){ 
        return joinSet(SetUtils.doubleToObject(doubleSet),separator);
    }

    global static String joinSet(Set<ID> idSet, String separator){ 
        return joinSet(SetUtils.idToObject(idSet),separator);
    }

    global static String joinSet(Set<Integer> integerSet, String separator){ 
        return joinSet(SetUtils.integerToObject(integerSet),separator);
    }

    global static String joinSet(Set<Long> longSet, String separator){ 
        return joinSet(SetUtils.longToObject(longSet),separator);
    }

    global static String joinSet(Set<Time> timeSet, String separator){ 
        return joinSet(SetUtils.timeToObject(timeSet),separator);
    }

    global static String joinSet(Set<String> stringSet, String separator){ 
        return joinSet(SetUtils.stringToObject(stringSet),separator);
    }

    global static String joinSet(Set<Object> objectSet, String separator){
        if(objectSet == null || objectSet.size() == 0){
            return null;
        }
        Boolean isFirst = true;
        String returnString = '';
        for(Object anObject : objectSet){
            if(StringUtils.isBlank(''+anObject)){
                continue;
            }
            if(isFirst){
                isFirst = false;
            }else{
                if(separator != null){
                    returnString += separator;
                }
            }
            if(anObject instanceof Blob){ returnString += '' + ((Blob)anObject).toString() + '';
            } else if(anObject instanceof Boolean){ returnString += ((Boolean)anObject);
            } else if(anObject instanceof Date){ returnString += '' + ((Date)anObject) + '';
            } else if(anObject instanceof Datetime){ returnString += '' + ((Datetime)anObject) + '';
            } else if(anObject instanceof Integer){ returnString += ((Integer)anObject);
            } else if(anObject instanceof Long){ returnString += ((Long)anObject);
            } else if(anObject instanceof Decimal){ returnString += ((Decimal)anObject);
            //} else if(anObject instanceof Double){ returnString += ((Double)anObject);
            } else if(anObject instanceof String){ returnString += '' + ((String)anObject) + '';
            //} else if(anObject instanceof ID){ returnString += '' + ((ID)anObject) + '';
            } else if(anObject instanceof Time){ returnString += '' + ((Time)anObject) + '';}
        }    
        return returnString;
    }
    
    global static String joinStrings(List<String> strings, String separator){
        if(strings == null || strings.size() == 0){
            return null;
        }
        Set<String> setToJoin = new Set<String>();
        for(String value : strings){
            setToJoin.add(value);    
        }
        return joinStrings(setToJoin,separator);
    }
    
    global static Integer lastIndexOf(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return -1;
        }
        return str.lastIndexOf(searchStr);
    }

    global static Integer lastIndexOf(String str, String searchStr, Integer startPos) {
        if (str == null || searchStr == null || startPos < 0) {
            return -1;
        }
        return lastIndexOf(substring(str,0,startPos+1), searchStr);
    }

    global static Integer lastIndexOfAny(String str, String[] searchStrs) {
        if ((str == null) || (searchStrs == null)) {
            return -1;
        }
        Integer sz = searchStrs.size();
        Integer ret = -1;
        Integer tmp = 0;
        for (Integer i = 0; i < sz; i++) {
            String searchStr = searchStrs[i];
            if (searchStr == null) {
                continue;
            }
            tmp = str.lastIndexOf(searchStr);
            if (tmp > ret) {
                ret = tmp;
            }
        }
        return ret;
    }

    global static String left(String str, Integer len) {
        if (str == null) {
            return null;
        }
        if (len < 0) {
            return EMPTY;
        }
        if (str.length() <= len) {
            return str;
        }
        return str.substring(0, len);
    }

    global static String mid(String str, Integer pos, Integer len) {
        if (str == null) {
            return null;
        }
        if (len < 0 || pos >= str.length()) {
            return EMPTY;
        }
        if (pos < 0) {
            pos = 0;
        }
        if (str.length() <= (pos + len)) {
            return str.substring(pos);
        }
        return str.substring(pos, pos + len);
    }

    global static String overlay(String str, String overlay, Integer startIndex, Integer endIndex) {
        //'', 'abc', 0, 0
        if (str == null) {
            return null;
        }
        if (overlay == null) {
            overlay = EMPTY;
        }
        Integer len = str.length();
        if (startIndex < 0) {
            startIndex = 0;
        }
        if (startIndex > len) {
            startIndex = len;
        }
        if (endIndex < 0) {
            endIndex = 0;
        }
        if (endIndex > len) {
            endIndex = len;
        }
        if (startIndex > endIndex) {
            Integer temp = startIndex;
            startIndex = endIndex;
            endIndex = temp;
        }
        return new StringBuffer()
            .append(substring(str, 0, startIndex))
            .append(overlay)
            .append(substring(str, endIndex))
            .toStr();
    }
    
    global static String leftPad(String str, Integer size) {
        return leftPad(str, size, ' ');
    }

    global static String leftPad(String str, Integer size, String padStr) {
        if (str == null) {
            return null;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer padLen = padStr.length();
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str;
        }
        if (padCharCount == padLen) {
            return padStr + str;
        } else if (padCharCount < padLen) {
            return padStr.substring(0, padCharCount) + str;
        } else {
            String padding = '';
            for (Integer i = 0; i < padCharCount; i++) {
                padding += padStr.substring(Math.mod(i,padLen),Math.mod(i,padLen)+1);
            }
            return padding + str;
        }
    }

    global static Integer length(String str) {
        return str == null ? 0 : str.length();
    }    
    
    global static String lowerCase(String str) {
        if(str == null){
            return null;
        }
        return str.toLowerCase();
    }
    
    global static String remove(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        return replace(str, remove, EMPTY, -1);
    }

    global static String removeStart(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (str.startsWith(remove)){
        	if(remove.length() >= str.length()){
                return '';        		
        	} else {
                return str.substring(remove.length());
        	}
        }
        return str;
    }

    global static String removeStartIgnoreCase(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (startsWithIgnoreCase(str, remove)) {
            return str.substring(remove.length());
        }
        return str;
    }
    
    global static String removeEnd(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (str.endsWith(remove)) {
            return str.substring(0, str.length() - remove.length());
        }
        return str;
    }

    global static String removeEndIgnoreCase(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (endsWithIgnoreCase(str, remove)) {
            return str.substring(0, str.length() - remove.length());
        }
        return str;
    }

    global static String repeat(String str, Integer repeat) {
        if (str == null) {
            return null;
        }
        if (repeat <= 0) {
            return EMPTY;
        }
        Integer inputLength = str.length();
        if (repeat == 1 || inputLength == 0) {
            return str;
        }
        if (inputLength == 1 && repeat <= PAD_LIMIT) {
            return padding(repeat, charAt(str,0));
        }

        String buf = '';
        for (Integer i = 0; i < repeat; i++) {
            buf += str;
        }
        return buf;
/*        Integer outputLength = inputLength * repeat;
        if(inputLength == 1){
            String ch = charAt(str,0);
            String output1 = '';
            for (Integer i = repeat - 1; i >= 0; i--) {
                output1 += ch;
            }
            return output1;
        } else if(inputLength == 2){
            String ch0 = charAt(str,0);
            String ch1 = charAt(str,1);
            String output2 = '';
            for (Integer i = repeat * 2 - 2; i >= 0; i=i-2) {
                output2 += ch0;
                output2 += ch1;
            }
            return output2;
        } else {
        }*/
    }

    private static String padding(Integer repeat, String padChar){
        String buf = '';
        for (Integer i = 0; i < repeat; i++) {
            buf += padChar;
        }
        return buf;
    }

    global static String replace(String text, String searchString, String replacement) {
        return replace(text, searchString, replacement, -1);
    }

    global static String replaceOnce(String text, String searchString, String replacement) {
        return replace(text, searchString, replacement, 1);
    }

    global static String replace(String text, String searchString, String replacement, Integer max) {
        //'aba', 'a', '', -1
        if (isEmpty(text) || isEmpty(searchString) || replacement == null || max == 0) {
            return text;
        }
        Integer startIndex = 0;
        Integer endIndex = indexOf(text, searchString, startIndex);
        if (endIndex == -1) {
            return text;
        }
        Integer replLength = searchString.length();
        Integer increase = replacement.length() - replLength;
        increase = (increase < 0 ? 0 : increase);
        increase *= (max < 0 ? 16 : (max > 64 ? 64 : max));
        StringBuffer buf = new StringBuffer(); 
        while (endIndex != -1) {
            buf.append(substring(text, startIndex, endIndex)).append(replacement);
            startIndex = endIndex + replLength;
            if (--max == 0) {
                break;
            }
            endIndex = indexOf(text, searchString, startIndex);
        }
        buf.append(substring(text, startIndex));
        return buf.toStr();
    }

    global static String replaceEach(String text, String[] searchList, String[] replacementList) {
        return replaceEach(text, searchList, replacementList, false, 0);
    } 

    global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList,
        Boolean repeat) {
        Integer timeToLive = 0;
        if(searchList != null) timeToLive = searchList.size();
        return replaceEach(text, searchList, replacementList, repeat, timeToLive);
    }
    
 
    global static String replaceEach(
        String text, 
        String[] searchList, 
        String[] replacementList, 
        boolean repeat, 
        Integer timeToLive){
    
        // mchyzer Performance note: This creates very few new objects (one major goal)
        // let me know if there are performance requests, we can create a harness to measure

        if (text == null || text.length() == 0 || searchList == null || 
            searchList.size() == 0 || replacementList == null || replacementList.size() == 0){
            return text;
        }

        // if recursing, this shouldnt be less than 0
        if (timeToLive < 0) {
            throw new IllegalStateException('TimeToLive of ' + timeToLive + ' is less than 0: ' + text);
        } 

        Integer searchLength = searchList.size();
        Integer replacementLength = replacementList.size();

        // make sure lengths are ok, these need to be equal
        if (searchLength != replacementLength) {
            throw new IllegalArgumentException('Search and Replace array lengths don\'t match: '
                + searchLength
                + ' vs '
                + replacementLength);
        }

        // keep track of which still have matches
        boolean[] noMoreMatchesForReplIndex = new boolean[searchLength];
        for(Integer i = 0; i < noMoreMatchesForReplIndex.size(); i++){
            noMoreMatchesForReplIndex[i] = false;
        }

        // index on index that the match was found
        Integer textIndex = -1;
        Integer replaceIndex = -1;
        Integer tempIndex = -1;

        // index of replace array that will replace the search string found
        // NOTE: logic duplicated below START
        for (Integer i = 0; i < searchLength; i++) {
            if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
                searchList[i].length() == 0 || replacementList[i] == null) 
            {
                continue;
            }
            tempIndex = indexOf(text,searchList[i]);

            // see if we need to keep searching for this
            if (tempIndex == -1) {
                noMoreMatchesForReplIndex[i] = true;
            } else {
                if (textIndex == -1 || tempIndex < textIndex) {
                    textIndex = tempIndex;
                    replaceIndex = i;
                }
            }
        }
        // NOTE: logic mostly below END

        // no search strings found, we are done
        if (textIndex == -1) {
            return text;
        }

        Integer start = 0;

        StringBuffer buf = new StringBuffer();

        while (textIndex != -1) {

            for (Integer i = start; i < textIndex; i++) {
                buf.append(charAt(text,i));
            }
            buf.append(replacementList[replaceIndex]);

            start = textIndex + searchList[replaceIndex].length();

            textIndex = -1;
            replaceIndex = -1;
            tempIndex = -1;
            // find the next earliest match
            // NOTE: logic mostly duplicated above START
            for (Integer i = 0; i < searchLength; i++) {
                if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
                    searchList[i].length() == 0 || replacementList[i] == null){
                    continue;
                }
                tempIndex = indexOf(text, searchList[i], start);

                // see if we need to keep searching for this
                if (tempIndex == -1) {
                    noMoreMatchesForReplIndex[i] = true;
                } else {
                    if (textIndex == -1 || tempIndex < textIndex) {
                        textIndex = tempIndex;
                        replaceIndex = i;
                    }
                }
            }
            // NOTE: logic duplicated above END

        }
        Integer textLength = text.length();
        for (Integer i = start; i < textLength; i++) {
            buf.append(charAt(text,i));
        }
        String result = buf.toStr();
        if (!repeat) {
            return result;
        }

        return replaceEach(result, searchList, replacementList, repeat, timeToLive - 1);
    }
    
    global static String replaceChars(String str, String searchChars, String replaceChars) {
        if (isEmpty(str) || isEmpty(searchChars)) {
            return str;
        }
        if (replaceChars == null) {
            replaceChars = EMPTY;
        }
        Boolean modified = false;
        Integer replaceCharsLength = replaceChars.length();
        Integer strLength = str.length();
        String buf = '';
        for (Integer i = 0; i < strLength; i++) {
            String ch = charAt(str,i);
            Integer index = indexOf(searchChars,ch);
            if (index >= 0) {
                modified = true;
                if (index < replaceCharsLength) {
                    buf += charAt(replaceChars,index);
                }
            } else {
                buf += ch;
            }
        }
        if (modified) {
            return buf;
        }
        return str;
    }

   global static String reverse(String str) {
        if (str == null) {
            return null;
        }
        String returnString = '';
        for(Integer i = (str.length()-1); i >= 0; i--){
            returnString += charAt(str,i);
        }
        return returnString;
    }

    global static String reverseDelimited(String str, String separatorChar) {
        if (str == null) {
            return null;
        }
        if(separatorChar == null){
            separatorChar = ' ';    
        }
        Character.validateChar(separatorChar);
        return joinArray(ArrayUtils.reverse(split(str,separatorChar)),separatorChar);
    }
    
    global static String right(String str, Integer len) {
        if (str == null) {
            return null;
        }
        if (len <= 0) {
            return EMPTY;
        }
        if (str.length() <= len) {
            return str;
        }
        return str.substring(str.length() - len);
    }

    global static String rightPad(String str, Integer size) {
        return rightPad(str, size, ' ');
    }

    global static String rightPad(String str, Integer size, String padStr) {
        if (str == null) {
            return null;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer padLen = padStr.length();
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str; // returns original String when possible
        }

        if (padCharCount == padLen) {
            return str + padStr;
        } else if (padCharCount < padLen) {
            return str + padStr.substring(0, padCharCount);
        } else {
            String padding = '';
            for (Integer i = 0; i < padCharCount; i++) {
                padding += padStr.substring(Math.mod(i,padLen),Math.mod(i,padLen)+1);
            }
            return str + padding;
        }
    }
    
    global static String swapCase(String str) {
        if (isBlank(str)) {
            return str;
        }
        String buffer = '';
        String ch;
        for (Integer i = 0; i < str.length(); i++) {
            ch = str.substring(i,i+1);
            if (Character.isUpperCase(ch)) {
                ch = lowerCase(ch);
            } else if (Character.isLowerCase(ch)) {
                ch = upperCase(ch);
            }
            buffer += ch;
        }
        return buffer;
    }
    
    global static boolean startsWithIgnoreCase(String str, String prefix) {
        return startsWith(str, prefix, true);
    }

    global static boolean startsWith(String str, String prefix) {
        return startsWith(str, prefix, false);
    }

    private static boolean startsWith(String str, String prefix, boolean ignoreCase) {
        if (str == null || prefix == null) {
            return (str == null && prefix == null);
        }
        if (prefix.length() > str.length()) {
            return false;
        }
        return regionMatches(str, ignoreCase, 0, prefix, 0, prefix.length());
    }  
    
    global static boolean regionMatches(String str, Integer toffset, String other, Integer ooffset, Integer len){
        return regionMatches(str,false,toffset,other,ooffset,len);
    }
    
    global static boolean regionMatchesIgnoreCase(String str, Integer toffset, String other, Integer ooffset, Integer len){
        return regionMatches(str,true,toffset,other,ooffset,len);
    }

    global static boolean regionMatches(String str, boolean ignoreCase,
        Integer toffset, String other, Integer ooffset, Integer len){
        
        str = substring(str,toffset,toffset+len);
        other = substring(other,ooffset,ooffset+len);
        if(ignoreCase){
            return equalsIgnoreCase(str, other);            
        }
        return equals(str, other);
                                 
    }
    global static String[] split(String str) {
        return split(str, null, -1);
    }

    global static String[] split(String str, String separatorChars) {
        return splitWorker(str, separatorChars, -1, false);
    }

    global static String[] split(String str, String separatorChars, Integer max) {
        return splitWorker(str, separatorChars, max, false);
    }   
    
    global static String[] splitPreserveAllTokens(String str) {
        return splitWorker(str, null, -1, true);
    }

    global static String[] splitPreserveAllTokens(String str, String separatorChars) {
        return splitWorker(str, separatorChars, -1, true);
    }

    global static String[] splitPreserveAllTokens(String str, String separatorChars, Integer max) {
        return splitWorker(str, separatorChars, max, true);
    }        
    
    private static String[] splitWorker(
        String str, String separatorChars, 
        Integer max, boolean preserveAllTokens) {
            
        //' abc ',null, -1, true

        if (str == null) {return null;}
        Integer len = str.length();
        if (len == 0) { return new String[]{}; }

        List<String> theList = new List<String>();
        Integer sizePlus1 = 1;
        Integer i = 0, start = 0;
        boolean match = false;
        boolean lastMatch = false;
        if (separatorChars == null) {
            // Null separator means use whitespace
            while (i < len) {
                if (Character.isWhitespace(charAt(str,i))) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        if(start == i){
                            theList.add('');
                        } else {
                            theList.add(str.substring(start, i));
                        }
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        } else if (separatorChars.length() == 1) {
            // Optimise 1 character case
            String sep = charAt(separatorChars,0);
            while (i < len) {
                if (charAt(str,i) == sep) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        if(start == i){
                            theList.add('');
                        } else {
                            theList.add(str.substring(start, i));
                        }
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        } else {
            // standard case
            while (i < len) {
                if (separatorChars.indexOf(charAt(str,i)) >= 0) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        theList.add(start == i ? '' : str.substring(start, i));
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        }
        if (match || (preserveAllTokens && lastMatch)) {
            if(start == i){
                theList.add('');
            } else {
                theList.add(str.substring(start, i));
            }
        }
        return theList;
    }    
    
    global static String[] splitByWholeSeparator(String str, String separator) {
        return splitByWholeSeparatorWorker( str, separator, -1, false ) ;
    }

    global static String[] splitByWholeSeparator(String str, String separator, Integer max ) {
        return splitByWholeSeparatorWorker(str, separator, max, false);
    }

    global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator) {
        return splitByWholeSeparatorWorker(str, separator, -1, true);
    }

    global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator, Integer max) {
        return splitByWholeSeparatorWorker(str, separator, max, true);
    }
     
    private static String[] splitByWholeSeparatorWorker(
        String str, String separator, 
        Integer max, boolean preserveAllTokens){
            
        if (str == null) {return null;}
        Integer len = str.length();
        if (len == 0) { return new String[]{}; }

        if ((separator == null) || (EMPTY.equals(separator))) {
            // Split on whitespace.
            return splitWorker(str, null, max, preserveAllTokens);
        }
        Integer separatorLength = separator.length();

        List<String> substrings = new List<String>();
        Integer numberOfSubstrings = 0;
        Integer begIndex = 0;
        Integer endIndex = 0;
        while (endIndex < len) {
            endIndex = str.indexOf(separator, begIndex);

            if (endIndex > -1) {
                if (endIndex > begIndex) {
                    numberOfSubstrings += 1;

                    if (numberOfSubstrings == max) {
                        endIndex = len;
                        substrings.add(str.substring(begIndex));
                    } else {
                        // The following is OK, because String.substring( begIndex, endIndex ) excludes
                        // the character at the position 'endIndex'.
                        substrings.add(str.substring(begIndex, endIndex));

                        // Set the starting point for the next search.
                        // The following is equivalent to begIndex = endIndex + (separatorLength - 1) + 1,
                        // which is the right calculation:
                        begIndex = endIndex + separatorLength;
                    }
                } else {
                    // We found a consecutive occurrence of the separator, so skip it.
                    if (preserveAllTokens) {
                        numberOfSubstrings += 1;
                        if (numberOfSubstrings == max) {
                            endIndex = len;
                            substrings.add(str.substring(begIndex));
                        } else {
                            substrings.add(EMPTY);
                        }
                    }
                    begIndex = endIndex + separatorLength;
                }
            } else {
                // String.substring( begIndex ) goes from 'begIndex' to the endIndex of the String.
                substrings.add(str.substring(begIndex));
                endIndex = len;
            }
        }

        return substrings;
    }    
    
    global static String[] splitByCharacterType(String str) {
        return splitByCharacterType(str, false);
    }

    global static String[] splitByCharacterTypeCamelCase(String str) {
        return splitByCharacterType(str, true);
    }

    private static String[] splitByCharacterType(String str, boolean camelCase) {
        if (str == null) {
            return null;
        }
        if (str.length() == 0) {
            return ArrayUtils.EMPTY_STRING_ARRAY;
        }
        List<String> aList = new List<String>();
        Integer tokenStart = 0;
        Integer currentType = Character.getType(charAt(str,tokenStart));
        for (Integer pos = tokenStart + 1; pos < str.length(); pos++) {
            Integer theType = Character.getType(charAt(str,pos));
            if (theType == currentType) {
                continue;
            } 
            if (camelCase && theType == Character.LOWERCASE_LETTER && currentType == Character.UPPERCASE_LETTER) {
                Integer newTokenStart = pos - 1;
                if (newTokenStart != tokenStart) {
                    aList.add(substring(str,tokenStart, newTokenStart));
                    tokenStart = newTokenStart;
                }
            } else {
                aList.add(substring(str, tokenStart, pos));
                tokenStart = pos;
            }
            currentType = theType;
        }
        aList.add(substring(str, tokenStart, str.length()));
        return aList;
    }

    global static String strip(String str) {
        return strip(str, null);
    }
    
    global static String stripToNull(String str) {
        if (str == null) {
            return null;
        }
        str = strip(str, null);
        return str.length() == 0 ? null : str;
    }

    global static String stripToEmpty(String str) {
        return str == null ? EMPTY : strip(str, null);
    }

    global static String strip(String str, String stripChars) {
        if (isEmpty(str)) {
            return str;
        }
        str = stripStart(str, stripChars);
        return stripEnd(str, stripChars);
    }

    global static String stripStart(String str, String stripChars) {
        Integer strLen;
        if (str == null || (strLen = str.length()) == 0) {
            return str;
        }
        Integer start = 0;
        if (stripChars == null) {
            while ((start != strLen) && Character.isWhitespace(charAt(str,start))) {
                start++;
            }
        } else if (stripChars.length() == 0) {
            return str;
        } else {
            while ((start != strLen) && (stripChars.indexOf(charAt(str,start)) != -1)) {
                start++;
            }
        }
        return substring(str,start);
    }

    global static String stripEnd(String str, String stripChars) {
        Integer endIndex;
        if (str == null || (endIndex = str.length()) == 0) {
            return str;
        }

        if (stripChars == null) {
            while ((endIndex != 0) && Character.isWhitespace(charAt(str,endIndex - 1))) {
                endIndex--;
            }
        } else if (stripChars.length() == 0) {
            return str;
        } else {
            while ((endIndex != 0) && (stripChars.indexOf(charAt(str,endIndex - 1)) != -1)) {
                endIndex--;
            }
        }
        return substring(str, 0, endIndex);
    }

    global static String[] stripAll(String[] strs) {
        return stripAll(strs, null);
    }

    global static String[] stripAll(String[] strs, String stripChars) {
        Integer strsLen;
        if (strs == null || (strsLen = strs.size()) == 0) {
            return strs;
        }
        String[] newArr = new String[strsLen];
        for (Integer i = 0; i < strsLen; i++) {
            newArr[i] = strip(strs[i], stripChars);
        }
        return newArr;
    }
    
    global static String substring(String str, Integer startIndex) {
        if (str == null) {
            return null;
        }
        // handle negatives, which means last n characters
        if (startIndex < 0) {
            startIndex = str.length() + startIndex; // remember startIndex is negative
        }
        if (startIndex < 0) {
            startIndex = 0;
        }
        if (startIndex >= str.length()) {
            return EMPTY;
        }
        return str.substring(startIndex);
    }

    global static String substring(String str, Integer startIndex, Integer endIndex) {
        if (str == null) {
            return null;
        }
        // handle negatives
        if (endIndex < 0) {
            endIndex = str.length() + endIndex; // remember endIndex is negative
        }
        if (startIndex < 0) {
            startIndex = str.length() + startIndex; // remember startIndex is negative
        }

        // check length next
        if (endIndex > str.length()) {
            endIndex = str.length();
        }

        // if startIndex is greater than endIndex, return ''
        if (startIndex >= endIndex) {
            return EMPTY;
        }

        if (startIndex < 0) {
            startIndex = 0;
        }
        if (endIndex < 0) {
            endIndex = 0;
        }
        return str.substring(startIndex, endIndex);
    }
    
    global static String substringBefore(String str, String separator) {
        if (isEmpty(str) || separator == null) {
            return str;
        }
        if (separator.length() == 0) {
            return EMPTY;
        }
        Integer pos = str.indexOf(separator);
        if (pos == -1) {
            return str;
        }
        return substring(str, 0, pos);
    }
    
    global static String substringAfter(String str, String separator) {
        if (isEmpty(str)) {
            return str;
        }
        if (separator == null) {
            return EMPTY;
        }
        Integer pos = str.indexOf(separator);
        if (pos == -1) {
            return EMPTY;
        }
        return substring(str, pos + separator.length());
    }

    global static String substringBeforeLast(String str, String separator) {
        if (isEmpty(str) || isEmpty(separator)) {
            return str;
        }
        Integer pos = str.lastIndexOf(separator);
        if (pos == -1) {
            return str;
        }
        return substring(str, 0, pos);
    }

    global static String substringAfterLast(String str, String separator) {
        if (isEmpty(str)) {
            return str;
        }
        if (isEmpty(separator)) {
            return EMPTY;
        }
        Integer pos = str.lastIndexOf(separator);
        if (pos == -1 || pos == (str.length() - separator.length())) {
            return EMPTY;
        }
        return substring(str, pos + separator.length());
    }

    global static String substringBetween(String str, String tag) {
        return substringBetween(str, tag, tag);
    }

    global static String substringBetween(String str, String open, String close) {
        if (str == null || open == null || close == null) {
            return null;
        }
        Integer start = str.indexOf(open);
        if (start != -1) {
            Integer endIndex = str.indexOf(close, start + open.length());
            if (endIndex != -1) {
                return substring(str, start + open.length(), endIndex);
            }
        }
        return null;
    }

    global static String[] substringsBetween(String str, String open, String close) {
        if (str == null || isEmpty(open) || isEmpty(close)) {
            return null;
        }
        Integer strLen = str.length();
        if (strLen == 0) {
            return ArrayUtils.EMPTY_STRING_ARRAY;
        }
        Integer closeLen = close.length();
        Integer openLen = open.length();
        List<String> returnList = new List<String>();
        Integer pos = 0;
        while (pos < (strLen - closeLen)) {
            Integer start = str.indexOf(open, pos);
            if (start < 0) {
                break;
            }
            start += openLen;
            Integer endIndex = str.indexOf(close, start);
            if (endIndex < 0) {
                break;
            }
            returnList.add(substring(str, start, endIndex));
            pos = endIndex + closeLen;
        }
        if (returnList.isEmpty()) {
            return null;
        } 
        return returnList;
    }
    
        
    global static String trim(String str){
        if(str == null){
            return null;
        }
        return str.trim();
    }
    
    global static List<String> trimAll(List<String> aList){
        List<String> returnValue = null;
        if(aList != null){
            returnValue = new List<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(trim(value));
                }
            }
        }
        return returnValue;
    }
    
    global static Set<String> trimAll(Set<String> aList){
        Set<String> returnValue = null;
        if(aList != null){
            returnValue = new Set<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(trim(value));
                }
            }
        }
        return returnValue;
    }
    
    global static String trimToNull(String str) {
        String ts = trim(str);
        return isEmpty(ts) ? null : ts;
    }

    global static String trimToEmpty(String str) {
        return str == null ? EMPTY : str.trim();
    }    
    
    global static String uncapitalize(String str) {
        if(isBlank(str)){
            return str;
        }
        return lowerCase(str.substring(0,1)) + str.substring(1);
    }
    
    global static String upperCase(String str) {
        if (str == null) {
            return null;
        }
        return str.toUpperCase();
    }
    
    global static String ensureStringStartsEndsWithChar(String str, String charc){
        String returnStr = str;
        if(returnStr != null && charc != null){
            returnStr = StringUtils.startsWith(str,charc) ? returnStr : charc + returnStr;
            returnStr = StringUtils.endsWith(str,charc) ? returnStr : returnStr + charc;
        }
        return returnStr;
    }

    global static String[] toCharArray(String str){
        List<String> strs = new List<String>();
        if(str != null && str.length() > 0){
            for(Integer i = 0; i < str.length(); i++){
                strs.add(str.substring(i, i+1));
            }
        }    
        return strs;
    }
    
    global static String trimLower(String str){
        return StringUtils.lowerCase(StringUtils.trim(str));
    }
    
    /**
     * stripMarkup(null) -> null
     * stripMarkup('') -> ''
     * stripMarkup('Title!   ABC 123') -> 'Title! ABC 123'
     * stripMarkup('<html><body><h1>Title!</h1><p>ABC 123</p></html>') -> 'Title! ABC 123'
     */
    global static String stripMarkup(String str){
    	String returnValue = null;
    	if(str != null){
    		returnValue = StringUtils.trim(Pattern.compile('[ ]{2,}').matcher(Pattern.compile('<(.|\\n)*?>').matcher(str).replaceAll(' ')).replaceAll(' '));
    	}
    	return returnValue;
    }
    

}