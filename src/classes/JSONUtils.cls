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
global class JSONUtils {

    global static String encode(String str){
        return (str == null) ? 'null' : '"' + 
            StringUtils.replaceEach(str,new String[]{
                    '"','\\','\n','\t','\f','\r','/'
            },new String[]{
                    '\\"','\\\\','\\n','\\t','\\f','\\r','\\/'
            }) 
            + '"';
    }  
    /*
    
    private static Map<String,Pattern> PATTERNS = new Map<String,Pattern>{
    	 '\\\"' => Pattern.compile('"')  
		,'\\/'  => Pattern.compile('/')  
		,'\\b'  => Pattern.compile('\b')    
		,'\\f'  => Pattern.compile('\f') 
		,'\\n'  => Pattern.compile('\n') 
		,'\\r'  => Pattern.compile('\r') 
		,'\\t'  => Pattern.compile('\t') 
      //,'\\\\\\' => Pattern.compile('\\\\')    
    };

    
    global static String encode(String str){
        String returnValue = 'null';
        if(str != null){
        	returnValue = str;
        	for(String replacement : PATTERNS.keySet()){
	            returnValue = PATTERNS.get(replacement).matcher(returnValue).replaceAll(replacement);
        	}
        	returnValue = '"' + returnValue + '"';
        }
        return returnValue;
    }
    */

    global static List<String> encode(List<String> strs){
        List<String> returnValue = null;
        if(strs != null){
            returnValue = new List<String>();
            if(strs.size() > 0){
                for(String str : strs){
                    returnValue.add(encode(str));
                }
            }
        }
        return returnValue;
    }

    global static void encodeFields(List<SObject> sobjects, Map<String,String> mapping){
    	if(sobjects != null && sobjects.size() > 0 && mapping != null && mapping.size() > 0){
            Object valueObject = null;
            String valueString = null;
    		for(SObject sobj : sobjects){
    			for(String sourceFieldName : mapping.keySet()){
    				valueObject = SObjectUtils.getQuietly(sobj, sourceFieldName);
    				if(valueObject != null && valueObject instanceof String){
    					valueString = (String) valueObject;
    				} else {
                        valueString = null;
    				}
    				SObjectUtils.putQuietly(sobj, mapping.get(sourceFieldName), encode(valueString));
    			}
    		}
    	}
    }

}