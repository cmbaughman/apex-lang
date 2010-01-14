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
private class SObjectUtilsTest {
    
    private static testmethod void testIsAnyFieldBlank(){
        //test: global static Boolean isAnyFieldBlank(SObject obj, String[] fields){
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(null,null));
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(new Account(),null));
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(new Account(),new String[]{}));

        Account account = new Account(
            name='Acme', 
            Description='Acme Computer Corp');
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(account,
            new String[]{'name','description'}));
        System.assertEquals(true,SObjectUtils.isAnyFieldBlank(account,
            new String[]{'name','description','NumberOfEmployees'}));
        account.NumberOfEmployees=10;
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(account,
            new String[]{'name','description','NumberOfEmployees'}));
        System.assertEquals(true,SObjectUtils.isAnyFieldBlank(account,
            new String[]{'name','description','phone'}));
    }
        
    private static testmethod void testToString(){
        //test: global static String toString(SObject obj){
        System.assertEquals('null',SObjectUtils.toString(null));
        Account account = new Account(name='Acme', Description='Acme Computer Corp',NumberOfEmployees=10);
        System.assertNotEquals(null,SObjectUtils.toString(account));
    }
        
    private static testmethod void testToStringFieldDescribeLimitsReached(){
        //test: global static String toString(SObject obj){
        for(Integer i = 0; i < Limits.getLimitFieldsDescribes(); i++){
               Map<String, Schema.SObjectField> m = Schema.sObjectType.Account.fields.getMap();        
        }
        System.assertEquals(null,SObjectUtils.toString(new Account(name='Acme')));
    }
    
    /*private static testmethod void testGetCachedDescribe(){
        //test: global static Schema.DescribeSObjectResult getCachedDescribe(SObject obj){
        Schema.DescribeSObjectResult desc1 = SObjectUtils.getCachedDescribe(new Account());
        System.debug(desc1);
        SystemUtils.debugLimits();

        Schema.DescribeSObjectResult desc2 = SObjectUtils.getCachedDescribe(new Account());
        System.debug(desc2);
        SystemUtils.debugLimits();
    }
    */
    
    /*
    private static testmethod void testSendNotificationEmailBadArgs(){
        //test: global static void sendNotificationEmail(SObject obj){
        Boolean exceptionCaught = false;
        try{
            SObjectUtils.sendNotificationEmail(null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);

        exceptionCaught = false;
        try{
            SObjectUtils.sendNotificationEmail(new Lead());
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);

        exceptionCaught = false;
        try{
        	final Account a = new Account(name='test123');
        	insert a;
            delete a;
            SObjectUtils.sendNotificationEmail(a);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);
    }    

    private static testmethod void testSendNotificationEmail(){
        //test: global static void sendNotificationEmail(SObject obj){
        QueueSobject q = null;
        try{
        	q = [select queueid from QueueSobject where sobjecttype = 'Lead' limit 1];
        }catch(QueryException e){} 
        System.assert(q != null, 'Environment Dependency: in order for this test to pass, you need at least one Lead queue set up.');
        final Lead l = new Lead(lastname='Doe', company='test', ownerid=q.queueid);
        insert l;
        SObjectUtils.sendNotificationEmail(l);
    }     
    */   
}