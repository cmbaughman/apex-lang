global class FieldCondition implements Condition{
    
    global static final Operator DEFAULT_OPERATOR = Operator.EQUALS;
    
    global String   name        {get;private set;}
    global Operator operator    {get;private set;}
    global String   value       {get;private set;}
    
    global FieldCondition(String name, Object value){
        this(name, DEFAULT_OPERATOR, value);
    }
    
    global FieldCondition(String name, Operator operator, Object value){
    	if(StringUtils.isBlank(name)){
    		throw new IllegalArgumentException('invalid field name: ' + name);
    	}
        if(operator == null){
            throw new IllegalArgumentException('operator is null');
        }
        this.name = StringUtils.trim(name);
        this.operator = operator;
        this.value = SoqlUtils.primitiveToSoqlLiteral(value);
    }
    
    global String toSoql(){
    	return name + ' ' + operatorToString(operator) + ' ' + value;
    }
    
    global static String operatorToString(Operator op){
    	String returnValue = null;
        if(op == Operator.EQUALS){ returnValue = '='; }       
        else if(op == Operator.NOT_EQUALS){ returnValue = '!='; }       
        else if(op == Operator.LESS){ returnValue = '<'; }       
        else if(op == Operator.LESS_OR_EQUAL){ returnValue = '<='; }       
        else if(op == Operator.GREATER){ returnValue = '>'; }       
        else if(op == Operator.GREATER_OR_EQUAL){ returnValue = '>='; }       
        else if(op == Operator.LIK){ returnValue = 'like'; }
        return returnValue;
    }
    
    global Condition add(Condition c){
    	throw new IllegalStateException('conditions cannot be added to FieldCondition type!');
    }
    
}