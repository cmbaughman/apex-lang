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
private class SObjectPaginatorTest {

    private static testmethod void testHundredObjects(){
        Integer RECORD_COUNT = 100;
        List<SObject> records = createTestAccount(RECORD_COUNT);
        final SObjectPaginator paginator = new SObjectPaginator();
        paginator.setRecords(records);
        System.assertNotEquals(null,paginator.all);
        System.assertEquals(RECORD_COUNT,paginator.all.size());
        System.assertEquals(RECORD_COUNT,paginator.recordCount);
        System.assertNotEquals(null,paginator.page);
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.page.size());
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.getPageSize());
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
        List<SObject> records = createTestAccount(8);
        final SObjectPaginator paginator = new SObjectPaginator(5);
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
        SObjectPaginator paginator = new SObjectPaginator(1);
        paginator.setRecords(createTestAccount(2));
        paginator.next();
        Boolean exceptionThrown = false;
        try{
            paginator.next();
        }catch(IllegalStateException e){
            exceptionThrown = true;    
        }
        System.assertEquals(true,exceptionThrown);

        paginator = new SObjectPaginator(1);
        paginator.setRecords(createTestAccount(4));
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
        SObjectPaginator paginator = new SObjectPaginator(1);
        paginator.setRecords(createTestAccount(2));
        Boolean exceptionThrown = false;
        try{
            paginator.previous();
        }catch(IllegalStateException e){
            exceptionThrown = true;    
        }
        System.assertEquals(true,exceptionThrown);
    }
    
    private static void assertDefaultPageSize(SObjectPaginator paginator){
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE, paginator.pageSize);
    }
    
    private static void assertDefaultPageSizeOptions(SObjectPaginator paginator){
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE_OPTIONS, paginator.pageSizeIntegerOptions);
        final List<SelectOption> SEL_OPTIONS = new List<SelectOption>(); 
        for(Integer i : SObjectPaginator.DEFAULT_PAGE_SIZE_OPTIONS){
            SEL_OPTIONS.add(new SelectOption(''+i,''+i));
        }
        //ArrayUtils.assertArraysAreEqual(SEL_OPTIONS, paginator.pageSizeSelectOptions);
        System.assertNotEquals(null, paginator.getPageSizeOptions());
    }
    
    private static void assertDefaultSkipSize(SObjectPaginator paginator){
        System.assertEquals(SObjectPaginator.DEFAULT_SKIP_SIZE, paginator.skipSize);
    }
    
    private static void assertDefaultListener(SObjectPaginator paginator){
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(0, paginator.listeners.size());
    }
    
    private static testmethod void testConstructor01(){
        //global SObjectPaginator(){
        final SObjectPaginator paginator = new SObjectPaginator();
        assertDefaultPageSize(paginator);
        assertDefaultPageSizeOptions(paginator);
        assertDefaultSkipSize(paginator);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor02(){
        //global SObjectPaginator(SObjectPaginatorListener listener ){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();

        final SObjectPaginator paginator = new SObjectPaginator(EXAMPLE_LISTENER);
        assertDefaultPageSize(paginator);
        assertDefaultPageSizeOptions(paginator);
        assertDefaultSkipSize(paginator);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor03(){
        //global SObjectPaginator(List<Integer> pageSizeIntegerOptions ){
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{-1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(EXAMPLE_PAGE_LIST_OPTIONS);
        assertDefaultPageSize(paginator);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        assertDefaultSkipSize(paginator);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor04(){
        //global SObjectPaginator(List<Integer> pageSizeIntegerOptions,SObjectPaginatorListener listener ){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(EXAMPLE_PAGE_LIST_OPTIONS,EXAMPLE_LISTENER);
        assertDefaultPageSize(paginator);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        assertDefaultSkipSize(paginator);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor05(){
        //global SObjectPaginator(List<Integer> pageSizeIntegerOptions,Integer skipSize ){
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(EXAMPLE_PAGE_LIST_OPTIONS,10);
        assertDefaultPageSize(paginator);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        System.assertEquals(10, paginator.skipSize);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor06(){
        //global SObjectPaginator(List<Integer> pageSizeIntegerOptions,Integer skipSize,SObjectPaginatorListener listener ){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(EXAMPLE_PAGE_LIST_OPTIONS,10,EXAMPLE_LISTENER);
        assertDefaultPageSize(paginator);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        System.assertEquals(10, paginator.skipSize);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor07(){
        //global SObjectPaginator(Integer pageSize ){

        final SObjectPaginator paginator = new SObjectPaginator(10);
        System.assertEquals(10, paginator.pageSize);
        assertDefaultPageSizeOptions(paginator);
        assertDefaultSkipSize(paginator);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor08(){
        //global SObjectPaginator(Integer pageSize,SObjectPaginatorListener listener ){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();

        final SObjectPaginator paginator = new SObjectPaginator(10,EXAMPLE_LISTENER);
        System.assertEquals(10, paginator.pageSize);
        assertDefaultPageSizeOptions(paginator);
        assertDefaultSkipSize(paginator);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor09(){
        //global SObjectPaginator(Integer pageSize,Integer skipSize ){
        final SObjectPaginator paginator = new SObjectPaginator(10,10);
        
        System.assertEquals(10, paginator.pageSize);
        assertDefaultPageSizeOptions(paginator);
        System.assertEquals(10, paginator.skipSize);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor10(){
        //global SObjectPaginator(Integer pageSize,Integer skipSize,SObjectPaginatorListener listener ){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();

        final SObjectPaginator paginator = new SObjectPaginator(10,10,EXAMPLE_LISTENER);
        System.assertEquals(10, paginator.pageSize);
        assertDefaultPageSizeOptions(paginator);
        System.assertEquals(10, paginator.skipSize);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor11(){
        //global SObjectPaginator(Integer pageSize,List<Integer> pageSizeIntegerOptions){
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(10,EXAMPLE_PAGE_LIST_OPTIONS);
        System.assertEquals(10, paginator.pageSize);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        assertDefaultSkipSize(paginator);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor12(){
        //global SObjectPaginator(Integer pageSize,List<Integer> pageSizeIntegerOptions,SObjectPaginatorListener listener){
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();

        final SObjectPaginator paginator = new SObjectPaginator(10,EXAMPLE_PAGE_LIST_OPTIONS,EXAMPLE_LISTENER);
        System.assertEquals(10, paginator.pageSize);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        assertDefaultSkipSize(paginator);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testConstructor13(){
        //global SObjectPaginator(Integer pageSize,List<Integer> pageSizeIntegerOptions,Integer skipSize){
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(10,EXAMPLE_PAGE_LIST_OPTIONS,10);
        System.assertEquals(10, paginator.pageSize);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        System.assertEquals(10, paginator.skipSize);
        assertDefaultListener(paginator);
    }
    
    private static testmethod void testConstructor14(){
        //global SObjectPaginator(Integer pageSize,List<Integer> pageSizeIntegerOptions, Integer skipSize, SObjectPaginatorListener listener){
        final SObjectPaginatorListener EXAMPLE_LISTENER = new SObjectPaginatorListenerForTesting();
        final List<Integer> EXAMPLE_PAGE_LIST_OPTIONS = new List<Integer>{1,2,3};

        final SObjectPaginator paginator = new SObjectPaginator(10,EXAMPLE_PAGE_LIST_OPTIONS,10,EXAMPLE_LISTENER);
        System.assertEquals(10, paginator.pageSize);
        System.assertEquals(EXAMPLE_PAGE_LIST_OPTIONS, paginator.pageSizeIntegerOptions);
        System.assertEquals(10, paginator.skipSize);
        System.assertNotEquals(null, paginator.listeners);
        System.assertEquals(1, paginator.listeners.size());
        System.assertEquals(EXAMPLE_LISTENER, paginator.listeners.get(0));
    }
    
    private static testmethod void testSkipToPage(){
        SObjectPaginator paginator = new SObjectPaginator(3);
        paginator.setRecords(createTestAccount(10));
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
        SObjectPaginatorListenerForTesting listener = new SObjectPaginatorListenerForTesting();
        System.assertEquals(false,listener.handlePageChangeInvoked); 
        List<SObject> records = createTestAccount(8);
        SObjectPaginator paginator = new SObjectPaginator(listener);
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
        paginator.setRecords(createTestAccount(6)); 
        System.assertEquals(true,listener.handlePageChangeInvoked);
    }
    
    private static testmethod void testBadInput(){
        SObjectPaginator paginator = new SObjectPaginator();
        paginator.setRecords(null);
        System.assertEquals(null,paginator.all);
        System.assertEquals(null,paginator.page);
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
        System.assertEquals(0,paginator.pageNumber);
        System.assertEquals(0, paginator.pageCount);
        System.assertEquals(false,paginator.hasNext);
        System.assertEquals(false,paginator.hasPrevious);

        paginator = new SObjectPaginator();
        paginator.setRecords(new List<Account>());
        System.assertNotEquals(null,paginator.all);
        System.assertEquals(0,paginator.all.size());
        System.assertEquals(null,paginator.page);
        System.assertEquals(SObjectPaginator.DEFAULT_PAGE_SIZE,paginator.pageSize);
        System.assertEquals(0,paginator.pageNumber);
        System.assertEquals(0, paginator.pageCount);
        System.assertEquals(false,paginator.hasNext);
        System.assertEquals(false,paginator.hasPrevious);
    }
    
    private static testmethod void testFirstAndLast(){
        SObjectPaginator paginator = new SObjectPaginator(2);
        paginator.setRecords(createTestAccount(11));
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
        SObjectPaginator paginator = new SObjectPaginator(2,3);
        paginator.setRecords(createTestAccount(11));
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
        
    private static List<Account> createTestAccount(Integer count){
        List<Account> records = new List<Account>();
        for(Integer i = 0; i < count; i++){
            records.add(new Account(name='test'+i));
        }
        return records;
    }
}