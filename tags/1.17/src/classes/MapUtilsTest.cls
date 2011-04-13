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
private class MapUtilsTest {

    private static testmethod void testJoinMap(){
        //test public static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator)
        assertJoinMap(null,null,null,null);
        Map<String,String> theMap = new Map<String,String>();
        assertJoinMap(theMap,null,null,'');
        assertJoinMap(theMap,'=','&','');
        theMap.put('xyz','123');
        theMap.put('abc','efc');
        assertJoinMap(theMap,'=','&','xyz=123&abc=efc');
        theMap.remove('abc');
        assertJoinMap(theMap,'=','&','xyz=123');
        theMap.put('abc','efc');
        theMap.put('59394932','asdfasdfasldjlaksdjf');
        assertJoinMap(theMap,'=','&','xyz=123&abc=efc&59394932=asdfasdfasldjlaksdjf'); 
    }
    
    private static void assertJoinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator, String expected){
        String actual = MapUtils.joinMap(theMap, keyValueSeparator, recordSeparator);
        if(theMap == null || theMap.size() <= 0){
            System.assert(StringUtils.isBlank(expected), 'MapUtils.joinMap(Map<String,String>, \'' 
                + (keyValueSeparator == null ? 'null' : keyValueSeparator) + '\', \'' + (recordSeparator == null ? 'null' : recordSeparator) 
                + '\') returned ' + actual);
            return;
        }
        Set<String> actualAsSet = new Set<String>(StringUtils.split(actual,recordSeparator));
        Set<String> expectedAsSet = new Set<String>(StringUtils.split(expected,recordSeparator));
        System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet), 'MapUtils.joinMap(Map<String,String>, \'' 
            + (keyValueSeparator == null ? 'null' : keyValueSeparator) + '\', \'' + (recordSeparator == null ? 'null' : recordSeparator) 
            + '\') returned ' + actual);
    }
    
    private static testmethod void testToString(){
        //test public static String toString(Map<String,String> theMap)
        Map<String,String> theMap = new Map<String,String>();
        theMap.put('xyz','123');
        System.assertEquals('<Map#([xyz=123])>',MapUtils.toString(theMap));
    }

    private static testmethod void testEquals(){
        //test: global static Boolean equals(Map<String,String> map1, Map<String,String> map2)
        Map<String,String> map1 = new Map<String,String>();
        Map<String,String> map2 = new Map<String,String>();
        assertEquals(null,null,true);
        assertEquals(null,map1,false);
        assertEquals(map1,null,false);
        map1.put('xyz','123');
        assertEquals(map1,map2,false);
        map2.put('xyz2','123');
        assertEquals(map1,map2,false);
        map2.remove('xyz2');
        map2.put('xyz','123x');
        assertEquals(map1,map2,false);
        map2.put('xyz','123');
        assertEquals(map1,map2,true);
    }
    
    private static void assertEquals(Map<String,String> map1, Map<String,String> map2, Boolean expected){
        Boolean actual = MapUtils.equals(map1,map2);
        System.assert(actual == expected, 'MapUtils.equals(' + MapUtils.toString(map1) + ',' + 
            MapUtils.toString(map2) + ') returned ' + actual);
    }
    
    private static testmethod void test_lowerCaseKeys(){
        MapUtils.assertEquals(null,MapUtils.lowerCaseKeys(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.lowerCaseKeys(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'abcdefgh'=>'MnOPQrstUv'
                ,'xyz'=>'aTiejcFGEkdkd'
             }
            ,MapUtils.lowerCaseKeys(new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
            }) 
        );
    }
    
    private static testmethod void test_upperCaseKeys(){
        MapUtils.assertEquals(null,MapUtils.upperCaseKeys(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.upperCaseKeys(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'ABCDEFGH'=>'MnOPQrstUv'
                ,'XYZ'=>'aTiejcFGEkdkd'
             }
            ,MapUtils.upperCaseKeys(new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
            }) 
        );
    }
    
    private static testmethod void test_trimKeys(){
        MapUtils.assertEquals(null,MapUtils.trimKeys(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.trimKeys(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
             }
            ,MapUtils.trimKeys(new Map<String,String>{
                 '   aBcDEfgH   \t\n'=>'MnOPQrstUv'
                ,'  XyZ  '=>'aTiejcFGEkdkd'
            }) 
        );
    }
    
    private static testmethod void test_lowerCaseValues(){
        MapUtils.assertEquals(null,MapUtils.lowerCaseValues(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.lowerCaseValues(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'aBcDEfgH'=>'mnopqrstuv'
                ,'XyZ'=>'atiejcfgekdkd'
             }
            ,MapUtils.lowerCaseValues(new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
            }) 
        );
    }
    
    private static testmethod void test_upperCaseValues(){
        MapUtils.assertEquals(null,MapUtils.upperCaseValues(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.upperCaseValues(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'aBcDEfgH'=>'MNOPQRSTUV'
                ,'XyZ'=>'ATIEJCFGEKDKD'
             }
            ,MapUtils.upperCaseValues(new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
            }) 
        );
    }
    
    private static testmethod void test_trimValues(){
        MapUtils.assertEquals(null,MapUtils.trimValues(null));
        MapUtils.assertEquals(new Map<String,String>(),MapUtils.trimValues(new Map<String,String>()));
        MapUtils.assertEquals(
             new Map<String,String>{
                 'aBcDEfgH'=>'MnOPQrstUv'
                ,'XyZ'=>'aTiejcFGEkdkd'
             }
            ,MapUtils.trimValues(new Map<String,String>{
                 'aBcDEfgH'=>'   MnOPQrstUv   \t\n'
                ,'XyZ'=>'  aTiejcFGEkdkd  '
            }) 
        );
    }
    
}