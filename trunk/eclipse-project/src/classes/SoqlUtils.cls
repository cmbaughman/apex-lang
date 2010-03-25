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
}