global class SetCondition implements Condition{
    
    private String name;
    private String operator;
    private List<String> values;

    global SetCondition(){
        this(null);
    }
    
    global SetCondition(String name){
        this.name(name);
    }
    
    global SetCondition name(String name){
    	this.name = name;
    	return this;
    }
    
    global SetCondition includes(List<Object> values){
    	return setOperation('includes',values);
    }

    global SetCondition excludes(List<Object> values){
        return setOperation('excludes',values);
    }
    
    global SetCondition inn(List<Object> values){
        return setOperation('in',values);
    }

    global SetCondition notIn(List<Object> values){
        return setOperation('not in',values);
    }
    
    private SetCondition setOperation(String operator, List<Object> values){
        this.operator = operator;
        if(values == null || values.size() <= 0){
        	throw new IllegalArgumentException('No values found!');
        }
        this.values = SoqlUtils.primitivesToSoqlLiterals(values);
        return this;
    }
    
    global String toSoql(){
        if(StringUtils.isBlank(operator)){
        	throw new IllegalStateException('Illegal state!  One of the following operations must be invoked on SetCondition prior to invoke toSoql(): (includes|excludes|inn|notIn)');
        }
        return name + ' ' + operator + ' (' + StringUtils.joinArray(values,',') + ')'; 
    }

    global Condition add(Condition c){
        throw new IllegalStateException('conditions cannot be added to SetCondition type!');
    }
    
}