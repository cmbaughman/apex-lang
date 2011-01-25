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
global class PageUtils {

    global static PageReference redirect(String url){
        PageReference pageRef = new PageReference(url);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    global static String param(String param){
        return get(param);
    }
    
    global static String param(String param, String value){
        return put(param,value);
    }
    
    global static String get(String param){
        return ApexPages.currentPage().getParameters().get(param);
    }
    
    // Returns the parameters which contains a part of the key
    global static Map<String,String> getParameters(String param){
        Map<String,String> parameters = new Map<String,String>();
        for(String key:ApexPages.currentPage().getParameters().keySet()){
            if(key.contains(param)){
                parameters.put(key,ApexPages.currentPage().getParameters().get(key));
            }
        }
        return parameters;
    }
    
    global static String put(String param, String value){
        ApexPages.currentPage().getParameters().put(param,value);
        return value;
    }
    
    global static void addConfirm(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,message));
    }
    
    global static void addInfo(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,message));
    }
    
    global static void addWarning(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,message));
    }
    
    global static void addError(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,message));
    }
    
    global static void addFatal(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,message));
    }
    
    global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,
        Boolean includeParents){
        final ApexPages.Message[] all = ApexPages.getMessages();
        final List<ApexPages.Message> filtered = new List<ApexPages.Message>();
        if(all != null && all.size() > 0){
            for(ApexPages.Message message : all){
                if(message.getSeverity() == level 
                    || (includeParents && isMessageAtLevelOrHigher(message,level))){
                    filtered.add(message);
                }
            }
        }
        return filtered;
    }
    
    global static ApexPages.Message[] getErrorMessages(){
        return PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR, true);
    }

    global static Boolean hasErrorMessages(){
        final ApexPages.Message[] errorMessages = getErrorMessages();
        return errorMessages != null && errorMessages.size() > 0;
    }
    
    global static ApexPages.Message[] getErrorMessagesOnly(){
        return PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR, false);
    }
    
    global static Boolean hasErrorMessagesOnly(){
    	final ApexPages.Message[] errorMessagesOnly = getErrorMessagesOnly();
        return errorMessagesOnly != null && errorMessagesOnly.size() > 0;
    }
    
    global static String messagesToString(){
        return messagesToString(ApexPages.getMessages());
    }
    
    global static String messagesToString(ApexPages.Message[] messages){
        if(messages == null){
            return 'null';
        }
        if( messages.size() <= 0){
            return '{empty}';
        }
        String returnString = '';
        for(Integer i = 0; i < messages.size(); i++){
            if(i != 0){ returnString += '; '; }
            returnString += 'ApexPages.Message[';
            returnString += i;
            returnString += ']: (summary=';
            returnString += messages[i].getSummary(); 
            returnString += ',componentLabel=';
            returnString += messages[i].getComponentLabel(); 
            returnString += ',severity=';
            returnString += messages[i].getSeverity(); 
            returnString += ',detail=';
            returnString += messages[i].getDetail(); 
            returnString += ')';
        }
        return '{' + returnString + '}';
    }
    
    global static Boolean isMessageAtLevelOrHigher(ApexPages.Message message, ApexPages.Severity level){
        if(level == null || message == null){
            return false;
        }
        ApexPages.Severity msgLevel = message.getSeverity();
        while(true){
            if(level == msgLevel){
                return true;    
            }
            if(msgLevel == ApexPages.Severity.CONFIRM){msgLevel = ApexPages.Severity.WARNING;}
            else if(msgLevel == ApexPages.Severity.INFO){msgLevel = ApexPages.Severity.WARNING;}
            else if(msgLevel == ApexPages.Severity.WARNING){msgLevel = ApexPages.Severity.ERROR;}
            else if(msgLevel == ApexPages.Severity.ERROR){msgLevel = ApexPages.Severity.FATAL;}
            else { break; }
        }
        return false;
    }

    global static String encodeVariable(String variable){
        if(variable!=null){
            return EncodingUtil.urlEncode(variable,'UTF-8');
        } else {
            return '';
        }                        
    }    
}