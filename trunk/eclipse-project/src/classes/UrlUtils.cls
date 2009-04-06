global class UrlUtils {
	
	global static String getBase(String url){
		String[] split = StringUtils.split(url, '?');
		if(split == null || split.size() == 0){
			return null;
		}
		return split[0];
	}

	global static Map<String,String> getParams(String url){
		//url -> http://google.com?api=x&xyz=123
    	Map<String,String> returnMap = new Map<String,String>();
    	String[] split = StringUtils.split(url, '?');
    	//split -> ['http://google.com','api=x&xyz=123']
		if(split == null || split.size() != 2 || split[1] == null){
			return returnMap;
		}
    	split = StringUtils.split(split[1],'&');
    	//split -> ['api=x','xyz=123']
		if(split != null && split.size() > 0){
			String[] split2 = null;
			for(String keyValuePair : split){
				//keyValuePair -> 'api=x'
				split2 = StringUtils.split(keyValuePair,'=');
				returnMap.put(
					(split2 == null || split2.size() < 1 ? '' : split2[0]),
					EncodingUtil.urlDecode(split2 == null || split2.size() < 2 ? '' : split2[1], 'UTF-8'));
			}
		}
		return returnMap;
	}

}