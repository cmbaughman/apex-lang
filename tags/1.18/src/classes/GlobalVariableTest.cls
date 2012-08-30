@IsTest
private class GlobalVariableTest {

    private static testmethod void test_get_bad_input(){
        //no asserts, just making sure this doesn't throw an exception
        // if an exception were thrown, then this test would fail
        System.assertEquals(null,GlobalVariable.get(null));
        System.assertEquals(null,GlobalVariable.get('   '));
    }

    private static testmethod void test_put_bad_input(){
        //no asserts, just making sure this doesn't throw an exception
        // if an exception were thrown, then this test would fail
        System.assertEquals(null,GlobalVariable.put(null,null));
        System.assertEquals(null,GlobalVariable.put('   ',null));
    }

    private static testmethod void test_put_insert(){
        deleteGlobalVariableWithNameIfExists('test 123');

        String previousValue = GlobalVariable.put('test 123',null);
        assertGlobalVariableExistsWith('test 123',null);
        System.assertEquals(null,previousValue);
        System.assertEquals(null,GlobalVariable.get('test 123'));

        previousValue = GlobalVariable.put('test 123','xyz');
        assertGlobalVariableExistsWith('test 123','xyz');
        System.assertEquals(null,previousValue);
        System.assertEquals('xyz',GlobalVariable.get('test 123'));

        previousValue = GlobalVariable.put('test 123','abc');
        assertGlobalVariableExistsWith('test 123','abc');
        System.assertEquals('xyz',previousValue);
        System.assertEquals('abc',GlobalVariable.get('test 123'));
    }

    private static testmethod void test_put_update(){
        deleteGlobalVariableWithNameIfExists('test 123');
        GlobalVariable__c record = new GlobalVariable__c(
            name     = 'test 123'
            ,Value__c = 'xyz'
        );  
        insert record;
        assertGlobalVariableExistsWith('test 123','xyz');

        String previousValue = GlobalVariable.put('test 123','abc');
        assertGlobalVariableExistsWith('test 123','abc');
        System.assertEquals('xyz',previousValue);
        System.assertEquals('abc',GlobalVariable.get('test 123'));
    }

    private static void deleteGlobalVariableWithNameIfExists(String name){
        GlobalVariable__c record = null;
        try{
            record = [    
               select id 
               from GlobalVariable__c 
               where name = :name 
               limit 1 
            ];
        }catch(QueryException e){}
        if(record != null) delete record;
    }

    private static void assertGlobalVariableExistsWith(String name, String value){
        GlobalVariable__c record = null;
        try{
            record = [    
               select value__c 
               from GlobalVariable__c 
               where name = :name 
               limit 1 
            ];
        }catch(QueryException e){}
        System.assertNotEquals(null,record);
        System.assertEquals   (value,record.value__c);
    }


}