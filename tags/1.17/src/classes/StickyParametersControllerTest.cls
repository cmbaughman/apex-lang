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
private class StickyParametersControllerTest {
    
    private class ConcreteStickyParametersController extends StickyParametersController{
        public ConcreteStickyParametersController(String[] stickyParams){
            super(stickyParams);
        }
    }

    private static testmethod void testBadInput(){
        //test with nulls
        StickyParametersController controller = new ConcreteStickyParametersController(null);
        PageReference nextPage = controller.standardRedirect(null);
        System.assertEquals(null, nextPage);
        
        //test with no params
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'));
        assertValidPageReference(thePage, 'http://google.com');
    }
    
    private static testmethod void testOneParam(){
        //test with param key with doesn't match sticky key(s)
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','123');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abcxxxxxx'});
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'));
        assertValidPageReference(thePage, 'http://google.com');

        //test with one param that matches
        controller = new ConcreteStickyParametersController(new String[]{'abc'});
        thePage = controller.standardRedirect(new PageReference('http://google.com'));
        assertValidPageReference(thePage, 'http://google.com?abc=123');
    }

    private static testmethod void testMultipleParams(){
        //test with param key with doesn't match sticky key(s)
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','123');
        params.put('efg','456');
        params.put('hij','789');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abc','efg','hij'});
        Map<String,String> extraParams = new Map<String,String>();
        extraParams.put('aaa','111');
        extraParams.put('bbb','222');
        extraParams.put('ccc','333');
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'),extraParams);
        assertValidPageReference(thePage, 'http://google.com?abc=123&efg=456&hij=789&aaa=111&bbb=222&ccc=333');
    }

    private static testmethod void testPassingExtraParams(){
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','123');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abc'});
        Map<String,String> extraParams = new Map<String,String>();
        extraParams.put('efg','456');
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'),extraParams);
        assertValidPageReference(thePage, 'http://google.com?efg=456&abc=123');
    }
    
    private static testmethod void testEncodedParams(){
        //test with param key with doesn't match sticky key(s)
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','http://google.com?a=b');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abc'});
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'));
        assertValidPageReference(thePage, 'http://google.com?abc=http%253A%252F%252Fgoogle.com%253Fa%253Db');
    }

    private static testmethod void testEncodedParams2(){
        //test with param key with doesn't match sticky key(s)
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','http%3A%2F%2Fgoogle.com%3Fa%3Db');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abc'});
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'));
        //assertValidPageReference(thePage, 'http://google.com?abc=http%25253A%25252F%25252Fgoogle.com%25253Fa%25253Db');
    }
    
    private static testmethod void testOverrideParams(){
        //test with param key with doesn't match sticky key(s)
        Map<String,String> params = ApexPages.currentPage().getParameters();
        params.put('abc','123');
        params.put('efg','456');
        params.put('hij','789');
        ConcreteStickyParametersController controller = new ConcreteStickyParametersController(new String[]{'abc','efg','hij'});
        Map<String,String> extraParams = new Map<String,String>();
        extraParams.put('efg','111');
        extraParams.put('bbb','222');
        extraParams.put('ccc','333');
        PageReference thePage = controller.standardRedirect(new PageReference('http://google.com'),extraParams);
        assertValidPageReference(thePage, 'http://google.com?abc=123&efg=111&hij=789&bbb=222&ccc=333');
    }

    private static void assertValidPageReference(PageReference thePage, String expectedUrl){
        System.assertNotEquals(null, thePage);
        System.assertNotEquals(null, thePage.getUrl());
        
        System.assertEquals(true, thePage.getRedirect());
        
        System.assertEquals(UrlUtils.getBase(expectedUrl), UrlUtils.getBase(thePage.getUrl()));
        Map<String,String> expectedParams = UrlUtils.getParams(expectedUrl);
        Map<String,String> actualParams = UrlUtils.getParams(thePage.getUrl());
        System.assert( MapUtils.equals(expectedParams,actualParams), 
            'Parameters not equal: ' + MapUtils.toString(expectedParams) + ', ' + MapUtils.toString(actualParams));
    }

    
}