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
global class LanguageUtils {

    global static final String HTTP_LANGUAGE_CODE_PARAMETER_KEY = 'l';

    global static Set<String> SUPPORTED_LANGUAGE_CODES = new Set<String>{
        'zh-cn'         //Chinese (Simplified)
        ,'zh-tw'        //Chinese (Traditional)
        ,'nl-nl'        //Dutch
        ,'en-us'        //English
        ,'fi'           //Finnish
        ,'fr'           //French
        ,'de'           //German
        ,'it'           //Italian
        ,'ja'           //Japanese
        ,'ko'           //Korean
        ,'pl'           //Polish
        ,'pt-br'        //Portuguese (Brazilian)
        ,'ru'           //Russian
        ,'es'           //Spanish
        ,'sv'           //Swedish
        ,'th'           //Thai
        ,'cs'           //Czech
        ,'da'           //Danish
        ,'hu'           //Hungarian
        ,'in'           //Indonesian
        ,'tr'           //Turkish
    };
    
    private static Map<String,String> DEFAULTS = new Map<String,String>{
        'en'=>'en-us'
        ,'zh'=>'zh-cn'
        ,'nl'=>'nl-nl'
        ,'pt'=>'pt-br'
    };
    

    global static String getLangCodeByHttpParam(){
        final Set<String> LANGUAGE_CODE_SET = getSuppLangCodeSet();
        String LANGUAGE_HTTP_PARAMETER = 
            StringUtils.lowerCase(
                StringUtils.replaceChars( 
                    PageUtils.param(HTTP_LANGUAGE_CODE_PARAMETER_KEY)
                    , '_' //underscore
                    , '-' //dash
                )
            );
        if(DEFAULTS.containsKey(LANGUAGE_HTTP_PARAMETER)){
            LANGUAGE_HTTP_PARAMETER = DEFAULTS.get(LANGUAGE_HTTP_PARAMETER);
        }
        if(StringUtils.isNotBlank(LANGUAGE_HTTP_PARAMETER)
            && SUPPORTED_LANGUAGE_CODES.contains(LANGUAGE_HTTP_PARAMETER)){
            return LANGUAGE_HTTP_PARAMETER;
        }        
        return null;
    }

    global static String getLangCodeByBrowser(){
        final String LANGUAGES_FROM_BROWSER_AS_STRING = ApexPages.currentPage().getHeaders().get('Accept-Language');
        final List<String> LANGUAGES_FROM_BROWSER_AS_LIST = splitAndFilterAcceptLanguageHeader(LANGUAGES_FROM_BROWSER_AS_STRING);
        if(LANGUAGES_FROM_BROWSER_AS_LIST != null && LANGUAGES_FROM_BROWSER_AS_LIST.size() > 0){
            for(String languageFromBrowser : LANGUAGES_FROM_BROWSER_AS_LIST){
                if(DEFAULTS.containsKey(languageFromBrowser)){
                    languageFromBrowser = DEFAULTS.get(languageFromBrowser);
                }
                if(SUPPORTED_LANGUAGE_CODES.contains(languageFromBrowser)){
                    return languageFromBrowser;
                }
            }               
        }
        return null;
    }
    
    global static String getLangCodeByUser(){
        return UserInfo.getLanguage();
    }
    
    global static String getLangCodeByHttpParamOrIfNullThenBrowser(){
        return StringUtils.defaultString(getLangCodeByHttpParam(),getLangCodeByBrowser());
    }

    global static String getLangCodeByHttpParamOrIfNullThenUser(){
        return StringUtils.defaultString(getLangCodeByHttpParam(),getLangCodeByUser());
    }
    
    global static String getLangCodeByBrowserOrIfNullThenHttpParam(){
        return StringUtils.defaultString(getLangCodeByBrowser(),getLangCodeByHttpParam());
    }
    
    global static String getLangCodeByBrowserOrIfNullThenUser(){
        return StringUtils.defaultString(getLangCodeByBrowser(),getLangCodeByUser());
    }
    
    private static List<String> splitAndFilterAcceptLanguageHeader(String header){
        List<String> returnList = new List<String>();
        String[] tokens = StringUtils.split(header,',');
        if(tokens != null){
            for(String token : tokens){
                if(token != null ){
                    if(token.contains(';')){
                        token = token.substring(0,token.indexOf(';',0));
                    }
                    returnList.add(token);
                    if(StringUtils.length(token) > 2){
                        returnList.add(StringUtils.substring(token,0,2));
                    }
                }
            }       
        }
        return returnList;
    }
    
    private static Set<String> getSuppLangCodeSet(){
        Set<String> langCodes = new Set<String>();
        for(String langCode : SUPPORTED_LANGUAGE_CODES){
            if(langCode != null){ 
                langCodes.add(StringUtils.lowerCase(langCode));
            }
        }
        return langCodes;
    }
    
}