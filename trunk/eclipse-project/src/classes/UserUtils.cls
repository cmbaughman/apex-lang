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
global class UserUtils {
    
    global static Boolean isCurrentUserSysAdmin(){
    	final List<User> users = [
    	   select id, name 
    	   from User 
    	   where id = :UserInfo.getUserId() 
    	   and profile.name = 'System Administrator']; 
    	return (users == null ? false : users.size() > 0);
    }

    global static Boolean isCurrentUserPortalUser(){
        return getCurrentUserPortalAccountID() != null;
    }
    
    global static ID getCurrentUserPortalAccountID(){
        User usr = 
            [select id, ContactId, Contact.AccountId, userrole.name 
            from user 
            where id = :UserInfo.getUserId()];
        return usr.Contact.AccountId;
    }

    global static Boolean isCurrentUserGuest(){
    	User user = null;
    	try{
	        user = [
	           select id 
	           from User 
	           where id = :UserInfo.getUserId() 
	           and profile.UserLicense.LicenseDefinitionKey = 'PID_Guest_User'
            ]; 
    	}catch(QueryException e){}
        return user != null;
    }

    
}