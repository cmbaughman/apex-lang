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

}