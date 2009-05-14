@IsTest
private class TestSObjectUtils {
	
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
		
}