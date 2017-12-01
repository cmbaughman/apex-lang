/* ============================================================
 * This code is part of the "apex-lang" open source project available at:
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
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(new Foo__c(),null));
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(new Foo__c(),new String[]{}));

        Foo__c foo = new Foo__c(
            name='Acme', 
            Text__c='Acme Computer Corp');
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(foo,
            new String[]{'name','Text__c'}));
        System.assertEquals(true,SObjectUtils.isAnyFieldBlank(foo,
            new String[]{'name','Text__c','NumberInteger__c'}));
        foo.NumberInteger__c=10;
        System.assertEquals(false,SObjectUtils.isAnyFieldBlank(foo,
            new String[]{'name','Text__c','NumberInteger__c'}));
        System.assertEquals(true,SObjectUtils.isAnyFieldBlank(foo,
            new String[]{'name','Text__c','PicklistMultiSelect__c'}));
    }

    private static testmethod void testToString(){
        //test: global static String toString(SObject obj){
        System.assertEquals('null',SObjectUtils.toString(null));
        Foo__c foo = new Foo__c(name='Acme');
        System.assertNotEquals(null,SObjectUtils.toString(foo));
    }
        
    private static testmethod void testToStringFieldDescribeLimitsReached(){
        //test: global static String toString(SObject obj){
        for(Integer i = 0; i < Limits.getLimitFieldsDescribes(); i++){
               Map<String, Schema.SObjectField> m = Schema.sObjectType.Foo__c.fields.getMap();        
        }
        System.assertEquals(null,SObjectUtils.toString(new Foo__c(name='Acme')));
    }
    
    private static testmethod void testCopyAllFieldsNullInputs(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        System.assertEquals(null,SObjectUtils.copyFields(null,null));
        System.assertEquals(null,SObjectUtils.copyFields(new Foo__c(),null));
        System.assertNotEquals(null,SObjectUtils.copyFields(null,new Foo__c()));
    }
    
    private static testmethod void testCopyFieldsFooToFoo(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Foo__c foo1 = new Foo__c();
        SObjectUtils.putQuietly(foo1,'Datetime__c',Datetime.newInstance(2011,1,1,1,1,1));
        SObjectUtils.putQuietly(foo1,'Phone__c','9876543210');
        SObjectUtils.putQuietly(foo1,'Text__c','test 123');
        SObjectUtils.putQuietly(foo1,'Textarea__c','9876543210');
        Foo__c foo2 = new Foo__c();
        final SObject sobj = SObjectUtils.copyFields(foo1,foo2);
        System.assert((sobj instanceof Foo__c), 'Returned SObject type isn\'t Foo__c as expected');
        foo2 = (Foo__c) sobj; 
        System.assertEquals(SObjectUtils.getQuietly(foo1,'Datetime__c'),
            SObjectUtils.getQuietly(foo2,'Datetime__c'));
        System.assertEquals(SObjectUtils.getQuietly(foo1,'Phone__c'),
            SObjectUtils.getQuietly(foo2,'Phone__c'));
        System.assertEquals(SObjectUtils.getQuietly(foo1,'Text__c'),
            SObjectUtils.getQuietly(foo2,'Text__c'));
        System.assertEquals(SObjectUtils.getQuietly(foo1,'Textarea__c'),
            SObjectUtils.getQuietly(foo2,'Textarea__c'));
    }
    
    private static testmethod void testPutQuietly(){
        //test: global static void putQuietly(SObject sobj, String fieldName, Object value){
        final Foo__c foo = new Foo__c(name='test123');
        System.assertEquals(null,SObjectUtils.putQuietly(null,null,null));
        System.assertEquals(null,SObjectUtils.putQuietly(foo,null,null));
        System.assertEquals('test123',SObjectUtils.getQuietly(foo,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(foo,'namexxxx',null));
        System.assertEquals('test123',SObjectUtils.getQuietly(foo,'name'));
        System.assertEquals('test123',SObjectUtils.putQuietly(foo,'name',null));
        System.assertEquals(null,SObjectUtils.getQuietly(foo,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(foo,'name',''));
        System.assertEquals('',SObjectUtils.getQuietly(foo,'name'));
        System.assertEquals('',SObjectUtils.putQuietly(foo,'name','xyz'));
        System.assertEquals('xyz',SObjectUtils.getQuietly(foo,'name'));
        System.assertEquals(null,SObjectUtils.putQuietly(foo,'namexxxx','123'));
        System.assertEquals('xyz',SObjectUtils.getQuietly(foo,'name'));
    }
    
    private static testmethod void testGetQuietly(){
        //test: global static Object getQuietly(SObject sobj, String fieldName){    
        final Foo__c foo = new Foo__c(name='test123');
        System.assertEquals(null,SObjectUtils.getQuietly(null,null));
        System.assertEquals(null,SObjectUtils.getQuietly(foo,null));
        System.assertEquals(null,SObjectUtils.getQuietly(null,''));
        System.assertEquals(null,SObjectUtils.getQuietly(foo,'namexxxxxx'));
        System.assertEquals('test123',SObjectUtils.getQuietly(foo,'name'));
    }    
    
}