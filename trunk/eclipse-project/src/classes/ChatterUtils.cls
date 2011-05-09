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
global class ChatterUtils {
	
    global static Boolean isChatterEnabled(){
        Boolean returnValue = false;
        try{
             SObjectType token = Schema.getGlobalDescribe().get('FeedPost');
             if(token != null){
                 SObject objPost = token.newSObject();
                 if(objPost != null){
                     objPost.put('ParentId', UserInfo.getUserId()); 
                     objPost.put('Body', 'test post');
                     insert objPost;
                     delete objPost;
                     returnValue = true; 
                 }
             }
        }catch (Exception e) {}
        return returnValue;
    }
    
    global static List<SObject> deleteFollowers(List<SObject> objectIdsToDeleteFollowers) {
        Set<String> ids = new Set<String>();
        if(objectIdsToDeleteFollowers != null && objectIdsToDeleteFollowers.size() > 0){
            for (SObject so : objectIdsToDeleteFollowers) {
                if(so != null && so.id != null){
                    ids.add(so.id);
                }
            }
        }
        return deleteFollowers(ids);
    }

    global static List<SObject> deleteFollowers(String objectIdToDeleteFollowers) {
        List<SObject> returnValue = null;
        if(objectIdToDeleteFollowers != null){
            returnValue = deleteFollowers(new Set<String>{objectIdToDeleteFollowers});
        }
        return returnValue;
    }
    
    global static List<SObject> deleteFollowers(Set<String> objectIdsToDeleteFollowers) {
        List<SObject> returnValue = null;
        if(   isChatterEnabled()
           && objectIdsToDeleteFollowers != null
           && objectIdsToDeleteFollowers.size() > 0 
        ){ 
            returnValue = Database.query(
                new SoqlBuilder()
                .fromx('EntitySubscription')
                .wherex(new SetCondition('parentId').inx(SetUtils.setToList(objectIdsToDeleteFollowers)))
                .toSoql()
            );
        } 
        return returnValue;
    }

/*
    global static EntitySubscription[] addFollower(Id userId, Id objectIdToFollow) {
    	EntitySubscription[] es = new List<EntitySubscription>();
    	if (GroupUtils.isGroup(userId)) {
    		for (User user : GroupUtils.getUsers(userId)) {
    			es.add(new EntitySubscription(parentId=objectIdToFollow,subscriberId=user.id));
    		}
    	} else {
    		es.add(new EntitySubscription(parentId=objectIdToFollow,subscriberId=userId));
    	}
        return es;
    }
    
    global static EntitySubscription addFollower(User user, SObject objectToFollow) {
		if (user == null) {
    		throw new IllegalArgumentException('User must not be null');
    	}
		if (objectToFollow == null) {
    		throw new IllegalArgumentException('Object to follow must not be null');
    	}

        return new EntitySubscription(parentId=objectToFollow.id,subscriberId=user.id);
    }
    
    global static EntitySubscription[] addFollowers(Group aGroup, SObject objectToFollow) {
    	EntitySubscription[] es = new List<EntitySubscription>();
    	User[] users = GroupUtils.getUsers(aGroup);
		for (User user : users) {
			es.add(new EntitySubscription(parentId=objectToFollow.id,subscriberId=user.id));
		}
		return es;
    }
    
    global static EntitySubscription[] addFollowers(Id[] userIds, Id objectIdToFollow) {
    	EntitySubscription[] es = new List<EntitySubscription>();
    	for (Id userId : userIds) {
            es.add(new EntitySubscription(parentId=objectIdToFollow,subscriberId=userId));
        }
        return es;
    }
    
    global static EntitySubscription[] addFollowers(User[] users, SObject sobj) {
    	Id[] userIds = new List<Id>();
    	for (User user : users) {
    		userIds.add(user.id);
    	}
    	return addFollowers(userIds,sobj.id);
    }
    
    global static EntitySubscription[] copyFollowers(Id objectIdToCopyFrom, Id objectIdToFollow) {
        User[] users = [select id from user where id in 
                (select subscriberId from EntitySubscription where parentId = :objectIdToCopyFrom)];
        EntitySubscription[] es = new List<EntitySubscription>();
        for (User user : users) {
            es.add(new EntitySubscription(parentId=objectIdToFollow,subscriberId=user.Id));
        }
        return es;
    }
    
    global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject objectToFollow) {
    	if (objectToCopyFrom == null) {
    		throw new IllegalArgumentException('Object to copy followers from must not be null');
    	}
		if (objectToFollow == null) {
    		throw new IllegalArgumentException('Object to follow must not be null');
    	}
    	
	    return copyFollowers(objectToCopyFrom.id,objectToFollow.id);
    }
    
    global static EntitySubscription[] copyFollowers(SObject objectToCopyFrom, SObject[] objectsToFollow) {
    	if (objectToCopyFrom == null) {
    		throw new IllegalArgumentException('Object to copy followers from must not be null');
    	}
    	
		EntitySubscription[] es = new List<EntitySubscription>();
    	for (SObject objectToFollow : objectsToFollow) {
    		es.addAll(copyFollowers(objectToCopyFrom,objectToFollow));
    	}
    	return es;
    }
    
    //I wanted to add the below method, but could not figure out a way to test it
    /*
    global static EntitySubscription addFollower(Name user, SObject objectToFollow) {
        if (user == null) {
            throw new IllegalArgumentException('User must not be null');
        }
        if (objectToFollow == null) {
            throw new IllegalArgumentException('Object to follow must not be null');
        }
        
        return new EntitySubscription(parentId=objectToFollow.id,subscriberId=user.id);
    }
    */
    
	/**
	This is useless if you use Chatter Desktop or Chatter Mobile as the URLs are relative.
	*/
    /*
    global static FeedPost addRelatedPost(String title, String body, Id parentId, Id relatedObjectId) {
        FeedPost issuePost = new FeedPost();
        issuePost.Type = 'LinkPost';
        issuePost.ParentId = parentId;
        issuePost.Title = title;
        issuePost.Body = body;
        issuePost.LinkUrl= '/' + relatedObjectId;
        return issuePost;
    }
    
    global static FeedPost addRelatedPost(String title, String body, Id parentId, Id relatedObjectId, String absoluteUrl) {
        FeedPost issuePost = new FeedPost();
        issuePost.Type = 'LinkPost';
        issuePost.ParentId = parentId;
        issuePost.Title = title;
        issuePost.Body = body;
        issuePost.LinkUrl= absoluteUrl + relatedObjectId;
        return issuePost;
    }
    */
}