global class NotCondition implements Condition{
    
    global Condition condition {get;private set;}
    
    private String NotCondition {get;set;} 
    
    global NotCondition(){
        this(null);
    }
    
    global NotCondition(Condition c){
        add(c);
    }
    
    global Condition add(Condition c){
    	this.condition = c;
        return this;
    }
    
    global String toSoql(){
        String soql = '';
        if(condition != null){
        	soql += 'NOT(' + condition.toSoql() + ')';
        }
        return soql;
    }
    
}