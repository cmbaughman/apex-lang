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
private class NumberUtilsTest {
    
    private static testmethod void testMaxIntegerValue(){
        System.assert(NumberUtils.MAX_INTEGER == 2147483647);
    }
    private static testmethod void testMinIntegerValue(){
        System.assert(NumberUtils.MIN_INTEGER == -2147483647);
    }
    
    private static testmethod void testParseIntBadRadix(){
        //test: global static Integer parseInt(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            NumberUtils.parseInt('01',1);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'NumberUtils.parseInt(\'01\',1) did not throw IllegalArgumentException'); 
        exceptionCaught = false;
        try{
            NumberUtils.parseInt('01',37);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'NumberUtils.parseInt(\'01\',37) did not throw IllegalArgumentException'); 
    }
    
    private static testmethod void testParseIntEmptyNumber(){
        //test: global static Integer parseInt(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            NumberUtils.parseInt(null,2);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'NumberUtils.parseInt(null,2) did not throw NumberFormatException'); 
        exceptionCaught = false;
        try{
            NumberUtils.parseInt('  ',2);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'NumberUtils.parseInt(\'  \',2) did not throw NumberFormatException'); 
    }
    
    private static testmethod void testParseIntInvalidNumber(){
        //test: global static Integer parseInt(String str, Integer radix){
        for(Integer i = 2; i < 37; i++){
            assertParseIntNumberFormatException(
                '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ$'.substring(0,i+1)
                ,i);
        }        
    }

    private static void assertParseIntNumberFormatException(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            NumberUtils.parseInt(str,radix);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'NumberUtils.parseInt(\'' + str + '\',' + radix + ') did not throw NumberFormatException'); 
    }
    
    private static testmethod void testParseIntBase2(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('0',2,0);
        assertParseInt('00',2,0);
        assertParseInt('1',2,1);
        assertParseInt('10',2,2);
        assertParseInt('11',2,3);
        assertParseInt('100',2,4);
    }
    
    private static testmethod void testParseIntBase10(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('0',10,0);
        assertParseInt('-0',10,0);
        assertParseInt('473',10,473);
    }
    
    private static testmethod void testParseIntOtherBases(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('1100110',2,102);
        assertParseInt('-FF',16,-255);
        assertParseInt('12',8,10);
        assertParseInt('az',36,395);
     }
    
    private static void assertParseInt(String str, Integer radix, Integer expected){
        Integer actual = NumberUtils.parseInt(str,radix);
        System.assert(actual==expected, 'NumberUtils.parseInt(\'' + str + '\',' + radix + ') returned ' 
            + actual + '; expected ' + expected + '');
    }
    
    /*
    
    private static testmethod void testToBinary(){
        //test: global static String toBinary(Long number){
        assertFromBinary(0,'0');
        assertFromBinary(1,'1');
        assertFromBinary(2,'10');
        assertFromBinary(3,'11');
        assertFromBinary(4,'100');
    }
    
    private static void assertToBinary(Long number, String expected){
        String actual = NumberUtils.toBinary(number);
        System.assert(actual==expected, 'NumberUtils.toBinary(' + number + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    */

    

}