global class SoqlBuilder implements Soqlable{
	
    private Set<Object>     selectx     = null;
    private Boolean         selectCount = false;
    private String          fromx       = null;
    private Condition       wherex      = null;
    private List<OrderBy>   orderByx    = null;
    private Integer         limitx      = null;
    
    global SoqlBuilder(){}
    
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
        if(this.selectCount != null && this.selectCount){
        	soql += 'count()';
        } else {
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
            soql += StringUtils.joinStrings(distinctFields.values(),',');
        }
        soql += ' FROM ' + fromx;
        if(wherex != null){
            soql += ' WHERE ' + wherex.toSoql(options);
        }
        
        if(orderByx != null && orderByx.size() > 0){
            isFirst = true;
        	for(OrderBy orderBy : orderByx){
        		if(orderBy == null){
        			continue;
        		}
	            if(isFirst){
	                isFirst = false;
                    soql += ' ORDER BY ';
	            } else {
	                soql += ', ';
	            }
                soql += orderBy.toSoql(options);
        	}
        }
        if(limitx != null){
            soql += ' LIMIT ' + limitx;
        }
        return soql;
    }
    
    
}