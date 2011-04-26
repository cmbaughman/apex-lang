global class GroupUtils {
	global static boolean isGroup(Id id) {
		return String.valueOf(id).startsWith(Schema.getGlobalDescribe().get('group').getDescribe().getKeyPrefix());
	}
	
	global static User[] getUsers(Id groupId) {
		if (!isGroup(groupId)) {
			throw new IllegalArgumentException('groupId must be a group');
		}
		
		List<User> groupMembers = new List<User>();
		for (GroupMember gm : [select id, groupid, userorgroupid from groupmember where groupid = :groupId]) {
			if (isGroup(gm.UserOrGroupId)) {
				groupMembers.addAll(getUsers(gm.UserOrGroupId));
			} else {
				groupMembers.add(new User(id=gm.UserOrGroupId));
			}
		}
		return groupMembers;
	}
	
	global static User[] getUsers(Group aGroup) {
		return getUsers(aGroup.id);
	}
	
}