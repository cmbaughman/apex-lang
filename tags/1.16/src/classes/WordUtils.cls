/* ============================================================
 * This code is part of the 'apex-lang' open source project avaiable at:
 * 
 *      http://code.google.com/p/apex-lang/
 *
 * This code is licensed under the Apache License, Version 2.0.  You may obtain a 
 * copy of the License at:
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * ============================================================
 */

global class WordUtils {

    global static String wrap(String str, Integer wrapLength) {
        return wrap(str, wrapLength, null, false);
    }
    
    global static String wrap(String str, Integer wrapLength, String newLineStr, boolean wrapLongWords) {
        if (str == null) {
            return null;
        }
        if (newLineStr == null) {
            newLineStr = SystemUtils.LINE_SEPARATOR;
        }
        if (wrapLength < 1) {
            wrapLength = 1;
        }
        Integer inputLineLength = str.length();
        Integer offset = 0;
        String wrappedLine = '';
        
        while ((inputLineLength - offset) > wrapLength) {
            if (' '.equals(StringUtils.charAt(str, offset))) {
                offset++;
                continue;
            }
            Integer spaceToWrapAt = StringUtils.lastIndexOf(str, ' ', wrapLength + offset);

            if (spaceToWrapAt >= offset) {
                // normal case
                wrappedLine += str.substring(offset, spaceToWrapAt);
                wrappedLine += newLineStr;
                offset = spaceToWrapAt + 1;
            } else {
                // really long word or URL
                if (wrapLongWords) {
                    // wrap really long word one line at a time
                    wrappedLine += str.substring(offset, wrapLength + offset);
                    wrappedLine += newLineStr;
                    offset += wrapLength;
                } else {
                    // do not wrap really long word, just extend beyond limit
                    spaceToWrapAt = str.indexOf(' ', wrapLength + offset);
                    if (spaceToWrapAt >= 0) {
                        wrappedLine += str.substring(offset, spaceToWrapAt);
                        wrappedLine += newLineStr;
                        offset = spaceToWrapAt + 1;
                    } else {
                        wrappedLine += str.substring(offset);
                        offset = inputLineLength;
                    }
                }
            }
        }

        // Whatever is left in line is short enough to just pass through
        wrappedLine += (str != null && str.length()>offset ? str.substring(offset) : '');

        return wrappedLine;
    }

    global static String capitalize(String str) {
        return capitalize(str, null);
    }

    global static String capitalize(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        Integer strLen = str.length();
        String buffer = '';
        boolean capitalizeNext = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = StringUtils.charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                buffer += ch;
                capitalizeNext = true;
            } else if (capitalizeNext) {
                buffer += Character.toTitleCase(ch);
                capitalizeNext = false;
            } else {
                buffer += ch;
            }
        }
        return buffer;
    }

    global static String capitalizeFully(String str) {
        return capitalizeFully(str, null);
    }

    global static String capitalizeFully(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        str = str.toLowerCase();
        return capitalize(str, delimiters);
    }

    global static String uncapitalize(String str) {
        return uncapitalize(str, null);
    }

    global static String uncapitalize(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        Integer strLen = str.length();
        String buffer = '';
        boolean uncapitalizeNext = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = StringUtils.charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                buffer += ch;
                uncapitalizeNext = true;
            } else if (uncapitalizeNext) {
                buffer += Character.toLowerCase(ch);
                uncapitalizeNext = false;
            } else {
                buffer += ch;
            }
        }
        return buffer;
    }

    global static String swapCase(String str) {
        Integer strLen;
        if (str == null || (strLen = str.length()) == 0) {
            return str;
        }
        String buffer = '';

        boolean whitespace = true;
        String ch = null;
        String tmp = null;

        for (Integer i = 0; i < strLen; i++) {
            ch = StringUtils.charAt(str, i);
            if (Character.isUpperCase(ch)) {
                tmp = Character.toLowerCase(ch);
            } else if (Character.isLowerCase(ch)) {
                if (whitespace) {
                    tmp = Character.toTitleCase(ch);
                } else {
                    tmp = Character.toUpperCase(ch);
                }
            } else {
                tmp = ch;
            }
            buffer += tmp;
            whitespace = Character.isWhitespace(ch);
        }
        return buffer;
    }

    global static String initials(String str) {
        return initials(str, null);
    }

    global static String initials(String str, String[] delimiters) {
        //('i',{'S','I','J','o','1'})
        //str='i'
        //delimiters={'S','I','J','o','1'}
        if (str == null || str.length() == 0) {
            return str;
        }
        if (delimiters != null && delimiters.size() == 0) {
            return '';
        }
        Integer strLen = str.length();
        //strLen=1
        String buf = '';
        Integer count = 0;
        boolean lastWasGap = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = StringUtils.charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                lastWasGap = true;
            } else if (lastWasGap) {
                buf += ch;
                lastWasGap = false;
            } else {
                // ignore ch
            }
        }
        return buf;
    }

    private static boolean isDelimiter(String ch, String[] delimiters) {
        //ch='i'
        //delimiters={'S','I','J','o','1'}
        if (delimiters == null) {
            return Character.isWhitespace(ch);
        }
        for (Integer i = 0, isize = delimiters.size(); i < isize; i++) {
            if ((ch == null && delimiters[i] == null) || (ch != null && ch.equals(delimiters[i]))) {
                return true;
            }
        }
        return false;
    }

    global static String abbreviate(String str, Integer lower, Integer upper, String appendToEnd) {
        // initial parameter checks
        if (str == null) {
            return null;
        }
        if (str.length() == 0) {
            return StringUtils.EMPTY;
        }

        // if the upper value is -1 (i.e. no limit) or is greater
        // than the length of the string, set to the length of the string
        if (upper == -1 || upper > str.length()) {
            upper = str.length();
        }
        // if upper is less than lower, raise it to lower
        if (upper < lower) {
            upper = lower;
        }

        String result = '';
        Integer index = StringUtils.indexOf(str, ' ', lower);
        if (index == -1) {
            result += str.substring(0, upper);
            // only if abbreviation has occured do we append the appendToEnd value
            if (upper != str.length()) {
                result += StringUtils.defaultString(appendToEnd);
            }
        } else if (index > upper) {
            result += str.substring(0, upper);
            result += StringUtils.defaultString(appendToEnd);
        } else {
            result += str.substring(0, index);
            result += StringUtils.defaultString(appendToEnd);
        }
        return result;
    }

}