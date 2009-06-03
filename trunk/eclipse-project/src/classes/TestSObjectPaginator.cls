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
private class TestSObjectPaginator {

	private static testmethod void testHundredAccounts(){
		Integer RECORD_COUNT = 100;
		List<SObject> records = new List<Account>();
		for(Integer i = 0; i < RECORD_COUNT; i++){
			records.add(new Account(name='test'+i));
		}
		final SObjectPaginator paginator = new SObjectPaginator(records);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(RECORD_COUNT,paginator.all.size());
		System.assertEquals(RECORD_COUNT,paginator.recordCount);
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.page.size());
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(Math.ceil(RECORD_COUNT/SObjectPaginator.DEFAULT_PAGE_SIZE).intValue(), paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		for(Integer i = 0; i < SObjectPaginator.DEFAULT_PAGE_SIZE; i++){
			System.assertEquals('test'+i, paginator.page.get(i).get('name'));
		}
		
		paginator.next();
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(RECORD_COUNT,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.page.size());
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(1,paginator.pageNumber);
		System.assertEquals(Math.ceil(RECORD_COUNT/SObjectPaginator.DEFAULT_PAGE_SIZE).intValue(), paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);
		for(Integer i = 0; i < SObjectPaginator.DEFAULT_PAGE_SIZE; i++){
			System.assertEquals('test'+(i+SObjectPaginator.DEFAULT_PAGE_SIZE), paginator.page.get(i).get('name'));
		}
	}
	
	private static testmethod void testRecordsSmallerThanPageSize(){
		List<Account> records = createTestAccount(8);
		final SObjectPaginator paginator = new SObjectPaginator(records,5);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(8,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(5,paginator.page.size());
		System.assertEquals(5,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(2, paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		for(Integer i = 0; i < 5; i++){
			System.assertEquals('test'+i, paginator.page.get(i).get('name'));
		}

		paginator.next();
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(8,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(3,paginator.page.size());
		System.assertEquals(5,paginator.pageSize);
		System.assertEquals(1,paginator.pageNumber);
		System.assertEquals(2, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);
		for(Integer i = 5; i < 8; i++){
			System.assertEquals('test'+i, paginator.page.get(i-5).get('name'));
		}

		paginator.setPageSize(20);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(8,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(8,paginator.page.size());
		System.assertEquals(20,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(1, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		for(Integer i = 0; i < 8; i++){
			System.assertEquals('test'+i, paginator.page.get(i).get('name'));
		}
	}

	private static testmethod void testNextIllegalState(){
		SObjectPaginator paginator = new SObjectPaginator(createTestAccount(2),1);
		paginator.next();
		Boolean exceptionThrown = false;
		try{
			paginator.next();
		}catch(IllegalStateException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);

		paginator = new SObjectPaginator(createTestAccount(4),1);
		paginator.next();
		paginator.next();
		paginator.next();
		exceptionThrown = false;
		try{
			paginator.next();
		}catch(IllegalStateException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);
	}
	
	private static testmethod void testPreviousIllegalState(){
		SObjectPaginator paginator = new SObjectPaginator(createTestAccount(2),1);
		Boolean exceptionThrown = false;
		try{
			paginator.previous();
		}catch(IllegalStateException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);
	}
	
	private static testmethod void testSkipToPage(){
		SObjectPaginator paginator = new SObjectPaginator(createTestAccount(10),3);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(10,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(3,paginator.page.size());
		System.assertEquals(3,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(4, paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);

		paginator.skipToPage(3);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(10,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(1,paginator.page.size());
		System.assertEquals(3,paginator.pageSize);
		System.assertEquals(3,paginator.pageNumber);
		System.assertEquals(4, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);

		Boolean exceptionThrown = false;
		try{
			paginator.skipToPage(4);
		}catch(IllegalArgumentException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);

		exceptionThrown = false;
		try{
			paginator.skipToPage(-1);
		}catch(IllegalArgumentException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);
	}
	
	private static testmethod void testListener(){
		IPaginatorListenerConcreteForTests listener = new IPaginatorListenerConcreteForTests();
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		List<Account> records = createTestAccount(8);
		final SObjectPaginator paginator = new SObjectPaginator(records,5,listener);
		System.assertEquals(true,listener.handlePageChangeInvoked);

		listener.handlePageChangeInvoked = false;		
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		paginator.next(); 
		System.assertEquals(true,listener.handlePageChangeInvoked);

		listener.handlePageChangeInvoked = false;
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		paginator.previous(); 
		System.assertEquals(true,listener.handlePageChangeInvoked);

		listener.handlePageChangeInvoked = false;
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		paginator.setPageSize(4); 
		System.assertEquals(true,listener.handlePageChangeInvoked);

		listener.handlePageChangeInvoked = false;
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		paginator.setRecords(createTestAccount(6)); 
		System.assertEquals(true,listener.handlePageChangeInvoked);
	}
	
	private static testmethod void testBadInput(){
		SObjectPaginator paginator = new SObjectPaginator(null);
		System.assertEquals(null,paginator.all);
		System.assertEquals(null,paginator.page);
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(0, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);

		paginator = new SObjectPaginator(new List<Account>());
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(0,paginator.all.size());
		System.assertEquals(null,paginator.page);
		System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(0, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
	}
	
	private static List<Account> createTestAccount(Integer count){
		List<Account> records = new List<Account>();
		for(Integer i = 0; i < count; i++){
			records.add(new Account(name='test'+i));
		}
		return records;
	}
}