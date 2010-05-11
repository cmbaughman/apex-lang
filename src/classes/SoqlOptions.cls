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