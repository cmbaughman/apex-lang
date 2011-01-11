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
global class Field implements Soqlable{

    private String name;
    private Boolean toLabelx;
    
    global Field(String name){
        this.name = name;
        this.toLabelx = false;
    }

    global Field toLabelx(){
        this.toLabelx = true;
        return this;
    }

    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
    	return (toLabelx ? 'toLabel(' : '') + name + (toLabelx ? ')' : '');
    }
    
}