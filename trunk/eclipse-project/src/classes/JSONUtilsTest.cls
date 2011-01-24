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
private class JSONUtilsTest {

    private static testmethod void testEncode_String(){
        //test: global static String encode(String str)
        final String nullStr = null;
        System.assertEquals('null',JSONUtils.encode(nullStr)); 
        System.assertEquals('""',JSONUtils.encode('')); 
        System.assertEquals('" "',JSONUtils.encode(' ')); 
        System.assertEquals('"\\""',JSONUtils.encode('"'));
        //System.assertEquals('\"\\\\\"',JSONUtils.encode('\\'));
        System.assertEquals('"\\f"',JSONUtils.encode('\f'));
        System.assertEquals('"\\n"',JSONUtils.encode('\n'));
        System.assertEquals('"\\r"',JSONUtils.encode('\r'));
        System.assertEquals('"\\t"',JSONUtils.encode('\t'));        
    }
    
    private static testmethod void testEncode_StringList(){
        //test: global static List<String> encode(List<String> strings)
        final String[] nullStr = null;
        ArrayUtils.assertArraysAreEqual(null,JSONUtils.encode(nullStr)); 
        ArrayUtils.assertArraysAreEqual(new String[]{},JSONUtils.encode(new String[]{})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'\"\"'},JSONUtils.encode(new String[]{''})); 
        ArrayUtils.assertArraysAreEqual(new String[]{'\"abc\"','\"xyz\"'},JSONUtils.encode(new String[]{'abc','xyz'})); 
    }

    private static testmethod void test_encodeFields(){
        //test: global static void encodeFields(List<SObject> sobjects, Map<String,String> mapping)
        final Account acct1 = new Account(name = 'xyz123', BillingCity = 'asdf\nasdf');
        final Account acct2 = new Account(name = null, BillingCity = '4444\t4444');
        final List<Account> accounts = new List<Account>{acct1,acct2};
        JSONUtils.encodeFields(accounts, new Map<String,String>{
             'name' => 'description'
            ,'BillingCity' => 'BillingCountry'
        }); 
        System.assertEquals('"xyz123"',acct1.description);
        System.assertEquals('null',acct2.description);
        System.assertEquals('"asdf\\nasdf"',acct1.BillingCountry);
        System.assertEquals('"4444\\t4444"',acct2.BillingCountry);
    }

}