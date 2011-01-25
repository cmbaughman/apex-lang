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
global class NotCondition implements NestableCondition{
    
    global Condition condition {get;private set;}
    
    private String NotCondition {get;set;} 
    
    global NotCondition(){
        this(null);
    }
    
    global NotCondition(Condition c){
        add(c);
    }
    
    global NestableCondition add(Condition c){
    	this.condition = c;
        return this;
    }
    
    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
        String soql = '';
        if(condition != null){
        	soql += 'NOT(' + condition.toSoql(options) + ')';
        }
        return soql;
    }
    
}