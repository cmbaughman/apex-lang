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
private class TestSObjectSortByNameComparator {

	private static testmethod void testCompareBadInput(){
		ISObjectComparator comparator = new SObjectSortByNameComparator();
		System.assertEquals(-1,comparator.compare(null,new Account(name='test123'))); 
		System.assertEquals(0,comparator.compare(null,null)); 
		System.assertEquals(1,comparator.compare(new Account(name='test123'),null)); 
		
	}
	
	private static testmethod void testCompareWithAccounts(){
		Account a1 = new Account(name='abc');
		Account a2 = new Account(name='efg');
		ISObjectComparator comparator = new SObjectSortByNameComparator();
		System.assert(0 > comparator.compare(a1,a2)); 
		System.assert(0 == comparator.compare(a1,a1)); 
		System.assert(0 < comparator.compare(a2,a1)); 
	}
	
	private static testmethod void testCompareWithContacts(){
		Contact a1 = new Contact(lastname='abc',phone='3213213211');
		insert a1;
		a1 = [select name from Contact where id = :a1.id];
		Contact a2 = new Contact(lastname='efg',phone='3213213211');
		insert a2;
		a2 = [select name from Contact where id = :a2.id];
		ISObjectComparator comparator = new SObjectSortByNameComparator();
		System.assert(0 > comparator.compare(a1,a2)); 
		System.assert(0 == comparator.compare(a1,a1)); 
		System.assert(0 < comparator.compare(a2,a1)); 
	}
}