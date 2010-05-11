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