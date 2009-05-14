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
global class SObjectUtils {

	global static Boolean isAnyFieldBlank(SObject obj, String[] fields){
		if(obj == null || ArrayUtils.isEmpty(fields)){
			return false;
		}
		Boolean anyFieldBlank = false;
		Object value = null;
		for(String field : fields){
			value = obj.get(field);
			if(value == null || (value instanceof String && StringUtils.isBlank((String)value))){
				anyFieldBlank = true;
			}
		}
		return anyFieldBlank;
	}
	
	global static String toString(SObject obj){
		if(Limits.getFieldsDescribes() >= Limits.getLimitFieldsDescribes()){
			return null;
		}
		if(obj == null){
			return 'null';
		}
		Schema.DescribeSObjectResult objDesc = obj.getSObjectType().getDescribe();
		List<String> fieldValues = new List<String>();
	   	Map<String, Schema.SObjectField> m = objDesc.fields.getMap();        
	   	for (Schema.SObjectField f : m.values()) { 
			Schema.DescribeFieldResult d = f.getDescribe();    
			fieldValues.add(d.getName() + '=' + obj.get(d.getName()));
		}
		return '<#' + objDesc.getName() + '(' + StringUtils.joinArray(fieldValues,',') + ')>';
	}
	
	
}