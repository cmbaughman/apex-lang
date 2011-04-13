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
global class DatabaseUtils {
	
    global final static List<String> NULL_LIST_OF_STRINGS = null;
    global final static Set<String> NULL_SET_OF_STRINGS = null;

    global static SObject query(String id){
        return first(query(new Set<String>{id}, NULL_SET_OF_STRINGS));
    }

    global static SObject query(String id, List<String> fields){
        return first(query(new Set<String>{id}, fields));
    }

    global static SObject query(String id, Set<String> fields){
        return first(query(new Set<String>{id}, fields));
    }

    global static List<SObject> query(List<String> ids){
        return query(ids, NULL_SET_OF_STRINGS);
    }

    global static List<SObject> query(Set<String> ids){
        return query(ids, NULL_SET_OF_STRINGS);
    }

    global static List<SObject> query(List<String> ids, List<String> fields){
        return query(SetUtils.listToSet(ids), SetUtils.listToSet(fields));
    }

    global static List<SObject> query(List<String> ids, Set<String> fields){
        return query(SetUtils.listToSet(ids), fields);
    }

    global static List<SObject> query(Set<String> ids, List<String> fields){
        return query(ids, SetUtils.listToSet(fields));
    }

    global static List<SObject> query(Set<String> ids, Set<String> fields){
        if(ids == null || ids.size() <= 0){
            throw new IllegalArgumentException('ids argument must not be empty: ' + ids);
        }
        final Set<String> distinctKeyPrefixes = left(trim(ids),3);
        if(distinctKeyPrefixes.size() > 1){
            //ruh-roh, someone mixed types
            throw new IllegalArgumentException('ids argument invalid:  multiple SObject types detected: ' + distinctKeyPrefixes);
        }
        final SoqlBuilder soql = 
            new SoqlBuilder()
               .fromx(retrieveObjectName(SetUtils.setToList(distinctKeyPrefixes).get(0)))
               .wherex(new SetCondition('id').inx(SetUtils.setToList(ids)));
        if(fields == null || fields.size() <= 0){
            soql.selectAll();
        } else {
        	soql.selectx(fields);
        }
        return Database.query(soql.toSoql());
    }

    global static String retrieveObjectName(String recordId) {
        String returnValue = null;
        final String keyPrefixToMatch = StringUtils.left(recordId,3);
        String keyPrefix = null;
        final Map<String,Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        for(String objectNameKey : globalDescribe.keySet()){
            keyPrefix = globalDescribe.get(objectNameKey).getDescribe().getKeyPrefix();
            if(StringUtils.isNotBlank(keyPrefix) && StringUtils.equals(keyPrefix,keyPrefixToMatch)){
                returnValue = objectNameKey;
                break;
            }
        }
        if(StringUtils.isBlank(returnValue)){
            throw new IllegalArgumentException('ids argument invalid: key prefix not found: ' + keyPrefixToMatch);
        }
    	return returnValue;
    }
    
    global static Set<String> left(Set<String> strs, Integer len) {
        Set<String> returnValue = null;
        if(strs != null || strs.size() > 0){
            returnValue = new Set<String>();
            for(String str : strs){
                returnValue.add(StringUtils.left(str,len));
            }
        }
        return returnValue;
    }

    global static Set<String> trim(Set<String> strs) {
        Set<String> returnValue = null;
        if(strs != null || strs.size() > 0){
            returnValue = new Set<String>();
            for(String str : strs){
                returnValue.add(StringUtils.trim(str));
            }
        }
        return returnValue;
    }

    global static SObject first(List<SObject> records){
        SObject returnValue = null;
        if(records != null && records.size() > 0){
            returnValue = records.get(0);
        }
        return returnValue;
    }


}