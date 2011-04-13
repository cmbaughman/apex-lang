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
global class SetCondition implements Condition{
    
    private static final Operator INCLUDES  = Operator.INCLUDES;
    private static final Operator EXCLUDES  = Operator.EXCLUDES;
    private static final Operator INX       = Operator.INX;
    private static final Operator NOT_IN    = Operator.NOT_IN;

    global String       field    {get; private set;}
    global Operator     operator {get; private set;}
    global List<Object> values   {get; private set;}
    global SoqlBuilder  builder  {get; private set;}
    
    global SetCondition(){}
    
    global SetCondition(String field){
        this.field(field);
    }
    
    global SetCondition(String field, Operator operator, List<Object> values){
        this.field(field);
        this.setOperation(operator,values);
    }
    
    global SetCondition(String field, Operator operator, SoqlBuilder builder){
        this.field(field);
        this.setOperation(operator,builder);
    }
    
    global SetCondition field(String field){
        if(StringUtils.isBlank(field)){
            throw new IllegalArgumentException('illegal argument:  field is empty');
        }
        this.field = StringUtils.trim(field);
    	return this;
    }
    
    global SetCondition includes(List<Object> values){ return setOperation(INCLUDES,values); }
    global SetCondition excludes(List<Object> values){ return setOperation(EXCLUDES,values); }
    global SetCondition inx     (List<Object> values){ return setOperation(INX,     values); }
    global SetCondition notIn   (List<Object> values){ return setOperation(NOT_IN,  values); }

    global SetCondition includes(SoqlBuilder builder){ return setOperation(INCLUDES,builder); }
    global SetCondition excludes(SoqlBuilder builder){ return setOperation(EXCLUDES,builder); }
    global SetCondition inx     (SoqlBuilder builder){ return setOperation(INX,     builder); }
    global SetCondition notIn   (SoqlBuilder builder){ return setOperation(NOT_IN,  builder); }

    private SetCondition setOperation(Operator operator, List<Object> values){
        if(values == null || values.size() <= 0){
            throw new IllegalArgumentException('illegal argument:  values is empty');
        }
        this.values = values;
        return setOperator(operator);
    }

    private SetCondition setOperation(Operator operator, SoqlBuilder builder){
        if(builder == null){
            throw new IllegalArgumentException('illegal argument:  builder is null');
        }
        this.builder = builder;
        return setOperator(operator);
    }
    
    private SetCondition setOperator(Operator operator){
        if(operatorToString(operator) == null){
            throw new IllegalArgumentException('illegal operator: ' + operator);
        }
        this.operator = operator;
        return this;
    }

    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
        if(this.operator== null){
        	throw new IllegalStateException(
        	   'Illegal state!  One of the following operations must be invoked on SetCondition prior to invoke toSoql(): (includes|excludes|inn|notIn)');
        }
        String insideParams = null;
        if(builder == null) insideParams = StringUtils.joinArray(SoqlUtils.toLiteral(this.values),',');
        else                insideParams = builder.toSoql(options);
        return field + ' ' + operatorToString(operator) + ' (' + insideParams + ')'; 
    }

    global static String operatorToString(Operator operator){
        String returnValue = null;
        if(operator == INCLUDES){ returnValue = 'INCLUDES'; }       
        else if(operator == EXCLUDES){ returnValue = 'EXCLUDES'; }       
        else if(operator == INX){ returnValue = 'IN'; }       
        else if(operator == NOT_IN){ returnValue = 'NOT IN'; }       
        return returnValue;
    }

}