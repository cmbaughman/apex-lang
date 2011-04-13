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
        SystemUtils.debugLimits();

        Schema.DescribeSObjectResult desc2 = SObjectUtils.getCachedDescribe(new Account());
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
    
    private static testmethod void testCopyAllFieldsNullInputs(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        System.assertEquals(null,SObjectUtils.copyFields(null,null));
        System.assertEquals(null,SObjectUtils.copyFields(new Account(),null));
        System.assertNotEquals(null,SObjectUtils.copyFields(null,new Account()));
    }
    
    private static testmethod void testCopyFieldsAccountToContact(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Account account = new Account();
        SObjectUtils.putQuietly(account,'Description','test 123');
        SObjectUtils.putQuietly(account,'Fax','9876543210');
        SObjectUtils.putQuietly(account,'Name','test 123');
        SObjectUtils.putQuietly(account,'Phone','9876543210');
        Contact contact = new Contact();
        final SObject sobj = SObjectUtils.copyFields(account,contact);
        System.assert((sobj instanceof Contact), 'Returned SObject type isn\'t Contact as expected');
        contact = (Contact) sobj; 
        System.assertEquals(SObjectUtils.getQuietly(account,'Description'),
            SObjectUtils.getQuietly(contact,'Description'));
        System.assertEquals(SObjectUtils.getQuietly(account,'Fax'),
            SObjectUtils.getQuietly(contact,'Fax'));
        System.assertEquals(SObjectUtils.getQuietly(account,'Phone'),
            SObjectUtils.getQuietly(contact,'Phone'));
    }
    
    private static testmethod void testCopyFieldsAccountToAccount(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Account account = new Account();
        SObjectUtils.putQuietly(account,'Description','test 123');
        SObjectUtils.putQuietly(account,'Fax','9876543210');
        SObjectUtils.putQuietly(account,'Name','test 123');
        SObjectUtils.putQuietly(account,'Phone','9876543210');
        Account account2 = new Account();
        final SObject sobj = SObjectUtils.copyFields(account,account2);
        System.assert((sobj instanceof Account), 'Returned SObject type isn\'t Account as expected');
        account2 = (Account) sobj; 
        System.assertEquals(SObjectUtils.getQuietly(account,'Description'),
            SObjectUtils.getQuietly(account2,'Description'));
        System.assertEquals(SObjectUtils.getQuietly(account,'Fax'),
            SObjectUtils.getQuietly(account2,'Fax'));
        System.assertEquals(SObjectUtils.getQuietly(account,'Phone'),
            SObjectUtils.getQuietly(account2,'Phone'));
    }
    
    private static testmethod void testCopyFieldsOpportunityToOpportunity(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Opportunity opportunity1 = new Opportunity();
        SObjectUtils.putQuietly(opportunity1,'Name','test 123');
        Opportunity opportunity2 = new Opportunity();
        final SObject sobj = SObjectUtils.copyFields(opportunity1,opportunity2);
        System.assert((sobj instanceof Opportunity), 'Returned SObject type isn\'t Opportunity as expected');
        opportunity2 = (Opportunity) sobj; 
        System.assertEquals(SObjectUtils.getQuietly(opportunity1,'Name'),
            SObjectUtils.getQuietly(opportunity2,'Name'));
    }
    
    private static testmethod void testCopyFieldsContactToContact(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Contact contact1 = new Contact();
        SObjectUtils.putQuietly(contact1,'EmailBouncedDate',Datetime.now());
        Contact contact2 = new Contact();
        System.assertNotEquals(SObjectUtils.getQuietly(contact1,'EmailBouncedDate'),
            SObjectUtils.getQuietly(contact2,'EmailBouncedDate'));
        final SObject sobj = SObjectUtils.copyFields(contact1,contact2);
        System.assert((sobj instanceof Contact), 'Returned SObject type isn\'t Contact as expected');
        contact2 = (Contact) sobj; 
        System.assertEquals(SObjectUtils.getQuietly(contact1,'EmailBouncedDate'),
            SObjectUtils.getQuietly(contact2,'EmailBouncedDate'));
    }
    
    private static testmethod void testPutQuietly(){
        //test: global static void putQuietly(SObject sobj, String fieldName, Object value){
        final Account acct = new Account(name='test123');
        System.assertEquals(null,SObjectUtils.putQuietly(null,null,null));
        System.assertEquals(null,SObjectUtils.putQuietly(acct,null,null));
        System.assertEquals('test123',SObjectUtils.getQuietly(acct,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(acct,'namexxxx',null));
        System.assertEquals('test123',SObjectUtils.getQuietly(acct,'name'));
        System.assertEquals('test123',SObjectUtils.putQuietly(acct,'name',null));
        System.assertEquals(null,SObjectUtils.getQuietly(acct,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(acct,'name',''));
        System.assertEquals('',SObjectUtils.getQuietly(acct,'name'));
        System.assertEquals('',SObjectUtils.putQuietly(acct,'name','xyz'));
        System.assertEquals('xyz',SObjectUtils.getQuietly(acct,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(acct,'namexxxx','123'));
        System.assertEquals('xyz',SObjectUtils.getQuietly(acct,'name'));
    }
    
    private static testmethod void testGetQuietly(){
        //test: global static Object getQuietly(SObject sobj, String fieldName){    
        final Account acct = new Account(name='test123');
        System.assertEquals(null,SObjectUtils.getQuietly(null,null));
        System.assertEquals(null,SObjectUtils.getQuietly(acct,null));
        System.assertEquals(null,SObjectUtils.getQuietly(null,''));
        System.assertEquals(null,SObjectUtils.getQuietly(acct,'namexxxxxx'));
        System.assertEquals('test123',SObjectUtils.getQuietly(acct,'name'));
    }    
    
}