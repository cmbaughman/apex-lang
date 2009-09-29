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
private class RandomStringUtilsTest {
    


    private static testmethod void testRandom(){
        //test: global static String random(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandom(i);
        }
    }    
    
    private static void assertRandom(Integer count){
        String actual = RandomStringUtils.random(count);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.random(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.random(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.isAsciiPrintable(actual), 'RandomStringUtils.random(' + count 
                + ') returned \'' + actual + '\' (unexpected non-ascii characters present)');
        }
    }

    private static testmethod void testRandomAscii(){
        //test: global static String randomAscii(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAscii(i);
        }
    }
    
    private static void assertRandomAscii(Integer count){
        String actual = RandomStringUtils.randomAscii(count);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.isAsciiPrintable(actual), 'RandomStringUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\' (unexpected non-ascii characters present)');
        }
    }

    private static testmethod void testRandomAlphabetic(){
        //test: global static String randomAlphabetic(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAlphabetic(i);
        }
    }
    
    private static void assertRandomAlphabetic(Integer count){
        String actual = RandomStringUtils.randomAlphabetic(count);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.isAlpha(actual), 'RandomStringUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\' (unexpected non-alphabetic characters present)');
        }
    }

    private static testmethod void testRandomAlphanumeric(){
        //test: global static String randomAlphanumeric(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAlphanumeric(i);
        }
    }
    
    private static void assertRandomAlphanumeric(Integer count){
        String actual = RandomStringUtils.randomAlphanumeric(count);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.isAlphanumeric(actual), 'RandomStringUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
        }
    }

    private static testmethod void testRandomNumeric(){
        //test: global static String randomNumeric(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomNumeric(i);
        }
    }
    
    private static void assertRandomNumeric(Integer count){
        String actual = RandomStringUtils.randomNumeric(count);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.isNumeric(actual), 'RandomStringUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
        }
    }

    private static testmethod void testRandomTwoArgs(){
        //test: global static String random(Integer count, String chars) {
        for(Integer i = -5; i < 5; i++){
            assertRandomTwoArgs(i,'abc');
        }
        for(Integer i = -5; i < 5; i++){
            assertRandomTwoArgs(i,'4938%(#*@x)');
        }
    }
    
    private static void assertRandomTwoArgs(Integer count, String chars){
        String actual = RandomStringUtils.random(count,chars);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\' (unexpected length)');
            System.assert(StringUtils.containsOnly(actual,chars), 'RandomStringUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\' (unexpected characters present)');
        }
    }

    private static testmethod void testRandomThreeArgs(){
        //test: global static String random(Integer count, boolean letters, boolean numbers) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomThreeArgs(i,Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
            }
        }
    }
    
    private static void assertRandomThreeArgs(Integer count, boolean letters, boolean numbers){
        String actual = RandomStringUtils.random(count,letters,numbers);
        if(count < 0){
            System.assert('' == actual, 'RandomStringUtils.random(' + count 
                + ','+ letters + ',' + numbers + ') returned \'' + actual + '\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.random(' + count 
                + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected length)');
            if(!letters && !numbers){
                System.assert(StringUtils.isAsciiPrintable(actual), 'RandomStringUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
            } else if(!letters && numbers){
                System.assert(StringUtils.isNumeric(actual), 'RandomStringUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
            } else if(letters && !numbers){
                System.assert(StringUtils.isAlpha(actual), 'RandomStringUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alpha characters present)');
            } else if(letters && numbers){
                System.assert(StringUtils.isAlphanumeric(actual), 'RandomStringUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
            }
        }
    }

    private static testmethod void testRandomFiveArgs(){
        //test: global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomFiveArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
            }
        }
    }
    
    private static void assertRandomFiveArgs(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers){
        String actual = RandomStringUtils.random(count,startIndex,endIndex,letters,numbers);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.random(RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\'');            
        } else {
            System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected length)');
            if(!letters && !numbers){
                System.assert(StringUtils.isAsciiPrintable(actual), 'RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
            } else if(!letters && numbers){
                System.assert(StringUtils.isNumeric(actual), 'RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
            } else if(letters && !numbers){
                System.assert(StringUtils.isAlpha(actual), 'RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alpha characters present)');
            } else if(letters && numbers){
                System.assert(StringUtils.isAlphanumeric(actual), 'RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
            }
        }
    }

    private static testmethod void testRandomSixArgs(){
        //test: global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomSixArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
            }
        }
    }
    
    private static void assertRandomSixArgs(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars){
        String actual = RandomStringUtils.random(count,startIndex,endIndex,letters,numbers,chars);
        if(count < 0){
            System.assert('' == actual,  'RandomStringUtils.random(RandomStringUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\'');            
        } else {
            if(chars == null){
                System.assert(StringUtils.length(actual) == count, 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected length)');
                if(!letters && !numbers){
                    System.assert(StringUtils.isAsciiPrintable(actual), 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
                } else if(!letters && numbers){
                    System.assert(StringUtils.isNumeric(actual), 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-numeric characters present)');
                } else if(letters && !numbers){
                    System.assert(StringUtils.isAlpha(actual), 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-alpha characters present)');
                } else if(letters && numbers){
                    System.assert(StringUtils.isAlphanumeric(actual), 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
                }
            } else {
                System.assert(StringUtils.containsOnly(actual,chars), 'RandomStringUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected characters present)');
            }
        }
    }


    private static testmethod void testRandomUUID(){
        String actual = RandomStringUtils.randomUUID();
        System.assertNotEquals(null,actual);
        System.assertEquals(36,actual.length());
        System.assert(StringUtils.containsOnly(actual,'01234567890abcdef-'), 
            'The following UUID contains invalid characters: ' + actual);
    }

}