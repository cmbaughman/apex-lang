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
    global static EntitySubscription[] deleteFollowers(List<SObject> objectIdsToDeleteFollowers) {
        Set<Id> idSet = new Set<Id>();
        for (SObject so : objectIdsToDeleteFollowers) {
            idSet.add(so.id);
        }
        return deleteFollowers(idSet);
    }
    
    global static EntitySubscription[] deleteFollowers(Id objectIdToDeleteFollowers) {
        return [select id from EntitySubscription where parentId = :objectIdToDeleteFollowers];
    }
    
    global static EntitySubscription[] deleteFollowers(Set<Id> objectIdsToDeleteFollowers) {
        return [select id from EntitySubscription where parentId in :objectIdsToDeleteFollowers];
    }
    
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
    
	/**
	This is useless if you use Chatter Desktop or Chatter Mobile as the URLs are relative.
	*/
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
}