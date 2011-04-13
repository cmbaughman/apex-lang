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
global class SoqlOptions {

    global static SoqlOptions DEFAULT_OPTIONS = new SoqlOptions();
     
    global Boolean escapeSingleQuotes {get;set;}
    global Boolean wildcardStringsInLikeOperators {get;set;}
	
    global SoqlOptions(){
    	escapeSingleQuotes();
    	doNotWildcardStringsInLikeOperators();
    }
    
    global SoqlOptions wildcardStringsInLikeOperators(){
        this.wildcardStringsInLikeOperators = true;
        return this;
    }
    
    global SoqlOptions doNotWildcardStringsInLikeOperators(){
        this.wildcardStringsInLikeOperators = false;
        return this;
    }
    
    global SoqlOptions escapeSingleQuotes(){
        this.escapeSingleQuotes = true;
        return this;
    }
    
    global SoqlOptions doNotEscapeSingleQuotes(){
        this.escapeSingleQuotes = false;
        return this;
    }
    

}