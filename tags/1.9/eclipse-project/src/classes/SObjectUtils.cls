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
    
}