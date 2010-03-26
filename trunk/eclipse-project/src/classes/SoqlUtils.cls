global class SoqlUtils {

    global static String primitiveToSoqlLiteral(Object primitive){
    	String literal = '';
        if(         primitive == null){
            literal += 'null'; 
        } else if(  primitive instanceof String  ||
                    primitive instanceOf ID){
            literal += '\''+ primitive + '\''; 
        } else if(  primitive instanceOf Boolean ||
                    primitive instanceOf Integer || 
                    primitive instanceOf Long    || 
                    primitive instanceOf Double  || 
                    primitive instanceOf Decimal){
            literal += primitive;
        } else if(  primitive instanceOf Date){
            literal += Datetime.newInstance(((Date)primitive).year(), ((Date)primitive).month(), ((Date)primitive).day()).format('yyyy-MM-dd');
        } else if(  primitive instanceOf Datetime){
            literal += ((Datetime) primitive).format('yyyy-MM-dd') + 'T' + ((Datetime) primitive).format('hh:mm:ss') + 'Z';
        } else {
            throw new IllegalArgumentException('invalid primitive; primitive can be null or one of the following primitive types: ' 
                + '(String|ID|Boolean|Integer|Long|Double|Decimal|Date|Datetime');
        }
        return literal;
    }

	global static List<String> primitivesToSoqlLiterals(List<Object> primitives){
		final List<String> literals = new List<String>();
		if(primitives != null && primitives.size() > 0){
			for(Object obj : primitives){
				literals.add(primitiveToSoqlLiteral(obj));
			}
		}
		return literals;
	}

    global static void assertEquals(String expected, String actual){
        System.assert(
            equals(expected,actual),
            'Assertion failed, the following two SOQLs are not equal.  Expected: ' + expected + ', Actual: ' + actual);
    }

    /**
     * This equals is fairly simplistic.  It will account for unordered columns,
     * lower vs upper case (SELECT vs select) but it won't take into account anything else.  Different
     * order of where conditions for example.
     */
    global static Boolean equals(String soql1, String soql2){
        soql1 = StringUtils.trim(StringUtils.lowerCase(soql1));
        soql2 = StringUtils.trim(StringUtils.lowerCase(soql2));
        if(StringUtils.equals(soql1,soql2)){
            return true;
        }
        if(!StringUtils.startsWith(soql1, 'select') || !StringUtils.startsWith(soql2, 'select')){
        	return false;
        }
        String afterSelect1 = StringUtils.trim(StringUtils.substringAfter(soql1,'select'));
        String afterSelect2 = StringUtils.trim(StringUtils.substringAfter(soql2,'select'));
        Set<String> columns1 = StringUtils.trimAll(SetUtils.listToSet(StringUtils.split(StringUtils.trim(StringUtils.substringBefore(afterSelect1,'from')),',')));
        Set<String> columns2 = StringUtils.trimAll(SetUtils.listToSet(StringUtils.split(StringUtils.trim(StringUtils.substringBefore(afterSelect2,'from')),',')));
        System.debug('### columns1: ' + columns1);
        System.debug('### columns2: ' + columns2);
        if(!SetUtils.equals(columns1,columns2)){
        	return false;
        }
        String afterFrom1 = StringUtils.trim(StringUtils.substringAfter(soql1,'from'));
        String afterFrom2 = StringUtils.trim(StringUtils.substringAfter(soql2,'from'));
        return StringUtils.equals(afterFrom1,afterFrom2);
    }
    
    
}