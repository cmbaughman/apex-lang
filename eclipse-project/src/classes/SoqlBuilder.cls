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
global class SoqlBuilder implements Soqlable{
	
    private Set<Object>     selectx     = null;
    private Boolean         selectAll   = false;
    private Boolean         selectCount = false;
    private Boolean         selectAvg   = false;
    private Boolean         selectSum   = false;
    private Boolean         selectMin   = false;
    private Boolean         selectMax   = false;
	private String 			aggx		= null;  
    private String          fromx       = null;
    private Condition       wherex      = null;
    private List<OrderBy>   orderByx    = null;
    private String          groupByx    = null;
    private Integer         limitx      = null;
        
    global SoqlBuilder(){}
    
    global SoqlBuilder selectAll(){
    	selectAll = true;
        return this;
    }
    
    global SoqlBuilder selectx(String field){ 
        return addToSelect(field);
    }
    
    global SoqlBuilder selectx(Field field){ 
        return addToSelect(field);
    }
    
    global SoqlBuilder selectx(SoqlBuilder field){ 
        return addToSelect(field);
    }
    
    global SoqlBuilder selectx(List<Object> fields){ 
        return selectx(SetUtils.listToSet(fields));
    }
    
    global SoqlBuilder selectx(Set<Object> fields){ 
        if(fields != null && fields.size() > 0){
            for(Object field : fields){
                addToSelect(field);
            }
        }
        return this;
    }

    global SoqlBuilder selectx(List<String> fields){ 
        return selectx(SetUtils.listToSet(fields));
    }
    
    global SoqlBuilder selectx(Set<String> fields){ 
        if(fields != null && fields.size() > 0){
            for(String field : fields){
                addToSelect(field);
            }
        }
        return this;
    }

    private SoqlBuilder addToSelect(Object field){
        if(field == null){
            throw new IllegalArgumentException('null field');
        }
        if(field instanceof String || field instanceof Field || field instanceof SoqlBuilder ){
	        if(selectx == null){
	            selectx = new Set<Object>();
	        }
	        selectx.add(field);
        } else {
            throw new IllegalArgumentException('Invalid field type.  A field must be either a String, Field, or SoqlBuilder.');
        }
        this.selectCount = false;
        return this;
    }

    global SoqlBuilder selectCount(){ 
        return selectCountx();
    }

    global SoqlBuilder selectCountx(){ 
        this.selectCount = true;
        return this;
    }

    global SoqlBuilder selectCount(String aggx){ 
		this.aggx = aggx;
        return selectCountx();
    }

    global SoqlBuilder selectAveragex(String aggx){ 
        this.selectAvg = true;
		this.aggx = aggx;
        return this;
    }

    global SoqlBuilder selectSumx(String aggx){ 
        this.selectSum = true;
		this.aggx = aggx;
        return this;
    }

    global SoqlBuilder selectMinx(String aggx){ 
        this.selectMin = true;
		this.aggx = aggx;
        return this;
    }

    global SoqlBuilder selectMaxx(String aggx){ 
        this.selectMax = true;
		this.aggx = aggx;
        return this;
    }

    global SoqlBuilder fromx(String fromx){
        this.fromx = fromx; 
        return this;
    }

    global SoqlBuilder wherex(Condition wherex){ 
        this.wherex = wherex;
    	return this;
    }
    
    global SoqlBuilder orderByx(OrderBy orderByx){ 
    	if(this.orderByx == null){
    		this.orderByx = new List<OrderBy>();
    	}
    	this.orderByx.add(orderByx);
        return this;
    }

    global SoqlBuilder orderByx(List<OrderBy> orderByx){ 
        if(orderByx != null && orderByx.size() > 0){
            for(OrderBy field : orderByx){
                orderByx(field);
            }
        }
        return this;
    }
    
   global SoqlBuilder groupByx(String groupByx){
        this.groupByx = groupByx; 
        return this;
    }

    global SoqlBuilder limitx(Integer limitx){
        this.limitx = limitx; 
        return this;
    }    
    
    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
        if(StringUtils.isBlank(fromx)){
            throw new IllegalStateException('Illegal state!  You must invoke fromx() with valid object name before invoking toSoql().');
        }
        Boolean isFirst = true;
        String soql = 'SELECT ';
        if(selectx == null){
            selectx = new Set<Object>();
        }
        if(this.selectCount != null && this.selectCount && aggx == null){
        	soql += 'COUNT()';
        } else if (this.selectCount != null && this.selectCount) {  
        		soql += 'COUNT(' + aggx + ')';
        } else if (this.selectAvg != null && this.selectAvg){
 				soql += 'AVG(' + aggx + ')';
	    } else if (this.selectSum != null && this.selectSum){
 				soql += 'SUM(' + aggx + ')';
        } else if (this.selectMin != null && this.selectMin) {
 				soql += 'MIN(' + aggx + ')';
        } else if (this.selectMax != null && this.selectMax) {
 				soql += 'MAX(' + aggx + ')';
        } else {
        	if(this.selectAll){
                selectx.addAll(getAllFieldNames(fromx));
        	}
        	if(selectx.size() <= 0){
	            selectx.add('id');
	        }
	        String distinctField = null;
	        Map<String,String> distinctFields = new Map<String,String>();
            for(Object value : selectx){
                if(value instanceof Field){
                    distinctField = ((Field)value).toSoql(options);
                } else if(value instanceof SoqlBuilder){
                    distinctField = '(' + ((SoqlBuilder)value).toSoql(options) + ')';
                } else {
                    distinctField = ''+value;
                }
                distinctField = StringUtils.trim(distinctField);
                distinctFields.put(StringUtils.lowerCase(distinctField),distinctField);
            }
            soql += StringUtils.joinStrings(distinctFields.values(),'\n,');
        }
        soql += ' \nFROM ' + fromx;
        if(wherex != null){
			final String wherexs = wherex.toSoql(options);
			if(StringUtils.isNotBlank(wherexs)){  
				soql += ' \nWHERE ' + wherexs;
			} 
        }
          
        if(groupByx != null && groupByx != ''){
           soql += ' \nGROUP BY ' + groupByx + ' ';
        }
          
        if(orderByx != null && orderByx.size() > 0){
            isFirst = true;
        	for(OrderBy orderBy : orderByx){
        		if(orderBy == null){
        			continue;
        		}
	            if(isFirst){  
	                isFirst = false;
                    soql += ' \nORDER BY ';
	            } else {
	                soql += ', ';
	            }
                soql += orderBy.toSoql(options);
        	}
        }
        if(limitx != null){
            soql += ' \nLIMIT ' + limitx;
        }
        return soql;
    }
    
    private static Set<Object> getAllFieldNames(String objectName){
        final Set<Object> returnValue = new Set<Object>();
        objectName = StringUtils.lowerCase(StringUtils.trim(objectName));
        final Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        if(globalDescribe != null && globalDescribe.containsKey(objectName)){
            final Schema.SObjectType objectToken = globalDescribe.get(objectName);
	        if(objectToken != null){
	            final Map<String,Schema.SObjectField> fieldNameToFieldIndex = objectToken.getDescribe().fields.getMap();
                if(fieldNameToFieldIndex != null && fieldNameToFieldIndex.size() > 0){
                    for(String fieldName : fieldNameToFieldIndex.keySet()){
                        returnValue.add(fieldNameToFieldIndex.get(fieldName).getDescribe().getName());
                    }
                }
	        }
        }
        return returnValue;
    }
    
    
}