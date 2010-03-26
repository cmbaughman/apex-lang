global class SoqlBuilder {
	
    private Set<String> columns = null;
    private String table = null;
    private Condition condition = null;
    private String orderBy = null;
    private Integer max = null;
    
    global SoqlBuilder(){}
    
    global SoqlBuilder columns(List<String> columns){
        return this.columns(SetUtils.listToSet(columns)); 
    }
    
    global SoqlBuilder columns(Set<String> columns){
        this.columns = columns; 
        return this;
    }
    
    global SoqlBuilder table(String table){
        this.table = table; 
        return this;
    }
    
    global SoqlBuilder condition(Condition condition){
        this.condition = condition; 
        return this;
    }
    
    global SoqlBuilder order(String orderBy){
        this.orderBy = orderBy; 
        return this;
    }
    
    global SoqlBuilder max(Integer max){
        this.max = max; 
        return this;
    }
    
    global String toSoql(){
    	if(StringUtils.isBlank(table)){
    		throw new IllegalStateException('Illegal state!  You must invoke table() with valid object name before invoking toSoql().');
    	}
    	String soql = 'SELECT ' + StringUtils.joinStrings(columns,',') + ' FROM ' + table;
        if(condition != null){
            soql += ' WHERE ' + condition.toSoql();
        }
        if(StringUtils.isNotBlank(orderBy)){
            soql += ' ORDER BY ' + orderBy;
        }
        if(max != null){
            soql += ' LIMIT ' + max;
        }
        System.debug('### soql: ' + soql);
    	return soql;
    }
    
}