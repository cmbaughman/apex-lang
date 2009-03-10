global class TestUtils {

	global static void assertConfirmMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
	global static void assertInfoMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
	global static void assertWarningMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
	global static void assertErrorMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
	global static void assertFatalMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

	global static void assertNoConfirmMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
	global static void assertNoInfoMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
	global static void assertNoWarningMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
	global static void assertNoErrorMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
	global static void assertNoFatalMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

	global static void assertMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
		final ApexPages.Message[] messages = PageUtils.getMessagesAtLevel(level,includeHigher);
		System.assert(messages != null && messages.size() > 0,'No errors exist');
	}
	
	global static void assertNoMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
		final ApexPages.Message[] messages = PageUtils.getMessagesAtLevel(level,includeHigher);
		System.assert(messages == null || messages.size() <= 0,PageUtils.messagesToString(messages));
	} 
	

}