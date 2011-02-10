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
private class CSVParserTest {

    private static testmethod void myTest(){
        CSVParser parser = new CSVParser();
        String content;
        List<List<String>> result;
        
        parser.escapeMode = CSVParser.ESCAPE_MODE_DOUBLED;
        content = 'a,b\n'
            +'"a","b"\n'
            +'a,"b,c"\r'
            +'"a","b,c"\n'
            +'a,"b,""c"\r\n'
            +'a,"""b",c\n\n\n'
            +'a,"""""""""b",c\r'
            +'a,"b""""""""",c';
        result = parser.parse(content);
        
        System.assertEquals(result[0][0], 'a');
        System.assertEquals(result[0][1], 'b');
        System.assertEquals(result[1][0], 'a');
        System.assertEquals(result[1][1], 'b');
        System.assertEquals(result[2][0], 'a');
        System.assertEquals(result[2][1], 'b,c');
        System.assertEquals(result[3][0], 'a');
        System.assertEquals(result[3][1], 'b,c');
        System.assertEquals(result[4][0], 'a');
        System.assertEquals(result[4][1], 'b,"c');
        System.assertEquals(result[5][0], 'a');
        System.assertEquals(result[5][1], '"b');
        System.assertEquals(result[5][2], 'c');
        System.assertEquals(result[6][0], 'a');
        System.assertEquals(result[6][1], '""""b');
        System.assertEquals(result[6][2], 'c');
        System.assertEquals(result[7][0], 'a');
        System.assertEquals(result[7][1], 'b""""');
        System.assertEquals(result[7][2], 'c');
        
        parser.escapeMode = CSVParser.ESCAPE_MODE_BACKSLASH;
        content = 'a,"b,\\"c"\n'
            +'a,"\\"\\"\\"\\"b",c\n\r'
            +'a,"b\\"\\"\\"\\"",c';
        result = parser.parse(content);
        
        System.assertEquals(result[0][0], 'a');
        System.assertEquals(result[0][1], 'b,"c');
        System.assertEquals(result[1][0], 'a');
        System.assertEquals(result[1][1], '""""b');
        System.assertEquals(result[1][2], 'c');
        System.assertEquals(result[2][0], 'a');
        System.assertEquals(result[2][1], 'b""""');
        System.assertEquals(result[2][2], 'c');
    }

    private static testmethod void test2(){
    	final List<List<String>> expected = new List<List<String>>{
             new List<String>{'abc','123','efg'}
            ,new List<String>{'aasdfasdfasdfasdf','asdfasdfasdf asdf asdf asd f asdf','asdfasdfasdfasdf'}
            ,new List<String>{'1','2','3'}
            ,new List<String>{'4','','6'}
    	};
    	final List<String> expectedRows = new List<String>();
    	for(List<String> row : expected){
    		expectedRows.add(StringUtils.joinStrings(row,','));
    	} 
    	
    	final String data = 
                    'abc,123,efg'
           + '\n' + 'aasdfasdfasdfasdf,asdfasdfasdf asdf asdf asd f asdf,asdfasdfasdfasdf'
           + '\n' + '1,2,3'
           + '\n' + '4,,6'
    	;
    	final List<List<String>> actual = new CSVParser().parse(StringUtils.joinStrings(expectedRows,'\n'));
        System.assertNotEquals(null,actual);
        System.assertEquals(4,actual.size());
        for(Integer i = 0; i < 4; i++){
	        ArrayUtils.assertArraysAreEqual(expected.get(i), actual.get(i));
        }
    }

}