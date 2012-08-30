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
private class UrlUtilsTest {

    private static testmethod void testGetBase(){
        //test: global static String getBase(String url){
        assertGetBase(null, null);
        assertGetBase('', null);
        assertGetBase('http://google.com', 'http://google.com');
        assertGetBase('http://google.com?abc=123', 'http://google.com');
    }

    private static void assertGetBase(String url, String expected){
        String actual = UrlUtils.getBase(url);
        System.assert(actual==expected, 'UrlUtils.getBase(\'' + url + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testGetParams(){
        //global static Map<String,String> getParams(String url){
        Map<String,String> theMap = new Map<String,String>();
        assertGetParams(null, theMap);
        assertGetParams('', theMap);
        assertGetParams('http://google.com', theMap);
        theMap.put('xyz','12&3');
        theMap.put('abc','efc');
        assertGetParams('http://google.com?abc=efc&xyz=12%263', theMap);
    }

    private static void assertGetParams(String url, Map<String,String> expected){
        Map<String,String> actual = UrlUtils.getParams(url);
        System.assert(actual==expected, 'UrlUtils.getParams(\'' + url + '\') returned \'' 
            + MapUtils.toString(actual) + '\'; expected \'' + MapUtils.toString(expected) + '\'');
    }

    private static testmethod void testEnsureUrlBeginsWithHttp(){
        //test: global static String ensureUrlBeginsWithHttp(String url)
        System.assertEquals('http://xyz.com', UrlUtils.ensureUrlBeginsWithHttp('xyz.com'));
        System.assertEquals('http://xyz.com', UrlUtils.ensureUrlBeginsWithHttp('http://xyz.com'));
    }

}