@isTest
private class ChatterUtilsTest {
	static testMethod void test_deleteFollowers_Id() {
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        ChatterUtils.deleteFollowers(acct1.id);
	}
	
	static testMethod void test_deleteFollowers_Set() {
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        Set<Id> set1 = new Set<Id>();
        set1.add(acct1.id);
        set1.add(acct2.id);
        ChatterUtils.deleteFollowers(set1);
	}
	
	static testMethod void test_deleteFollowers_ListSObject() {
		User[] users = [select id from User where isactive = true];
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        List<SObject> list1 = new List<SObject>();
        list1.add(acct1);
        list1.add(acct2);
        ChatterUtils.deleteFollowers(list1);
	}
	
	static testMethod void test_addFollowers_Id_User() {
		//Test: global static void addFollower(Id userId, Id objectIdToFollow)
		User[] users = [select id from User where isactive = true];
		Account acct1 = new Account(name='acct1');
        insert acct1;
        ChatterUtils.addFollower(users[0].id,acct1.id);
	}
        
	static testMethod void test_addFollowers_Id_Group() {
		//Test: global static void addFollower(Id userId, Id objectIdToFollow)
		Group aGroup = new Group(name='Test',type='Queue');
		insert aGroup;
		Account acct1 = new Account(name='acct1');
        insert acct1;
        ChatterUtils.addFollower(aGroup.id,acct1.id);
	}
	
	static testMethod void test_addFollower_User() {
		//Test: global static EntitySubscription addFollower(User user, SObject objectToFollow)
		User[] users = [select id from User where isactive = true];
		Account acct1 = new Account(name='acct1');
        insert acct1;
        ChatterUtils.addFollower(users[0],acct1);
	}
	
	static testMethod void test_addFollower_User_Null() {
		//Test: global static EntitySubscription addFollower(User user, SObject objectToFollow)
		try {
			Account acct1 = new Account(name='acct1');
	        insert acct1;
        	ChatterUtils.addFollower((User) null,acct1);
		} catch (IllegalArgumentException e) {
			
		}
        
        try {
	        User[] users = [select id from User where isactive = true];
	        ChatterUtils.addFollower(users[0],null);
        } catch (IllegalArgumentException e) {
			
		}
	}
	
	static testMethod void test_addFollowers_Id_Array() {
		//Test: global static EntitySubscription[] addFollowers(Id[] userIds, Id objectIdToFollow)
		User[] users = [select id from User where isactive = true limit 2];
		Account acct1 = new Account(name='acct1');
        insert acct1;
        ChatterUtils.addFollowers(users,acct1);
	}

	
	static testMethod void test_addFollowers_Group() {
		//Test: global static EntitySubscription[] addFollowers(Group aGroup, SObject objectToFollow)
		Group aGroup = new Group(name='Test',type='Queue');
		insert aGroup;
		Account acct1 = new Account(name='acct1');
        insert acct1;
        ChatterUtils.addFollowers(aGroup,acct1);
	}
	
	static testMethod void test_copyFollowers_Id_WithFollowers() {
		//Test: global static void copyFollowers(Id objectIdToCopyFrom, Id objectIdToFollow)
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        ChatterUtils.copyFollowers(acct1.id,acct2.id);
	}
	
	static testMethod void test_copyFollowers_Id_NoFollowers() {
		//Test: global static void copyFollowers(Id objectIdToCopyFrom, Id objectIdToFollow)
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        ChatterUtils.copyFollowers(acct1.id,acct2.id);
	}
	
	static testMethod void test_copyFollowers_SObject() {
		//Test: global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject objectToFollow)
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        ChatterUtils.copyFollowers(acct1,acct2);
	}
	
	static testMethod void test_copyFollowers_SObject_Array() {
		//Test: global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject[] objectsToFollow)
		User[] users = [select id from User where isactive = true];
		
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        Account acct3 = new Account(name='acct3');
        insert acct3;
        EntitySubscription es0 = new EntitySubscription(parentId=acct1.id,subscriberId=users[0].id);
        insert es0;
        EntitySubscription es1 = new EntitySubscription(parentId=acct1.id,subscriberId=users[1].id);
        insert es1;
        EntitySubscription es2 = new EntitySubscription(parentId=acct2.id,subscriberId=users[1].id);
        insert es2;
        ChatterUtils.copyFollowers(acct1,new List<Account>{acct2,acct3});
	}
	
	static testMethod void test_copyFollowers_SObject_Array_Null() {
		//Test: global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject[] objectsToFollow)
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
		
		try {
        	ChatterUtils.copyFollowers((Account) null,new List<Account>{acct1,acct2});
		} catch (IllegalArgumentException e) {
			
		}
	}
	
	static testMethod void test_copyFollowers_SObject_Null() {
		//Test: global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject objectToFollow)
		Account acct1 = new Account(name='acct1');
        insert acct1;
		
		try {
        	ChatterUtils.copyFollowers((Account) null,acct1);
		} catch (IllegalArgumentException e) {
			
		}
        
        try {
	        ChatterUtils.copyFollowers(acct1,(Account) null);
        } catch (IllegalArgumentException e) {
			
		}
	}
	
	static testMethod void test_addRelatedPost() {
		//Test: global static FeedPost addRelatedPost(String title, String body, Id parentId, Id relatedObjectId)
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        ChatterUtils.addRelatedPost(acct1.name, 'added a related account:', acct1.id, acct2.id);
	}
	
	static testMethod void test_addRelatedPost_absolute() {
		//Test: global static FeedPost addRelatedPost(String title, String body, Id parentId, Id relatedObjectId, String absoluteUrl)
		Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        ChatterUtils.addRelatedPost(acct1.name, 'added a related account:', acct1.id, acct2.id, 'https://na7.salesforce.com/');
	}
	
}