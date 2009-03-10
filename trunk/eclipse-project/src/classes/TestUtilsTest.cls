@IsTest
private class TestUtilsTest {

	private static testmethod void testAssertConfirmMessagesExist(){
		//test: global static void assertConfirmMessagesExist()
		PageUtils.addConfirm('test');
		TestUtils.assertConfirmMessagesExist();
	}

	private static testmethod void testAssertInfoMessagesExist(){
		//test: global static void assertInfoMessagesExist()
		PageUtils.addInfo('test');
		TestUtils.assertInfoMessagesExist();
	}

	private static testmethod void testAssertWarningMessagesExist(){
		//test: global static void assertWarningMessagesExist()
		PageUtils.addWarning('test');
		TestUtils.assertWarningMessagesExist();
	}

	private static testmethod void testAssertErrorMessagesExist(){
		//test: global static void assertErrorMessagesExist()
		PageUtils.addError('test');
		TestUtils.assertErrorMessagesExist();
	}

	private static testmethod void testAssertFatalMessagesExist(){
		//test: global static void assertFatalMessagesExist()
		PageUtils.addFatal('test');
		TestUtils.assertFatalMessagesExist();
	}

	private static testmethod void testAssertNoConfirmMessagesExist(){
		//test: global static void assertNoConfirmMessagesExist()
		TestUtils.assertNoConfirmMessagesExist();
	}

	private static testmethod void testAssertNoInfoMessagesExist(){
		//test: global static void assertNoInfoMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.INFO); }
		TestUtils.assertNoInfoMessagesExist();
	}

	private static testmethod void testAssertNoWarningMessagesExist(){
		//test: global static void assertNoWarningMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.WARNING); }
		TestUtils.assertNoWarningMessagesExist();
	}

	private static testmethod void testAssertNoErrorMessagesExist(){
		//test: global static void assertNoErrorMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.ERROR); }
		TestUtils.assertNoErrorMessagesExist();
	}

	private static testmethod void testAssertNoFatalMessagesExist(){
		//test: global static void assertNoFatalMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.FATAL); }
		TestUtils.assertNoFatalMessagesExist();
	}

}