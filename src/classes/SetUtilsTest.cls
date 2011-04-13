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
private class SetUtilsTest {

    private static testmethod void test_lowerCase_SetString(){
        //test: global static Set<String> lowerCase(Set<String> strs){
        SetUtils.assertEquals(null,SetUtils.lowerCase(null));
        SetUtils.assertEquals(new Set<String>(),SetUtils.lowerCase(new Set<String>()));
        SetUtils.assertEquals(new Set<String>{'a','b','abcd'},SetUtils.lowerCase(new Set<String>{'A','B','ABCD'}));
    }

    private static testmethod void test_upperCase_SetString(){
        //test: global static Set<String> upperCase(Set<String> strs){
        SetUtils.assertEquals(null,SetUtils.upperCase(null));
        SetUtils.assertEquals(new Set<String>(),SetUtils.upperCase(new Set<String>()));
        SetUtils.assertEquals(new Set<String>{'A','B','ABCD'},SetUtils.upperCase(new Set<String>{'a','b','abcd'}));
    }

    private static testmethod void test_trim_SetString(){
        //test: global static Set<String> trim(Set<String> strs){
        SetUtils.assertEquals(null,SetUtils.trim(null));
        SetUtils.assertEquals(new Set<String>(),SetUtils.trim(new Set<String>()));
        SetUtils.assertEquals(new Set<String>{'a','b','abcd'},SetUtils.trim(new Set<String>{' a\t\n ',' \tb\n ',' abcd '}));
    }


    private static testmethod void test_listToSet_ListString(){
    	//test: global static Set<String> listToSet(List<String> aList){
        final List<String> aList = null;
        System.assertEquals(null,SetUtils.listToSet(aList));
        System.assertEquals(0,SetUtils.listToSet(new List<String>()).size());
        System.assertEquals(1,SetUtils.listToSet(new List<String>{''}).size());
        System.assertEquals(1,SetUtils.listToSet(new List<String>{'a'}).size());
        System.assertEquals(2,SetUtils.listToSet(new List<String>{'a','b'}).size());
        System.assertEquals(1,SetUtils.listToSet(new List<String>{'a','a'}).size());
    }
    
    private static testmethod void test_listToSet_ListObject(){
        //test: global static Set<Object> listToSet(List<Object> aList){
        final List<Object> aList = null;
        System.assertEquals(null,SetUtils.listToSet(aList));
        System.assertEquals(0,SetUtils.listToSet(new List<Object>()).size());
        System.assertEquals(1,SetUtils.listToSet(new List<Object>{''}).size());
        System.assertEquals(1,SetUtils.listToSet(new List<Object>{'a'}).size());
        System.assertEquals(2,SetUtils.listToSet(new List<Object>{'a','b'}).size());
        System.assertEquals(1,SetUtils.listToSet(new List<Object>{'a','a'}).size());
    }
    
    private static testmethod void test_listToSet_ListSObject(){
        //test: global static Set<SObject> listToSet(List<SObject> records){        
        final List<SObject> aList = null;
        System.assertEquals(null,SetUtils.listToSet(aList));
        System.assertEquals(0,SetUtils.listToSet(new List<SObject>()).size());
        System.assertEquals(1,SetUtils.listToSet(new List<SObject>{new Account()}).size());
        System.assertEquals(1,SetUtils.listToSet(new List<SObject>{new Account()}).size());
        System.assertEquals(2,SetUtils.listToSet(new List<SObject>{new Account(name='1'),new Account(name='2')}).size());
    }
    
    private static testmethod void test_setToList_String(){
        //test: global static List<String> setToList(Set<String> records){        
        final Set<String> records = null;
        System.assertEquals(null,SetUtils.setToList(records));
        System.assertEquals(0,SetUtils.setToList(new Set<String>()).size());
        System.assertEquals(1,SetUtils.setToList(new Set<String>{''}).size());
        System.assertEquals(1,SetUtils.setToList(new Set<String>{'a'}).size());
        System.assertEquals(2,SetUtils.setToList(new Set<String>{'a','b'}).size());
        System.assertEquals(1,SetUtils.setToList(new Set<String>{'a','a'}).size());
    }

    private static testmethod void test_setToList_Object(){
        //test: global static List<Object> setToList(Set<Object> records){        
        final Set<Object> records = null;
        System.assertEquals(null,SetUtils.setToList(records));
        System.assertEquals(0,SetUtils.setToList(new Set<Object>()).size());
        System.assertEquals(1,SetUtils.setToList(new Set<Object>{''}).size());
        System.assertEquals(1,SetUtils.setToList(new Set<Object>{'a'}).size());
        System.assertEquals(2,SetUtils.setToList(new Set<Object>{'a','b'}).size());
        System.assertEquals(1,SetUtils.setToList(new Set<Object>{'a','a'}).size());
    }

    private static testmethod void test_setToList_SetSObject(){
        //test: global static List<SObject> setToList(Set<SObject> records){        
        final Set<String> records = null;
        System.assertEquals(null,SetUtils.setToList(records));
        System.assertEquals(0,SetUtils.setToList(new Set<SObject>()).size());
        System.assertEquals(1,SetUtils.setToList(new Set<SObject>{new Account()}).size());
        System.assertEquals(1,SetUtils.setToList(new Set<SObject>{new Account()}).size());
        System.assertEquals(2,SetUtils.setToList(new Set<SObject>{new Account(name='1'),new Account(name='2')}).size());
    }
    
    private static testmethod void test_pluck_ListSObject_String(){
        //test: global static Set<Object> pluck(List<SObject> records, String fieldName){
        assert_pluck_ListSObject_String(null,null,null);
        assert_pluck_ListSObject_String(null,'name',null);
        assert_pluck_ListSObject_String(new List<SObject>(),null,new Set<Object>());
        assert_pluck_ListSObject_String(new List<SObject>(),'name',new Set<Object>());
        assert_pluck_ListSObject_String(
             new List<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,null
            ,new Set<Object>()
        );
        assert_pluck_ListSObject_String(
             new List<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,'name'
            ,new Set<Object>{'abc123','xyz456'}
        );
    }    
    
    private static void assert_pluck_ListSObject_String(List<SObject> records, String fieldName, Set<Object> expected){
        Set<Object> actual = SetUtils.pluck(records, fieldName);
        SetUtils.assertEquals(expected, actual);    
    }
            
    private static testmethod void test_pluck_SetSObject_String(){
        //test: global static Set<Object> pluck(Set<SObject> records, String fieldName){        
        assert_pluck_SetSObject_String(null,null,null);
        assert_pluck_SetSObject_String(null,'name',null);
        assert_pluck_SetSObject_String(new Set<SObject>(),null,new Set<Object>());
        assert_pluck_SetSObject_String(new Set<SObject>(),'name',new Set<Object>());
        assert_pluck_SetSObject_String(
             new Set<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,null
            ,new Set<Object>()
        );
        assert_pluck_SetSObject_String(
             new Set<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,'name'
            ,new Set<Object>{'abc123','xyz456'}
        );
    }    
    
    private static void assert_pluck_SetSObject_String(Set<SObject> records, String fieldName, Set<Object> expected){
        Set<Object> actual = SetUtils.pluck(records, fieldName);
        SetUtils.assertEquals(expected, actual);    
    }
    
    private static testmethod void test_pluckString_SetSObject_String(){
        //test: global static Set<String> pluckString(Set<SObject> records, String fieldName){        
        assert_pluckString_SetSObject_String(null,null,null);
        assert_pluckString_SetSObject_String(null,'name',null);
        assert_pluckString_SetSObject_String(new Set<SObject>(),null,new Set<String>());
        assert_pluckString_SetSObject_String(new Set<SObject>(),'name',new Set<String>());
        assert_pluckString_SetSObject_String(
             new Set<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,null
            ,new Set<String>()
        );
        assert_pluckString_SetSObject_String(
             new Set<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,'name'
            ,new Set<String>{'abc123','xyz456'}
        );
    }    
    
    private static void assert_pluckString_SetSObject_String(Set<SObject> records, String fieldName, Set<String> expected){
        Set<String> actual = SetUtils.pluckString(records, fieldName);
        SetUtils.assertEquals(expected, actual);    
    }
            
    private static testmethod void test_pluckString_ListSObject_String(){
        //test: global static Set<String> pluckString(List<SObject> records, String fieldName){        
        assert_pluckString_ListSObject_String(null,null,null);
        assert_pluckString_ListSObject_String(null,'name',null);
        assert_pluckString_ListSObject_String(new List<SObject>(),null,new Set<String>());
        assert_pluckString_ListSObject_String(new List<SObject>(),'name',new Set<String>());
        assert_pluckString_ListSObject_String(
             new List<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,null
            ,new Set<String>()
        );
        assert_pluckString_ListSObject_String(
             new List<SObject>{
                 new Account(name='abc123')
                ,new Account(name='xyz456')
            }
            ,'name'
            ,new Set<String>{'abc123','xyz456'}
        );
    }    
    
    private static void assert_pluckString_ListSObject_String(List<SObject> records, String fieldName, Set<String> expected){
        Set<String> actual = SetUtils.pluckString(records, fieldName);
        SetUtils.assertEquals(expected, actual);    
    }

    private static testmethod void testObjectToBlob(){
        //test: global static Set<Blob> objectToBlob(Set<Object> objectSet){ 
        assertObjectToBlob(null, null);
        assertObjectToBlob(new Set<Object>{}, new Set<Blob>{});
        Blob blob1 = generateRandomBlob();
        Blob blob2 = generateRandomBlob();
        assertObjectToBlob(new Set<Object>{blob1}, new Set<Blob>{blob1});
        assertObjectToBlob(new Set<Object>{blob1,blob2}, new Set<Blob>{blob1,blob2});
    } 


    private static testmethod void testObjectToBoolean(){ 
        //test: global static Set<Boolean> objectToBoolean(Set<Object> objectSet){ 
        assertObjectToBoolean(null, null);
        assertObjectToBoolean(new Set<Object>{}, new Set<Boolean>{});
        assertObjectToBoolean(new Set<Object>{true}, new Set<Boolean>{true});
        assertObjectToBoolean(new Set<Object>{true,false}, new Set<Boolean>{false,true});
    }

    private static testmethod void testObjectToDate(){ 
        //test: global static Set<Date> objectToDate(Set<Object> objectSet){ 
        assertObjectToDate(null, null);
        assertObjectToDate(new Set<Object>{}, new Set<Date>{});
        Date date1 = Date.newInstance(2009,1,1);
        Date date2 = Date.newInstance(2009,1,2);
        assertObjectToDate(new Set<Object>{date1}, new Set<Date>{date1});
        assertObjectToDate(new Set<Object>{date1,date2}, new Set<Date>{date1,date2});
    }

    private static testmethod void testObjectToDatetime(){ 
        //test: global static Set<Datetime> objectToDatetime(Set<Object> objectSet){ 
        assertObjectToDatetime(null, null);
        assertObjectToDatetime(new Set<Object>{}, new Set<Datetime>{});
        Datetime date1 = Datetime.newInstance(2009,1,1);
        Datetime date2 = Datetime.newInstance(2009,1,2);
        assertObjectToDatetime(new Set<Object>{date1}, new Set<Datetime>{date1});
        assertObjectToDatetime(new Set<Object>{date1,date2}, new Set<Datetime>{date1,date2});
    }

    private static testmethod void testObjectToDecimal(){ 
        //test: global static Set<Decimal> objectToDecimal(Set<Object> objectSet){
        assertObjectToDecimal(null, null);
        assertObjectToDecimal(new Set<Object>{}, new Set<Decimal>{});
        Decimal dec1 = 4.0;
        Decimal dec2 = 5.0;
        assertObjectToDecimal(new Set<Object>{dec1}, new Set<Decimal>{dec1});
        assertObjectToDecimal(new Set<Object>{dec1,dec2}, new Set<Decimal>{dec1,dec2});
    }

    private static testmethod void testObjectToDouble(){ 
        //test: global static Set<Double> objectToDouble(Set<Object> objectSet){ 
        assertObjectToDouble(null, null);
        assertObjectToDouble(new Set<Object>{}, new Set<Double>{});
        Double doub1 = 4.0;
        Double doub2 = 5.0;
        assertObjectToDouble(new Set<Object>{doub1}, new Set<Double>{doub1});
        assertObjectToDouble(new Set<Object>{doub1,doub2}, new Set<Double>{doub1,doub2});
    }

    private static testmethod void testObjectToID(){ 
        //test: global static Set<ID> objectToID(Set<Object> objectSet){ 
        assertObjectToID(null, null);
        assertObjectToID(new Set<Object>{}, new Set<ID>{});
        Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        assertObjectToID(new Set<Object>{acct1.id}, new Set<Id>{acct1.id});
        assertObjectToID(new Set<Object>{acct1.id,acct2.id}, new Set<Id>{acct1.id,acct2.id});
    } 

    private static testmethod void testObjectToInteger(){ 
        //test: global static Set<Integer> objectToInteger(Set<Object> objectSet){ 
        assertObjectToInteger(null, null);
        assertObjectToInteger(new Set<Object>{}, new Set<Integer>{});
        Integer int1 = 4;
        Integer int2 = 5;
        assertObjectToInteger(new Set<Object>{int1}, new Set<Integer>{int1});
        assertObjectToInteger(new Set<Object>{int1,int2}, new Set<Integer>{int1,int2});
    }

    private static testmethod void testObjectToLong(){ 
        //test: global static Set<Long> objectToLong(Set<Object> objectSet){ 
        assertObjectToLong(null, null);
        assertObjectToLong(new Set<Object>{}, new Set<Long>{});
        Long long1 = 4;
        Long long2 = 5;
        assertObjectToLong(new Set<Object>{long1}, new Set<Long>{long1});
        assertObjectToLong(new Set<Object>{long1,long2}, new Set<Long>{long1,long2});
    }

    private static testmethod void testObjectToTime(){ 
        //test: global static Set<Time> objectToTime(Set<Object> objectSet){ 
        assertObjectToTime(null, null);
        assertObjectToTime(new Set<Object>{}, new Set<Time>{});
        Time time1 = Time.newInstance(18, 30, 2, 20);
        Time time2 = Time.newInstance(18, 30, 2, 21);
        assertObjectToTime(new Set<Object>{time1}, new Set<Time>{time1});
        assertObjectToTime(new Set<Object>{time1,time2}, new Set<Time>{time1,time2});
    }

    private static testmethod void testObjectToString(){ 
        //test: global static Set<String> objectToString(Set<Object> objectSet){ 
        assertObjectToString(null, null);
        assertObjectToString(new Set<Object>{}, new Set<String>{});
        String str1 = 'xyz';
        String str2 = 'abc';
        assertObjectToString(new Set<Object>{str1}, new Set<String>{str1});
        assertObjectToString(new Set<Object>{str1,str2}, new Set<String>{str1,str2});
    }
    
    private static testmethod void testToStringBlobSet(){ 
        //test: global static String toString(Set<Blob> blobSet)
        assertToStringBlobSet(null, null);
        assertToStringBlobSet(new Set<Blob>{}, '');
        Blob blob1 = generateRandomBlob();
        Blob blob2 = generateRandomBlob();
        assertToStringBlobSet(new Set<Blob>{blob1}, '{\'' + blob1.toString() + '\'}');
        assertToStringBlobSet(new Set<Blob>{blob1,blob2}, '{\'' + blob1.toString() + '\',\'' + blob2.toString() + '\'}');
    }    

    private static testmethod void testToStringBooleanSet(){ 
        //test: global static String toString(Set<Boolean> booleanSet)
        assertToStringBooleanSet(null, null);
        assertToStringBooleanSet(new Set<Boolean>{}, '');
        assertToStringBooleanSet(new Set<Boolean>{true}, '{true}');
        assertToStringBooleanSet(new Set<Boolean>{true, false}, '{false,true}');
    }

    private static testmethod void testToStringDateSet(){ 
        //test: global static String toString(Set<Date> dateSet)
        assertToStringDateSet(null, null);
        assertToStringDateSet(new Set<Date>{}, '');
        Date date1 = Date.newInstance(2009,1,1);
        Date date2 = Date.newInstance(2009,1,2);
        assertToStringDateSet(new Set<Date>{date1}, '{'+date1+'}' );
        assertToStringDateSet(new Set<Date>{date1,date2}, '{'+date1+','+date2+'}' );
    }

    private static testmethod void testToStringDatetimeSet(){ 
        //test: global static String toString(Set<Datetime> datetimeSet)
        assertToStringDatetimeSet(null, null);
        assertToStringDatetimeSet(new Set<Datetime>{}, '');
        Datetime date1 = Datetime.newInstance(2009,1,1);
        Datetime date2 = Datetime.newInstance(2009,1,2);
        assertToStringDatetimeSet(new Set<Datetime>{date1}, '{'+date1+'}' );
        assertToStringDatetimeSet(new Set<Datetime>{date1,date2}, '{'+date1+','+date2+'}' );
    }

    private static testmethod void testToStringDecimalSet(){ 
        //test: global static String toString(Set<Decimal> decimalSet)
        assertToStringDecimalSet(null, null);
        assertToStringDecimalSet(new Set<Decimal>{}, '');
        Decimal dec1 = 4.0;
        Decimal dec2 = 5.0;
        assertToStringDecimalSet(new Set<Decimal>{dec1}, '{' + dec1 + '}');
        assertToStringDecimalSet(new Set<Decimal>{dec1,dec2}, '{' + dec1 + ',' + dec2 + '}');
    }

    private static testmethod void testToStringDoubleSet(){ 
        //test: global static String toString(Set<Double> doubleSet)
        assertToStringDoubleSet(null, null);
        assertToStringDoubleSet(new Set<Double>{}, '');
        Double doub1 = 4.0;
        Double doub2 = 5.0;
        assertToStringDoubleSet(new Set<Double>{doub1}, '{' + doub1 + '}');
        assertToStringDoubleSet(new Set<Double>{doub1,doub2}, '{' + doub1 + ',' + doub2 + '}');
    }

    private static testmethod void testToStringIDSet(){ 
        //test: global static String toString(Set<ID> idSet)
        assertToStringIDSet(null, null);
        assertToStringIDSet(new Set<ID>{}, '');
        Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        assertToStringIDSet(new Set<ID>{acct1.id}, '{' + acct1.id + '}');
        assertToStringIDSet(new Set<ID>{acct1.id,acct2.id}, '{' + acct1.id + ',' + acct2.id + '}');
    }

    private static testmethod void testToStringIntegerSet(){ 
        //test: global static String toString(Set<Integer> integerSet)
        assertToStringIntegerSet(null, null);
        assertToStringIntegerSet(new Set<Integer>{}, '');
        Integer int1 = 4;
        Integer int2 = 5;
        assertToStringIntegerSet(new Set<Integer>{int1}, '{' + int1 + '}' );
        assertToStringIntegerSet(new Set<Integer>{int1,int2}, '{' + int1 + ',' + int2 + '}' );
    }
    private static testmethod void testToStringLongSet(){ 
        //test: global static String toString(Set<Long> longSet)
        assertToStringLongSet(null, null);
        assertToStringLongSet(new Set<Long>{}, '');
        Long long1 = 4;
        Long long2 = 5;
        assertToStringLongSet(new Set<Long>{long1}, '{' + long1 + '}');
        assertToStringLongSet(new Set<Long>{long1,long2}, '{' + long1 + ',' + long2 + '}');
    }

    private static testmethod void testToStringTimeSet(){ 
        //test: global static String toString(Set<Time> timeSet)
        assertToStringTimeSet(null, null);
        assertToStringTimeSet(new Set<Time>{}, '');
        Time time1 = Time.newInstance(18, 30, 2, 20);
        Time time2 = Time.newInstance(18, 30, 2, 21);
        assertToStringTimeSet(new Set<Time>{time1}, '{' + time1 + '}' );
        assertToStringTimeSet(new Set<Time>{time1,time2}, '{' + time1 + ',' + time2 + '}' );
    }


    private static testmethod void testToStringStringSet(){ 
        //test: global static String toString(Set<String> stringSet)
        assertToStringStringSet(null, null);
        assertToStringStringSet(new Set<String>{}, '');
        String str1 = 'xyz';
        String str2 = 'abc';
        assertToStringStringSet(new Set<String>{str1}, '{' + str1 + '}');
        assertToStringStringSet(new Set<String>{str1,str2}, '{' + str1 + ',' + str2 + '}');
    }

    private static void assertObjectToBlob(Set<Object> objectSet, Set<Blob> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
    	Set<Blob> actual = SetUtils.objectToBlob(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     
    	'SetUtils.objectToBlob(null) returned ' + SetUtils.toString(actual) + '; expected null');
    	if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
    		'SetUtils.objectToBlob(' + SetUtils.toString(objectSet) + ') returned ' 
    		+ SetUtils.toString(actual) + '; expected ' + SetUtils.toString(expected));
	}}

    private static void assertObjectToBoolean(Set<Object> objectSet, Set<Boolean> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	   'Invalid test input: both parameters should be null.');
		Set<Boolean> actual = SetUtils.objectToBoolean(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),
            'SetUtils.objectToBoolean(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),
			'SetUtils.objectToBoolean(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			+ '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToDate(Set<Object> objectSet, Set<Date> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Date> actual = SetUtils.objectToDate(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToDate(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToDate(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			+ '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToDatetime(Set<Object> objectSet, Set<Datetime> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Datetime> actual = SetUtils.objectToDatetime(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToDatetime(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToDatetime(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			+ '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToDecimal(Set<Object> objectSet, Set<Decimal> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Decimal> actual = SetUtils.objectToDecimal(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToDecimal(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToDecimal(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			+ '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToDouble(Set<Object> objectSet, Set<Double> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Double> actual = SetUtils.objectToDouble(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToDouble(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToDouble(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			+ '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToID(Set<Object> objectSet, Set<ID> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<ID> actual = SetUtils.objectToID(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToID(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToID(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) + '; expected ' 
			+ SetUtils.toString(expected));
	}}
    private static void assertObjectToInteger(Set<Object> objectSet, Set<Integer> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Integer> actual = SetUtils.objectToInteger(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     'SetUtils.objectToInteger(null) returned ' 
		+ SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToInteger(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) + '; expected ' 
			+ SetUtils.toString(expected));
	}}
    private static void assertObjectToLong(Set<Object> objectSet, Set<Long> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Long> actual = SetUtils.objectToLong(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     
		'SetUtils.objectToLong(null) returned ' + SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),    
			 'SetUtils.objectToLong(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) 
			 + '; expected ' + SetUtils.toString(expected));
	}}
    private static void assertObjectToTime(Set<Object> objectSet, Set<Time> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<Time> actual = SetUtils.objectToTime(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     'SetUtils.objectToTime(null) returned ' 
		+ SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToTime(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) + '; expected ' 
			+ SetUtils.toString(expected));
	}}
    private static void assertObjectToString(Set<Object> objectSet, Set<String> expected){
    	System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    
    	'Invalid test input: both parameters should be null.');
		Set<String> actual = SetUtils.objectToString(objectSet);
		System.assert(!(objectSet == null && expected == null && actual != null),     'SetUtils.objectToString(null) returned ' 
		+ SetUtils.toString(actual) + '; expected null');
		if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     
			'SetUtils.objectToString(' + SetUtils.toString(objectSet) + ') returned ' + SetUtils.toString(actual) + '; expected ' 
			+ SetUtils.toString(expected));
	}}
    
    private static void assertToStringBlobSet(Set<Blob> blobSet, String expected){
    	System.assert(!((blobSet == null && expected != null) || (blobSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(blobSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){
			System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(blobSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }}
    private static void assertToStringBooleanSet(Set<Boolean> booleanSet, String expected){
    	System.assert(!((booleanSet == null && expected != null) || (booleanSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(booleanSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(booleanSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringDateSet(Set<Date> dateSet, String expected){
    	System.assert(!((dateSet == null && expected != null) || (dateSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(dateSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(dateSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringDatetimeSet(Set<Datetime> datetimeSet, String expected){
    	System.assert(!((datetimeSet == null && expected != null) || (datetimeSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(datetimeSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(datetimeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringDecimalSet(Set<Decimal> decimalSet, String expected){
    	System.assert(!((decimalSet == null && expected != null) || (decimalSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(decimalSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(decimalSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringDoubleSet(Set<Double> doubleSet, String expected){
    	System.assert(!((doubleSet == null && expected != null) || (doubleSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(doubleSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(doubleSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringIDSet(Set<ID> idSet, String expected){
    	System.assert(!((idSet == null && expected != null) || (idSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(idSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(idSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringIntegerSet(Set<Integer> integerSet, String expected){
    	System.assert(!((integerSet == null && expected != null) || (integerSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(integerSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),   
			 'SetUtils.toString(' + SetUtils.toString(integerSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringLongSet(Set<Long> longSet, String expected){
    	System.assert(!((longSet == null && expected != null) || (longSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(longSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(longSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringTimeSet(Set<Time> timeSet, String expected){
    	System.assert(!((timeSet == null && expected != null) || (timeSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(timeSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(timeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
	}}
    private static void assertToStringStringSet(Set<String> stringSet, String expected){
    	System.assert(!((stringSet == null && expected != null) || (stringSet != null && expected == null)),     
    	'Invalid test input: both parameters should be null.');
		String actual = SetUtils.toString(stringSet);
		Set<String> actualAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));
		Set<String> expectedAsStringSet = new Set<String>(StringUtils.split(StringUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));
		if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    
			'SetUtils.toString(' + SetUtils.toString(stringSet) + ') returned \'' + actual + '\';expected \'' + expected + '\'');
	}}
        

    private static Blob generateRandomBlob(){
        return EncodingUtil.base64Decode(''+System.currentTimeMillis()+Math.roundToLong(Math.random()*10000));    
    }

    private static testmethod void testAssertEquals(){
    	final Blob blob1 = generateRandomBlob();
        final Date date1 = Date.newInstance(2009,1,1);
        final Datetime datetime1 = Datetime.newInstance(2009,1,1);
        final Time time1 = Time.newInstance(18, 30, 2, 20);
        SetUtils.assertEquals(new Set<Blob>{blob1},new Set<Blob>{blob1});
        SetUtils.assertEquals(new Set<Boolean>{true},new Set<Boolean>{true});
        SetUtils.assertEquals(new Set<Date>{date1},new Set<Date>{date1});
        SetUtils.assertEquals(new Set<Datetime>{datetime1},new Set<Datetime>{datetime1});
        SetUtils.assertEquals(new Set<Decimal>{1.1},new Set<Decimal>{1.1});
        SetUtils.assertEquals(new Set<Double>{1.1},new Set<Double>{1.1});
        SetUtils.assertEquals(new Set<Integer>{1},new Set<Integer>{1});
        SetUtils.assertEquals(new Set<Long>{1L},new Set<Long>{1L});
        SetUtils.assertEquals(new Set<String>{'a'},new Set<String>{'a'});
        SetUtils.assertEquals(new Set<Time>{time1},new Set<Time>{time1});
    }

    private static testmethod void testEquals(){
    	final Set<Object> NULL_SET = null;
        System.assertEquals(true,SetUtils.equals(NULL_SET,NULL_SET));       
        System.assertEquals(false,SetUtils.equals(null,new Set<Integer>{1}));       
        System.assertEquals(false,SetUtils.equals(new Set<Integer>{1},null));       
        System.assertEquals(true,SetUtils.equals(new Set<Integer>(),new Set<Integer>()));       
        System.assertEquals(false,SetUtils.equals(new Set<Integer>{1},new Set<Integer>()));       
        System.assertEquals(false,SetUtils.equals(new Set<Integer>{1},new Set<Integer>{2}));       
        System.assertEquals(true,SetUtils.equals(new Set<Integer>{1},new Set<Integer>{1}));       

        System.assertEquals(false,SetUtils.equals(null,new Set<String>{'abc'}));       
        System.assertEquals(false,SetUtils.equals(new Set<String>{'abc'},null));       
        System.assertEquals(true,SetUtils.equals(new Set<String>(),new Set<String>()));       
        System.assertEquals(false,SetUtils.equals(new Set<String>{'abc'},new Set<String>()));       
        System.assertEquals(false,SetUtils.equals(new Set<String>{'abc'},new Set<String>{'def'}));       
        System.assertEquals(true,SetUtils.equals(new Set<String>{'abc'},new Set<String>{'abc'}));       

        final Blob blob1 = generateRandomBlob();
        final Date date1 = Date.newInstance(2009,1,1);
        final Datetime datetime1 = Datetime.newInstance(2009,1,1);
        final Time time1 = Time.newInstance(18, 30, 2, 20);
        System.assertEquals(true,SetUtils.equals(new Set<Blob>{blob1},new Set<Blob>{blob1}));
        System.assertEquals(true,SetUtils.equals(new Set<Boolean>{true},new Set<Boolean>{true}));
        System.assertEquals(true,SetUtils.equals(new Set<Date>{date1},new Set<Date>{date1}));
        System.assertEquals(true,SetUtils.equals(new Set<Datetime>{datetime1},new Set<Datetime>{datetime1}));
        System.assertEquals(true,SetUtils.equals(new Set<Decimal>{1.1},new Set<Decimal>{1.1}));
        System.assertEquals(true,SetUtils.equals(new Set<Double>{1.1},new Set<Double>{1.1}));
        System.assertEquals(true,SetUtils.equals(new Set<Integer>{1},new Set<Integer>{1}));
        System.assertEquals(true,SetUtils.equals(new Set<Long>{1L},new Set<Long>{1L}));
        System.assertEquals(true,SetUtils.equals(new Set<String>{'a'},new Set<String>{'a'}));
        System.assertEquals(true,SetUtils.equals(new Set<Time>{time1},new Set<Time>{time1}));

    }
}