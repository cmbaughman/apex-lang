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
private class LanguageUtilsTest {

    private static testmethod void testGetLangCodeByHttpParam(){
        //test: global static String getLangCodeByHttpParam(){
        System.assertNotEquals('es', LanguageUtils.getLangCodeByHttpParam());  
        PageUtils.param('l','XXXXXXXX');
        System.assertNotEquals('es', LanguageUtils.getLangCodeByHttpParam());  
        PageUtils.param('l','es');
        System.assertEquals('es', LanguageUtils.getLangCodeByHttpParam()); 
        PageUtils.param('l','nl');
        System.assertEquals('nl-nl', LanguageUtils.getLangCodeByHttpParam()); 
    }
    
    private static testmethod void testGetLangCodeByBrowser(){
        //test: global static String getLangCodeByBrowser(){
        System.assertNotEquals('es', LanguageUtils.getLangCodeByBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','XXXXXXXX');
        System.assertNotEquals('es', LanguageUtils.getLangCodeByBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','es');
        System.assertEquals('es', LanguageUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','nl');
        System.assertEquals('nl-nl', LanguageUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','es-mx');
        System.assertEquals('es', LanguageUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','en-us,zh-cn;q=0.5');
        System.assertEquals('en-us', LanguageUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','xxxxx,zh-cn;q=0.5');
        System.assertEquals('zh-cn', LanguageUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', LanguageUtils.getLangCodeByBrowser());
    }
    
    private static testmethod void testGetLangCodeByUser(){
        //test: global static String getLangCodeByUser(){
        System.assertEquals(UserInfo.getLanguage(), LanguageUtils.getLangCodeByUser());  
    }


    private static testmethod void testGetLangCodeByHttpParamOrIfNullThenBrowser(){
        //test: global static String getLangCodeByHttpParamOrIfNullThenBrowser(){
        System.assertNotEquals('es', LanguageUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', LanguageUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
        PageUtils.param('l','es');
        System.assertEquals('es', LanguageUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
    }

    private static testmethod void testGetLangCodeByHttpParamOrIfNullThenUser(){
        //test: global static String getLangCodeByHttpParamOrIfNullThenUser(){
        System.assertEquals(UserInfo.getLanguage(), LanguageUtils.getLangCodeByHttpParamOrIfNullThenUser());  
        PageUtils.param('l','es');
        System.assertEquals('es', LanguageUtils.getLangCodeByHttpParamOrIfNullThenUser());  
    }

    private static testmethod void testGetLangCodeByBrowserOrIfNullThenHttpParam(){
        //test: global static String getLangCodeByBrowserOrIfNullThenHttpParam(){
        System.assertNotEquals('es', LanguageUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
        PageUtils.param('l','es');
        System.assertEquals('es', LanguageUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh-cn');
        System.assertEquals('zh-cn', LanguageUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
    }

    private static testmethod void testGetLangCodeByBrowserOrIfNullThenUser(){
        //test: global static String getLangCodeByBrowserOrIfNullThenUser(){
        System.assertNotEquals('es', LanguageUtils.getLangCodeByBrowserOrIfNullThenUser());  
        System.assertEquals(UserInfo.getLanguage(), LanguageUtils.getLangCodeByBrowserOrIfNullThenUser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', LanguageUtils.getLangCodeByBrowserOrIfNullThenUser());  
    }
    
    private static testmethod void testGetLanguageName(){
    	//test: global String getLanguageName(String displayLanguageCode, String languageCode){
		
		//basic tests          
        System.assertEquals('Francouzština', LanguageUtils.getLanguageName('cs','fr'));  
        System.assertEquals('Spanyol', LanguageUtils.getLanguageName('in','es'));  
        System.assertEquals('French', LanguageUtils.getLanguageName('en_US','fr'));
        System.assertEquals('Tsjechisch', LanguageUtils.getLanguageName('nl_nl','cs'));  

		//test conversion to lower-case
        System.assertEquals('Francouzština', LanguageUtils.getLanguageName('CS','FR'));

		//test default to english
        System.assertEquals('French', LanguageUtils.getLanguageName('xx','fr'));

		//test default substitution; ie nl => nl_nl
        System.assertEquals('Tsjechisch', LanguageUtils.getLanguageName('nl','cs'));  
    }
    
    private static testmethod void testGetAllLanguageSelectOptions(){
    	//test: global static List<SelectOption> getAllLanguageSelectOptions(){
    	final List<SelectOption> languages = LanguageUtils.getAllLanguageSelectOptions();
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(null,languages.get(0));
    	System.assertEquals('Chinese (Simplified)',languages.get(0).getLabel());
    	System.assertNotEquals(null,languages.get(1));
    	System.assertEquals('Chinese (Traditional)',languages.get(1).getLabel());
    	System.assertNotEquals(null,languages.get(2));
    	System.assertEquals('Czech',languages.get(2).getLabel());
    }
    
    private static testmethod void testGetAllLanguageSelectOptions2(){
    	//test: global static List<SelectOption> getAllLanguageSelectOptions(String displayLanguageCode){
    	final List<SelectOption> languages = LanguageUtils.getAllLanguageSelectOptions('ru');
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(null,languages.get(0));
    	System.assertEquals('Английский (США)',languages.get(0).getLabel());
    	System.assertNotEquals(null,languages.get(1));
    	System.assertEquals('Венгерский',languages.get(1).getLabel());
    	System.assertNotEquals(null,languages.get(2));
    	System.assertEquals('Голландский',languages.get(2).getLabel());
    }
    
    private static testmethod void testgetAllLanguages(){
    	//test: global static Map<String,String> getAllLanguages(){
    	final Map<String,String> languages = LanguageUtils.getAllLanguages();
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(0,languages.size());
        System.assertEquals('French', languages.get('fr'));
        System.assertEquals('Italian', languages.get('it'));
	}    	
    
    private static testmethod void testgetAllLanguages2(){
    	//test: global static Map<String,String> getAllLanguages(String displayLanguageCode){
    	final Map<String,String> languages = LanguageUtils.getAllLanguages('ru');
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(0,languages.size());
        System.assertEquals('Французский', languages.get('fr'));
        System.assertEquals('Итальянский', languages.get('it'));
	}    	
    
}