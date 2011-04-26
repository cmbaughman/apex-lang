@isTest
private class GroupUtilsTest {

    static testMethod void test_isGroup_Id() {
    	//Test: global static boolean isGroup(Id id)
        Group g1 = new Group(name='Test');
        insert g1;
        GroupUtils.isGroup(g1.id);
    }
    
    static testMethod void test_getUsers_Id() {
	    //Test: global static User[] getUsers(Id groupId)
		
		//Fail
        User[] users = [select id from User where isactive = true];
        try {
	        GroupUtils.getUsers(users[0].id);
        } catch (IllegalArgumentException e) {
        	
        }
        
        //Pass
        Group g1 = new Group(name='Test');
        insert g1;
		Group g2 = new Group(name='Test2',type='Queue');
		insert g2;
		
		for (User user : [select id from User where isactive = true limit 2]) {
			GroupMember gm = new GroupMember(groupid=g1.id,userorgroupid=user.id);
			insert gm;
			g1.groupmembers.add(gm);
		}
		
		GroupMember gm = new GroupMember(groupid=g2.id,userorgroupid=g1.id);
		insert gm;
		g2.groupmembers.add(gm);
		
		GroupUtils.getUsers(g2.id);
    }
 
   static testMethod void test_getUsers_Group() {
	    //Test: global static User[] getUsers(Group aGroup)
	    Group g1 = new Group(name='Test');
        insert g1;
        GroupUtils.getUsers(g1);
    }
}