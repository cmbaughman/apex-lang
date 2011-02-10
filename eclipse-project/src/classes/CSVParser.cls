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
 
global with sharing class CSVParser {
    
    /**
    Another parse CSV version please refer:
    
    http://wiki.developerforce.com/index.php/Code_Samples#Parse_a_CSV_with_APEX
    */
    
    global static String ESCAPE_MODE_DOUBLED = 'doubled';
    global static String ESCAPE_MODE_BACKSLASH = 'backslash';
    
    global String textQualifier {get; set;}
    global String delimiter {get; set;}
    global String escapeMode {get; set;}
    
    global CSVParser(){
    	this('"',',',ESCAPE_MODE_DOUBLED);
    }
    
    global CSVParser(
	     final String textQualifier
	    ,final String delimiter
	    ,final String escapeMode
    ){
        this.textQualifier  = textQualifier;
        this.delimiter      = delimiter;
        this.escapeMode     = escapeMode;
    }
    
    global List<List<String>> parse(String contents) {
        final List<List<String>> returnValue = new List<List<String>>();
        final List<String> lines = ArrayUtils.trim(
            contents == null 
                ? new List<String>() 
                : contents.split('[\n\r]+')
        );
        if(lines != null && lines.size() > 0){
        	Integer length = null;
	        for(String line : lines){
	            
	            Integer i;
	            Boolean isQulifing = false;
	            Boolean isEscaping = false;
	            String currentField = '';
	            Boolean isBeginningOfField = false;
	            
	            List<String> lineFields = new List<String>();
	            
                length = line.length();
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
	            
	            // the last field
	            lineFields.add(currentField);
	            if(! lineFields.isEmpty()){
	                returnValue.add(lineFields);
	            }
	        }
        }
        return returnValue;
    }
    
}