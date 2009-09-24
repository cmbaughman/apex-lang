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

}