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
global class MapUtils {

    global static List<String> joinMap(Map<String,String> theMap, String keyValueSeparator){
    	return joinx(theMap, keyValueSeparator);
    }
    
    global static List<String> joinx(Map<String,String> theMap, String keyValueSeparator){
        List<String> returnValue = null;
        if(theMap != null){
            returnValue = new List<String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.add(key + keyValueSeparator + theMap.get(key));
                }
            }
        }
        return returnValue;
    }

    global static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
    	return joinx(theMap, keyValueSeparator, recordSeparator);
    }
        
    global static String joinx(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
        String returnValue = null;
        if(theMap != null){
        	returnValue = '';
        	if(theMap.size() > 0){
	            returnValue = StringUtils.joinArray(joinMap(theMap,keyValueSeparator), recordSeparator);
        	}
        }
        return returnValue;
    }
    
    global static String toString(Map<String,String> theMap){
        return '<Map#([' + joinMap(theMap,'=',';') + '])>';
    }
    
    global static Boolean equals(Map<String,String> map1, Map<String,String> map2){
        if(map1 == null && map2 == null){
            return true;
        }
        if((map1 != null && map2 == null) 
            || (map1 == null && map2 != null)
            || (map1.size() != map2.size())){
            return false;
        }
        for(String key1 : map1.keySet()){
            if(!map2.containsKey(key1)){
                return false;
            }
            if(map1.get(key1) != map2.get(key1)){
                return false;
            }
        }
        return true;
    }
    
    global static void assertEquals(Map<String,String> expected, Map<String,String> actual){
        System.assert(
             equals(expected,actual)
            ,'Assertion failed, the following two maps are not equal.  Expected: ' 
                + expected 
                + ', Actual: ' 
                + actual);
    }

    global static Map<String,String> lowerCaseKeys(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(StringUtils.lowerCase(key),theMap.get(key));
                }
            }
        }
        return returnValue;
    }

    global static Map<String,String> upperCaseKeys(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(StringUtils.upperCase(key),theMap.get(key));
                }
            }
        }
        return returnValue;
    }

    global static Map<String,String> trimKeys(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(StringUtils.trim(key),theMap.get(key));
                }
            }
        }
        return returnValue;
    }

    
    global static Map<String,String> lowerCaseValues(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(key,StringUtils.lowerCase(theMap.get(key)));
                }
            }
        }
        return returnValue;
    }

    global static Map<String,String> upperCaseValues(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(key,StringUtils.upperCase(theMap.get(key)));
                }
            }
        }
        return returnValue;
    }

    global static Map<String,String> trimValues(Map<String,String> theMap){
        final Map<String,String> returnValue = null;
        if(theMap != null){
            returnValue = new Map<String,String>();
            if(theMap.size() > 0){
                for(String key : theMap.keySet()){
                    returnValue.put(key,StringUtils.trim(theMap.get(key)));
                }
            }
        }
        return returnValue;
    }
}