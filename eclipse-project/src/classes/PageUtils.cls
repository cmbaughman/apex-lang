global class PageUtils {

	global static PageReference redirect(String url){
        PageReference pageRef = new PageReference(url);
        pageRef.setRedirect(true);
        return pageRef;
    }
	
	global static String param(String param){
		return ApexPages.currentPage().getParameters().get(param);
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
		System.debug('getMessagesAtLevel(): all.size() = ' + ApexPages.getMessages().size());
		final List<ApexPages.Message> filtered = new List<ApexPages.Message>();
		if(all != null && all.size() > 0){
			for(ApexPages.Message message : all){
				System.debug('getMessagesAtLevel(): message.getSeverity() = ' + message.getSeverity());
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

	global static ApexPages.Message[] getErrorMessagesOnly(){
		return PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR, false);
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

	
	
}