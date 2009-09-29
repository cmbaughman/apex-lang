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
private class SystemUtilsTest {
    private static testmethod void testLimitDebug(){
        SystemUtils.debugLimits();
    }
    
    private static testmethod void testTo18(){
        //test: global static String to18(String the15charID){
        assertTo18('a0BA0000000L2Z','a0BA0000000L2Z');
        assertTo18('a0BA0000000L2ZC','a0BA0000000L2ZCMA0');
    }
    
    private static void assertTo18(String the15charID, String expected){
        String actual = SystemUtils.to18(the15charID);
        System.assert(actual==expected, 'SystemUtils.to18(\'' + the15charID + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
}