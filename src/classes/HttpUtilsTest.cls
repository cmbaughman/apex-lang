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
private class HttpUtilsTest {

    private static final String DATA = '<?xml version="1.0" encoding="UTF-8"?><a><b /></a>'; 

    private static testmethod void test_send_NULL(){
        Boolean exceptionCaught = false;
        try{
            HttpUtils.sendReturnBody(null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void test_sendReturnBody(){
        HttpUtils.pushTest(DATA);
        System.assertEquals(DATA,HttpUtils.sendReturnBody(new HttpRequest()));
    }
        
    private static testmethod void test_sendReturnDocument(){
        final HttpResponse response = new HttpResponse();
        response.setBody(DATA);
        response.setHeader('abc','efg'); 
        HttpUtils.pushTest(response);
        final Dom.Document doc = HttpUtils.sendReturnDocument(new HttpRequest());
        System.assertNotEquals(null,doc);
        System.assertEquals(DATA,doc.toXmlString());
    }
        
    private static testmethod void test_sendReturnReader(){
        final HttpResponse response = new HttpResponse();
        response.setBody(DATA); 
        HttpUtils.pushTest(response);
        final XmlStreamReader reader = HttpUtils.sendReturnReader(new HttpRequest());
        System.assertNotEquals(null,reader);
        System.assertNotEquals(DATA,reader.toString());
    }
        
}