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
private class TestObjectPaginator {

	private static testmethod void testHundredObjects(){
		Integer RECORD_COUNT = 100;
		List<Object> records = createTestObject(RECORD_COUNT);
		final ObjectPaginator paginator = new ObjectPaginator();
		paginator.setRecords(records);
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(RECORD_COUNT,paginator.all.size());
		System.assertEquals(RECORD_COUNT,paginator.recordCount);
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.page.size());
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.getPageSize());
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(Math.ceil(RECORD_COUNT/ObjectPaginator.DEFAULT_PAGE_SIZE).intValue(), paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		for(Integer i = 0; i < ObjectPaginator.DEFAULT_PAGE_SIZE; i++){
			System.assertEquals(i, ((DecimalRange)paginator.page.get(i)).min());
		}
		
		paginator.next();
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(RECORD_COUNT,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.page.size());
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(1,paginator.pageNumber);
		System.assertEquals(Math.ceil(RECORD_COUNT/ObjectPaginator.DEFAULT_PAGE_SIZE).intValue(), paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);
		for(Integer i = 0; i < ObjectPaginator.DEFAULT_PAGE_SIZE; i++){
			System.assertEquals(i, ((DecimalRange)paginator.page.get(i)).min()-ObjectPaginator.DEFAULT_PAGE_SIZE);
		}
	}
	
	private static testmethod void testRecordsSmallerThanPageSize(){
		List<Object> records = createTestObject(8);
		final ObjectPaginator paginator = new ObjectPaginator(5);
		paginator.setRecords(records);
		
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
			System.assertEquals(i, ((DecimalRange)paginator.page.get(i)).min());
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
			System.assertEquals(i, ((DecimalRange)paginator.page.get(i-5)).min());
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
			System.assertEquals(i, ((DecimalRange)paginator.page.get(i)).min());
		}
	}

	private static testmethod void testNextIllegalState(){
		ObjectPaginator paginator = new ObjectPaginator(1);
		paginator.setRecords(createTestObject(2));
		paginator.next();
		Boolean exceptionThrown = false;
		try{
			paginator.next();
		}catch(IllegalStateException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);

		paginator = new ObjectPaginator(1);
		paginator.setRecords(createTestObject(4));
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
		ObjectPaginator paginator = new ObjectPaginator(1);
		paginator.setRecords(createTestObject(2));
		Boolean exceptionThrown = false;
		try{
			paginator.previous();
		}catch(IllegalStateException e){
			exceptionThrown = true;	
		}
		System.assertEquals(true,exceptionThrown);
	}
	
	private static testmethod void testSkipToPage(){
		ObjectPaginator paginator = new ObjectPaginator(3);
		paginator.setRecords(createTestObject(10));
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
		ObjectPaginatorListenerForTesting listener = new ObjectPaginatorListenerForTesting();
		System.assertEquals(false,listener.handlePageChangeInvoked); 
		List<Object> records = createTestObject(8);
		ObjectPaginator paginator = new ObjectPaginator(listener);
		paginator.setRecords(records);
		paginator.setPageSize(5);
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
		paginator.setRecords(createTestObject(6)); 
		System.assertEquals(true,listener.handlePageChangeInvoked);
	}
	
	private static testmethod void testBadInput(){
		ObjectPaginator paginator = new ObjectPaginator();
		paginator.setRecords(null);
		System.assertEquals(null,paginator.all);
		System.assertEquals(null,paginator.page);
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(0, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);

		paginator = new ObjectPaginator();
		paginator.setRecords(createTestObject(0));
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(0,paginator.all.size());
		System.assertEquals(null,paginator.page);
		System.assertEquals(ObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(0, paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
	}
	
	private static testmethod void testFirstAndLast(){
		ObjectPaginator paginator = new ObjectPaginator(2);
		paginator.setRecords(createTestObject(11));
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(11,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(2,paginator.page.size());
		System.assertEquals(2,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(6,paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		
		paginator.last();
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(11,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(1,paginator.page.size());
		System.assertEquals(2,paginator.pageSize);
		System.assertEquals(5,paginator.pageNumber);
		System.assertEquals(6,paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);

		paginator.first();
		System.assertEquals(11,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(2,paginator.page.size());
		System.assertEquals(2,paginator.pageSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(6,paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
	}

	private static testmethod void testSkipPages(){
		ObjectPaginator paginator = new ObjectPaginator(2,3);
		paginator.setRecords(createTestObject(11));
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(11,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(2,paginator.page.size());
		System.assertEquals(2,paginator.pageSize);
		System.assertEquals(3,paginator.skipSize);
		System.assertEquals(0,paginator.pageNumber);
		System.assertEquals(1,paginator.pageNumberDisplayFriendly);
		System.assertEquals(1,paginator.pageStartPositionDisplayFriendly);
		System.assertEquals(2,paginator.pageEndPositionDisplayFriendly);
		System.assertEquals(6,paginator.pageCount);
		System.assertEquals(true,paginator.hasNext);
		System.assertEquals(false,paginator.hasPrevious);
		List<Integer> previousSkips = paginator.previousSkipPageNumbers;
		System.assertNotEquals(null,previousSkips);
		System.assertEquals(0,previousSkips.size());
		List<Integer> nextSkips = paginator.nextSkipPageNumbers;
		System.assertNotEquals(null,nextSkips);
		System.assertEquals(3,nextSkips.size());
		
		
		paginator.last();
		System.assertNotEquals(null,paginator.all);
		System.assertEquals(11,paginator.all.size());
		System.assertNotEquals(null,paginator.page);
		System.assertEquals(1,paginator.page.size());
		System.assertEquals(2,paginator.pageSize);
		System.assertEquals(3,paginator.skipSize);
		System.assertEquals(5,paginator.pageNumber);
		System.assertEquals(6,paginator.pageCount);
		System.assertEquals(false,paginator.hasNext);
		System.assertEquals(true,paginator.hasPrevious);
		previousSkips = paginator.previousSkipPageNumbers;
		System.assertNotEquals(null,previousSkips);
		System.assertEquals(3,previousSkips.size());
		nextSkips = paginator.nextSkipPageNumbers;
		System.assertNotEquals(null,nextSkips);
		System.assertEquals(0,nextSkips.size());
	}
		
	private static List<Object> createTestObject(Integer count){
		List<Object> records = new List<Object>();
		for(Integer i = 0; i < count; i++){
			records.add(new DecimalRange(i,i));
		}
		return records;
	}
}