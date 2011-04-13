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
global class TestUtils {

    global static void assertConfirmMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
    global static void assertInfoMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
    global static void assertWarningMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
    global static void assertErrorMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
    global static void assertFatalMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

    global static void assertNoConfirmMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
    global static void assertNoInfoMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
    global static void assertNoWarningMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
    global static void assertNoErrorMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
    global static void assertNoFatalMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

    global static void assertMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
        final ApexPages.Message[] messages = PageUtils.getMessagesAtLevel(level,includeHigher);
        System.assert(messages != null && messages.size() > 0,'No errors exist');
    }
    
    global static void assertNoMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
        final ApexPages.Message[] messages = PageUtils.getMessagesAtLevel(level,includeHigher);
        System.assert(messages == null || messages.size() <= 0,PageUtils.messagesToString(messages));
    } 
    
    
    global static List<SObject> getObject(SObject prototype, Integer count){
        return getObject(prototype,count,null,false);
    }
    
    global static List<SObject> getObject(SObject prototype, Integer count, Map<String,String> mString){
        return getObject(prototype,count,mString,false);
    }
    
    global static List<SObject> getObject(SObject prototype, Integer count, Map<String,String> mString, Boolean doInsert){
        final Integer MAX_COUNT = 100;
        if(prototype == null){
            return null;
        }
        //the following will for sure work; however, it requires a describe
        //String objectName = prototype.getSObjectType().getDescribe().getName();
        
        //the following will work using observed string representations of SObjects
        String objectName = StringUtils.split(''+prototype,':')[0];
        
        List<SObject> objects = Database.query(
            'select Id from ' 
            + objectName 
            + ' where Id = \'0015000000Mrr40\' LIMIT 0'); // use dummy Id to ensure no return
        if(count <= 0){
            return objects;
        }
        Schema.sObjectType prototypeToken = prototype.getSObjectType();
        for(Integer i = 0; i < count && i < MAX_COUNT; i++){
            objects.add((SObject)prototypeToken.newSObject());
        }

        if(mString != null && !mString.isEmpty()){
            for(SObject anObject : objects){
                for(String key : mString.keySet()){
                    anObject.put(key,mString.get(key));
                }            
            }
        }
        if(doInsert){
            insert objects;
        }    
        return objects;
    } 
    
    global static void assertUrlsAreEqual(String expected, String actual){
        final PageReference expectedRealPageReference = new PageReference(StringUtils.defaultString(expected));
        final PageReference actualRealPageReference = new PageReference(StringUtils.defaultString(actual));
        final String actualBasePath = StringUtils.substringBefore(actual,'?');
        final String expectedBasePath = StringUtils.substringBefore(expected,'?');
        System.assertEquals(    
             expectedBasePath
            ,actualBasePath
            ,'Base paths don\'t match, expected: ' + expectedBasePath + ', actual: ' + actualBasePath
        );
        System.assert(
            MapUtils.equals(expectedRealPageReference.getParameters(),actualRealPageReference.getParameters())
            ,'HTTP Parameters don\'t match, expected: ' + expectedRealPageReference.getParameters() + ', actual: ' + actualRealPageReference.getParameters()    
        );
    }

    

}