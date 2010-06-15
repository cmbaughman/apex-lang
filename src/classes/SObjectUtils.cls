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


    //NOTE: would've preferred to use a Set instead of a List but unfortunately, Sets of Enums
    //  are not allowed as of Spring '10.  Seems silly they aren't.  Especially since it
    //  necessitates a custom "contains" method.  Even though using a List is a workaround, it
    //  still looks better than multiple ORs in the bottom of the copyFields method.
    private static final List<Schema.DisplayType> STRING_TYPES      = new List<Schema.DisplayType>{
        Schema.DisplayType.base64
        ,Schema.DisplayType.Email
        ,Schema.DisplayType.MultiPicklist
        ,Schema.DisplayType.Phone
        ,Schema.DisplayType.Picklist
        ,Schema.DisplayType.String
        ,Schema.DisplayType.TextArea
        ,Schema.DisplayType.URL
    };
    private static final List<Schema.DisplayType> INTEGER_TYPES     = new List<Schema.DisplayType>{
        Schema.DisplayType.Integer
    };
    private static final List<Schema.DisplayType> ID_TYPES          = new List<Schema.DisplayType>{
        Schema.DisplayType.ID
        ,Schema.DisplayType.Reference
    };
    private static final List<Schema.DisplayType> DOUBLE_TYPES      = new List<Schema.DisplayType>{
        Schema.DisplayType.Currency
        ,Schema.DisplayType.Double
        ,Schema.DisplayType.Percent
    };
    private static final List<Schema.DisplayType> DATETIME_TYPES    = new List<Schema.DisplayType>{
        Schema.DisplayType.DateTime
    };
    private static final List<Schema.DisplayType> DATE_TYPES        = new List<Schema.DisplayType>{
        Schema.DisplayType.Date
    };
    private static final List<Schema.DisplayType> BOOLEAN_TYPES     = new List<Schema.DisplayType>{
        Schema.DisplayType.Boolean
        ,Schema.DisplayType.Combobox
    };

    global static Boolean isAnyFieldBlank(SObject obj, String[] fields){
        return ArrayUtils.isNotEmpty(getBlankFields(obj,fields));
    }
    
    global static String[] getBlankFields(SObject obj, String[] fields){
        if(obj == null || ArrayUtils.isEmpty(fields)){
            return new String[]{};
        }
        List<String> blankFields = new List<String>();
        Object value = null;
        for(String field : fields){
            value = obj.get(field);
            if(value == null || (value instanceof String && StringUtils.isBlank((String)value))){
                blankFields.add(field);
            }
        }
        return blankFields;
    }
    
    /*
    private static final Map<String,Schema.DescribeSObjectResult> cachedDescribes = new Map<String,Schema.DescribeSObjectResult>();
    global static Schema.DescribeSObjectResult getCachedDescribe(SObject obj){
        if(obj == null){
            return null;
        }
        final String objectApiName = ''+ obj.getsObjectType();
        if(!cachedDescribes.containsKey(objectApiName)){
            cachedDescribes.put(objectApiName, obj.getsObjectType().getDescribe());
        }
        return cachedDescribes.get(objectApiName);
    }
    */
    
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
    
    /*
    //Commenting this out because it can't be reliably tested.  In order to get 100%
    //  code coverage on this method, an org MUST have at least one queue (the test
    //  case actually needs a Lead queue).  But since that can't be controlled by
    //  test code, I'm just commenting this out but it in the source in case anyone
    //  would like to re-use it in the future.  If you do want to re-use it, you'll
    //  need to do one of the following:
    //    (1) customize test method SObjectUtilsTest.testSendNotificationEmail()
    //    (2) create a Lead queue
    
    global static void sendNotificationEmail(SObject obj){
        if(obj == null || obj.id == null){
            throw new IllegalArgumentException();
        }
        
        final Schema.DescribeSObjectResult objDesc = obj.getSObjectType().getDescribe();
        SObject retrieved = null;
        try{
            retrieved = Database.query(
               'select id,name,ownerid from '+ objDesc.getName() 
               + ' where id = \'' + obj.id + '\' and owner.type = \'Queue\'');
        }catch(QueryException e){}
        if(retrieved == null){
            throw new IllegalArgumentException();
        }
        final Set<String> emailSet = new Set<String>();
        final ID ownerId = (ID) retrieved.get('ownerid');
        final List<GroupMember> members = [select UserOrGroupId, Group.Email from GroupMember where groupid = :ownerId];
        final Set<ID> userIds = new Set<ID>();
        if(members != null && members.size() > 0){
            for(GroupMember member : members){
                userIds.add(member.UserOrGroupId);
                if(StringUtils.isNotEmpty(member.Group.Email)){
                    emailSet.add(member.Group.Email);
                }
            }
        }
        final List<User> users = [select id,email from user where id in :userIds];
        if(users != null && users.size() > 0){
            for(User usr : users){
                if(StringUtils.isNotEmpty(usr.email)){
                    emailSet.add(usr.email);
                }
            }
        }
        final List<String> emailList = new List<String>();
        for(String email : emailSet){
            emailList.add(email);
        }
        EmailUtils.sendTextEmail(   emailList,
                                    objDesc.getName() + ' transferred to you.',
                                    objDesc.getName() + ' ' + retrieved.get('name') + ' has been assigned to you. Please click on the link below to view the record.\n\nhttps://login.salesforce.com/?startURL=%2F' + retrieved.get('id')
        );
    }
    */

    global static SObject copyFields(SObject source, SObject destination){
        if(source == null || destination == null){
            return destination;
        }
        final Map<String,Schema.SObjectField> sourceFields = source.getSObjectType().getDescribe().fields.getMap();
        final Map<String,Schema.SObjectField> destinationFields = destination.getSObjectType().getDescribe().fields.getMap();
        final List<Schema.DescribeFieldResult> commonFieldsToCopy = new List<Schema.DescribeFieldResult>();
        
        Schema.DescribeFieldResult sourceField = null;
        Schema.DescribeFieldResult destinationField = null;
        for(String fieldName : sourceFields.keySet()){ 
            sourceField = sourceFields.get(fieldName).getDescribe();
            if(destinationFields.get(fieldName) == null){
                //destination doesn't have corresponding field so skip
                continue;
            }
            destinationField = destinationFields.get(fieldName).getDescribe();
            if( !sourceField.isAccessible()
                || !destinationField.isAccessible()
                || destinationField.isAutoNumber()
                || destinationField.isCalculated()
                || (StringUtils.isBlank((String)destination.get('id')) && !destinationField.isCreateable()) 
                || (StringUtils.isNotBlank((String)destination.get('id')) && !destinationField.isUpdateable())
                || sourceField.getType() != destinationField.getType()){
                //source or destination field either can't or shouldn't be read or written to    
                continue;
            }
            if(contains(STRING_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(String)source.get(sourceField.getName()));
            } else if(contains(INTEGER_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Integer)source.get(sourceField.getName()));
            } else if(contains(ID_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(ID)source.get(sourceField.getName()));
            } else if(contains(DOUBLE_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Double)source.get(sourceField.getName()));
            } else if(contains(DATETIME_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(DateTime)source.get(sourceField.getName()));
            } else if(contains(DATE_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Date)source.get(sourceField.getName()));
            } else if(contains(BOOLEAN_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Boolean)source.get(sourceField.getName()));
            }
        }
        return destination;
    }   
    
    private static Boolean contains(List<Schema.DisplayType> aListActingAsSet, Schema.DisplayType typeToCheck){
        if(aListActingAsSet != null && aListActingAsSet.size() > 0){
            for(Schema.DisplayType aType : aListActingAsSet){
                if(aType == typeToCheck){
                    return true;
                }
            }
        }
        return false;
    }
    
    global static Object putQuietly(SObject sobj, String fieldName, Object value){
        Object old = null;
        if(sobj != null && fieldName != null){
            try{
            	old = getQuietly(sobj,fieldName);
            	
            	//NOTE:  the following line doesn't handle nulls for some strange reason
            	//  in Spring '10.  In order to make it work, the if is needed to explicitly 
            	//  pass null.
                //sobj.put(fieldName,value);
				if(value==null){
				    sobj.put(fieldName,null);
				}else{
				    sobj.put(fieldName,value);
				}
            }catch(System.SObjectException e){}
        }
        return old;
    }
    
    global static Object getQuietly(SObject sobj, String fieldName){
    	Object returnValue = null;
        if(sobj != null && fieldName != null){
            try{
                returnValue = sobj.get(fieldName);
            }catch(SObjectException e){}
        }
        return returnValue;
    }
    
    
}