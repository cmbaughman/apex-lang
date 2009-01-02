global class StringUtils {

    global static String capitalize(String str) {
    	if(isBlank(str)){
    		return str;
    	}
        return upperCase(str.substring(0,1)) + str.substring(1);
    }
    
    global static Boolean contains(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return str.indexOf(searchStr,0) >= 0;
    }

    global static Boolean containsIgnoreCase(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return contains(str.toUpperCase(), searchStr.toUpperCase());
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
        System.debug('ending = [' + ending + ']');
        if(ignoreCase){
            return suffix.equalsIgnoreCase(ending);
        }
        return suffix.equals(ending);
    }
    
    global static Boolean endsWithIgnoreCase(String str, String suffix) {
        return endsWith(str, suffix, true);
    }

    global static boolean isBlank(String str) {
        return str == null || str.trim() == null || str.trim().length() == 0;
    }
    
    global static boolean isNotBlank(String str) {
    	return !isBlank(str);
    }
    
    global static String joinStrings(Set<String> strings, String separator){
    	if(strings == null || strings.size() == 0){
    		return null;
    	}
    	Boolean isFirst = true;
    	String returnString = '';
		for(String aString : strings){
			if(StringUtils.isBlank(aString)){
				continue;
			}
			if(isFirst){
				isFirst = false;
			}else{
				if(separator != null){
					returnString += separator;
				}
			}
			returnString += aString;
		}	
		return returnString;
    }
    
    global static String lowerCase(String str) {
    	if(str == null){
    		return null;
    	}
    	return str.toLowerCase();
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
    
    global static String trim(String str){
    	if(str == null){
    		return null;
    	}
    	return str.trim();
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
    

}