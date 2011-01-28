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
 
public with sharing class CSVParser {
	
	/**
	Another parse CSV version please refer:
	
	http://wiki.developerforce.com/index.php/Code_Samples#Parse_a_CSV_with_APEX
	*/
	
	public static String ESCAPE_MODE_DOUBLED = 'doubled';
	public static String ESCAPE_MODE_BACKSLASH = 'backslash';
	
	public String textQualifier {get; set;}
	public String delimiter {get; set;}
	public String escapeMode {get; set;}
	
	public CSVParser(){
		textQualifier = '"';
		delimiter = ',';
		escapeMode = ESCAPE_MODE_DOUBLED;
	}
	
	public List<List<String>> parse(String contents) {
		
		List<List<String>> allFields = new List<List<String>>();
		
		List<String> lines = contents.split('[\n\r]+');
		
		for(String line : lines){
			line = line.trim();
			
			Integer length = line.length();
			
			Integer i;
			Boolean isQulifing = false;
			Boolean isEscaping = false;
			String currentField = '';
			Boolean isBeginningOfField = false;
			
			List<String> lineFields = new List<String>();
			
			for(i=0; i<length; i++){
				String achar = line.substring(i,i+1);
				
				if(achar.equals(delimiter)){
					// the delimiter
					if(isQulifing){
						currentField = currentField + delimiter;
						isBeginningOfField = false;
					}else{
						lineFields.add(currentField);
						currentField = '';
						isQulifing = false;
						isEscaping = false;
						isBeginningOfField = true;
					}
					
				}else if(escapeMode.equals(ESCAPE_MODE_BACKSLASH) && achar.equals('\\')){
					// the escape char
					if(isEscaping){
						isEscaping = false;
						currentField = currentField + '\\';
					}else{
						isEscaping = true;
					}
					
				}else if(achar.equals(textQualifier)){
					// the qualifier
					if(isEscaping){
						isEscaping = false;
						currentField = currentField + textQualifier;
					}else{
						String nextchar = 'NEVEREQUAL';
						if(i < length-1){
							nextchar = line.substring(i+1,i+2);
						}
						if(escapeMode.equals(ESCAPE_MODE_DOUBLED) && nextchar.equals(textQualifier) && (! isBeginningOfField)){
							isEscaping = true;
							
						}else{
							if(isQulifing){
								isQulifing = false;
							}else{
								isQulifing = true;
							}
							
						}
					}
					
				}else{
					// general char
					currentField = currentField + achar;
					
				}
				
				if(! achar.equals(delimiter)){
					isBeginningOfField = false;
				}
				
			}
			
			if(currentField.length() > 0){
				// the last field
				lineFields.add(currentField);
			}
			
			if(! lineFields.isEmpty()){
				allFields.add(lineFields);
			}
			
		}
		
		return allFields;
	}
	
	static testMethod void myTest(){
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
}