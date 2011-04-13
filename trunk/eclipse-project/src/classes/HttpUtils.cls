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
global with sharing class HttpUtils {

    //holds responses which can be added to support unit testing of web service callouts
    private static final List<HttpResponse> responses = new List<HttpResponse>();
    
    /*
     * Use this method to push test responses for your unit tests.  
     * 
     *   HttpUtils.pushTest('<response></response>')
     * 
     * Subsequent calls to HttpUtils.send(request) will return the response you
     * specified in pushTest.
     */
    global static void pushTest(HttpResponse testResponse){ 
        responses.add(testResponse); 
    }
    
    global static void pushTest(String body){ 
    	final HttpResponse testResponse = blankResponse();
    	testResponse.setBody(body);
        responses.add(testResponse); 
    }
    
    /*
     * Simple HTTP send that allows test responses to be returned via pushTest.
     */
    global static HttpResponse send(HttpRequest request){
    	if(request == null) throw new IllegalArgumentException('request argument cannot be null');
        debug(request);
        
    	HttpResponse response = null;
        if(Test.isRunningTest()) response = popTest();
        else                     response = (new Http()).send(request);
    	debug(response);
    	return response;
    }
    
    global static String sendReturnBody(HttpRequest request){
    	final String returnValue = null;
        final HttpResponse response = send(request);
        if(response != null){
        	returnValue = response.getBody();
        }
        return returnValue;
    }
    
    global static Dom.Document sendReturnDocument(HttpRequest request){
        final Dom.Document returnValue = null;
        final HttpResponse response = send(request);
        if(response != null){
            returnValue = response.getBodyDocument();
        }
        return returnValue;
    }

    global static XmlStreamReader sendReturnReader(HttpRequest request){
        final XmlStreamReader returnValue = null;
        final HttpResponse response = send(request);
        if(response != null){
            returnValue = response.getXmlStreamReader();
        }
        return returnValue;
    }

    private static HttpResponse popTest(){ 
        return responses.isEmpty() ? blankResponse() : responses.remove(0); 
    }

    private static HttpResponse blankResponse(){
    	final HttpResponse returnValue = new HttpResponse();
        returnValue.setBody(''); 
        returnValue.setStatusCode(200); 
        return returnValue; 
    }

    global static void debug(HttpRequest request){
        System.debug(toStr(request));
    }
    
    global static String toStr(HttpRequest request){
        String returnValue = '';
        if(request != null){
            returnValue = '\n'
                + '\n###########################################################'
                + '\nHTTP REQUEST: ' 
                + '\n###########################################################'
                + '\nCompressed: ' + request.getCompressed()
                + '\nEndpoint: ' + request.getEndpoint()
                + '\nMethod: ' + request.getMethod()
                + '\nBody: '
                + '\n' + request.getBody()
                + '\n'
                + '\n';
        }
        return returnValue;
    }
    
    global static void debug(HttpResponse response){
        if(response != null){
            System.debug('\n'
                + '\n###########################################################'
                + '\nHTTP RESPONSE: ' 
                + '\n###########################################################'
                + '\nHeaders:    ' + retrieveHeaders(response)
                + '\nStatusCode: ' + response.getStatusCode()
                + '\nStatus:     ' + response.getStatus()
                + '\nBody: '
                + '\n' + response.getBody()
                + '\n'
                + '\n'
            );
        }
    }

    global static String retrieveHeaders(HttpResponse response){
        String returnValue = '';
        if(response != null && response.getHeaderKeys() != null && response.getHeaderKeys().size() > 0){
            final Map<String,String> headers = new Map<String,String>();
            for(String key : response.getHeaderKeys()){
                if(key != null){
                    headers.put(key,response.getHeader(key));
                }
            }
            returnValue = MapUtils.joinMap(headers,'=',',');
        }
        returnValue = '[' + returnValue + ']';
        return returnValue;
    }    

}