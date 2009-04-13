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
@IsTest
private class TestPageUtils {
 
	private static testmethod void testAddConfirm(){
		//test: global static void addConfirm(String message){
		TestUtils.assertNoConfirmMessagesExist();
		PageUtils.addConfirm('test');
		TestUtils.assertConfirmMessagesExist();
	}

	private static testmethod void testAddInfo(){
		//test: global static void addInfo(String message){
		TestUtils.assertNoInfoMessagesExist();
		PageUtils.addInfo('test');
		TestUtils.assertInfoMessagesExist();
	}

	private static testmethod void testAddWarning(){
		//test: global static void addWarning(String message){
		TestUtils.assertNoWarningMessagesExist();
		PageUtils.addWarning('test');
		TestUtils.assertWarningMessagesExist();
	}

	private static testmethod void testAddError(){
		//test: global static void addError(String message){
		TestUtils.assertNoErrorMessagesExist();
		PageUtils.addError('test');
		TestUtils.assertErrorMessagesExist();
	}

	private static testmethod void testAddFatal(){
		//test: global static void addFatal(String message){
		TestUtils.assertNoFatalMessagesExist();
		PageUtils.addFatal('test');
		TestUtils.assertFatalMessagesExist();
	}

	private static testmethod void testRedirect(){
		//test: global static PageReference redirect(String url){
		PageReference ref = PageUtils.redirect('/abc123');
		System.assertNotEquals(null,ref);
		System.assertEquals('/abc123',ref.getUrl());
		System.assertEquals(true,ref.getRedirect());
	}
	
	private static testmethod void testParam(){
		//test: global static String param(String param){
		ApexPages.currentPage().getParameters().put('test1','value1');
		System.assertEquals('value1',PageUtils.param('test1'));
	}
	
	private static testmethod void testParamTwoArgs(){
		//test: global static String param(String param){
		System.assertEquals(null,ApexPages.currentPage().getParameters().get('test1'));
		System.assertEquals('value1',PageUtils.param('test1','value1'));
		System.assertEquals('value1',ApexPages.currentPage().getParameters().get('test1'));
	}
	
	private static testmethod void testGetErrorMessages(){
		//test: global static ApexPages.Message[] getErrorMessages(){
		System.assertEquals(true,PageUtils.getErrorMessages().isEmpty());
		PageUtils.addInfo('testb'); 
		System.assertEquals(false,PageUtils.getErrorMessages().isEmpty());
		PageUtils.addError('testa'); 
		System.assertEquals(false,PageUtils.getErrorMessages().isEmpty());
	}
	
	private static testmethod void testGetErrorMessagesOnly(){
		//test: global static ApexPages.Message[] getErrorMessagesOnly(){
		PageUtils.addInfo('testb'); 
		System.assertEquals(true,PageUtils.getErrorMessagesOnly().isEmpty());
		PageUtils.addError('testa'); 
		System.assertEquals(false,PageUtils.getErrorMessagesOnly().isEmpty());
	}
	
	private static testmethod void testMessagesToStringNoArg(){
		//test: global static String messagesToString(){
		System.assertEquals('{empty}',
			PageUtils.messagesToString());
		PageUtils.addInfo('testb'); 
		System.assertEquals('{ApexPages.Message[0]: (summary=testb,componentLabel=null,severity=ApexPages.Severity.INFO,detail=testb)}',
			PageUtils.messagesToString());
	}
	
	private static testmethod void testMessagesToStringOneArg(){
		//test: global static String messagesToString(ApexPages.Message[] messages){
		System.assertEquals('null',PageUtils.messagesToString(null));
		PageUtils.addError('testb'); 
		PageUtils.addError('testc'); 
		System.assertEquals('{ApexPages.Message[0]: (summary=testb,componentLabel=null,severity=ApexPages.Severity.ERROR,detail=testb); ApexPages.Message[1]: (summary=testc,componentLabel=null,severity=ApexPages.Severity.ERROR,detail=testc)}',
			PageUtils.messagesToString(PageUtils.getErrorMessages()));
	}
	
	private static testmethod void testGetMessagesAtLevelScenario1(){
		//test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
		PageUtils.addInfo('testb'); 
		System.assertEquals(true,PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
		PageUtils.addError('testa'); 
		System.assertEquals(false,PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
	}

	private static testmethod void testGetMessagesAtLevelScenario2(){
		//test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
		PageUtils.addInfo('testb'); 
		System.assertEquals(true,PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
	}

	private static testmethod void testGetMessagesAtLevelScenario3(){
		//test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
		PageUtils.addInfo('testb'); 
		System.assertEquals(false,PageUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,true).isEmpty());
	}

	private static testmethod void testIsMessageAtLevelOrHigher(){
		//test: global static Boolean isMessageAtLevelOrHigher(ApexPages.Message message, ApexPages.Severity level){
		assertIsMessageAtLevelOrHigher(null,null,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,null,false);
		assertIsMessageAtLevelOrHigher(null,ApexPages.severity.INFO,false);

		assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.CONFIRM,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.INFO,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.WARNING,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.ERROR,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.FATAL,true);

		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.CONFIRM,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.INFO,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.WARNING,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.ERROR,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.FATAL,true);

		assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.CONFIRM,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.INFO,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.WARNING,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.ERROR,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.FATAL,true);

		assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.CONFIRM,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.INFO,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.WARNING,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.ERROR,true);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.FATAL,true);

		assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.CONFIRM,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.INFO,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.WARNING,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.ERROR,false);
		assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.FATAL,true);
	}

	private static void assertIsMessageAtLevelOrHigher(ApexPages.Severity messageLevel, ApexPages.Severity level, Boolean expected){
		Boolean actual = PageUtils.isMessageAtLevelOrHigher((messageLevel==null ? null : new ApexPages.message(messageLevel,'test')),level);
		System.assert(actual==expected,'PageUtils.isMessageAtLevelOrHigher(' + (messageLevel == null ? 'null' : ''+messageLevel) + ',' + level + ') returned ' + actual);
	}
}