global class MapUtils {
	
	global static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
		if(theMap == null){
			return null;
		}
		List<String> keyValuePairs = new List<String>();
		for(String key : theMap.keySet()){
			keyValuePairs.add(key + keyValueSeparator + theMap.get(key));
		}
		return StringUtils.joinArray(keyValuePairs, recordSeparator);
	}
	
	global static String toString(Map<String,String> theMap){
		return '<Map#([' + joinMap(theMap,'=',';') + '])>';
	}
	
	global static Boolean equals(Map<String,String> map1, Map<String,String> map2){
		if(map1 == null && map2 == null){
			return true;
		}
		if((map1 != null && map2 == null) 
			|| (map1 == null && map2 != null)
			|| (map1.size() != map2.size())){
			return false;
		}
		for(String key1 : map1.keySet()){
			if(!map2.containsKey(key1)){
				return false;
			}
			if(map1.get(key1) != map2.get(key1)){
				return false;
			}
		}
		return true;
	}
	
}