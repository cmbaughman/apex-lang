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
    
    private static testmethod void testGetObjectAcct(){
        Map<String,String> values = new Map<String,String>();
        values.put('name','Account xyz');
        List<SObject> records = TestUtils.getObject(new Account(), 2, values);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('name'));
        }
    }
    
    private static testmethod void testGetObjectContact(){
        Map<String,String> values = new Map<String,String>();
        values.put('LastName','Account xyz');
        List<SObject> records = TestUtils.getObject(new Contact(), 2, values);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('LastName'));
        }
    }
    
    private static testmethod void testGetObjectDoInsert(){
        //test doInsert == false
        List<SObject> records = TestUtils.getObject(new Account(), 2);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals(null,record.get('id'));
        }

        //test doInsert == true
        Map<String,String> values = new Map<String,String>();
        values.put('name','Account xyz');
        records = TestUtils.getObject(new Account(), 2, values, true);
        Set<Id> idSet = new Set<Id>();
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('name'));
            idSet.add((Id)record.get('id'));
        }
        records = [select id from Account where id in :idSet];
        System.assertEquals(2,records.size());
    }
    
    private static testmethod void testGetObjectBadInput(){
        System.assertEquals(null,TestUtils.getObject(null, -1, null, true));
        System.assertEquals(null,TestUtils.getObject(null, 2, null, true));
        System.assert(TestUtils.getObject(new Account(), -1, null, true).isEmpty());
        System.assert(TestUtils.getObject(new Account(), 0, null, true).isEmpty());
    }
    
    private static testmethod void test_assertUrlsAreEqual(){
        //test: global static void assertUrlsAreEqual(String expected, String actual){
        TestUtils.assertUrlsAreEqual('http://google.com','http://google.com');
        TestUtils.assertUrlsAreEqual('http://google.com?x=1&y=2','http://google.com?y=2&x=1');
    }


}