public abstract class StickyParametersController {

	private String[] stickyParams = null;
	private Map<String,String> savedParams = new Map<String,String>();
	
	public StickyParametersController(String[] stickyParams){
		this.stickyParams = stickyParams;
		if(this.stickyParams == null){
			this.stickyParams = new String[]{};
		}
		System.debug('### params to make sticky: ' + StringUtils.joinArray(stickyParams));
		Map<String,String> params = ApexPages.currentPage().getParameters();
		System.debug('### real params          : ' + MapUtils.toString(params));
		if(!this.stickyParams.isEmpty() && params != null){
			for(String stickyParam : stickyParams){
				savedParams.put(stickyParam,params.get(stickyParam));
			}
		}
		System.debug('### saved params         : ' + MapUtils.toString(savedParams));
	}

	public PageReference standardRedirect(PageReference newPage){
		return standardRedirect(newPage,null);
	}	
	
	public PageReference standardRedirect(PageReference newPage, Map<String,String> params){
		System.debug('### standardRedirect(' + (newPage == null ? 'null' : '\'' + newPage.getUrl() + '\'')
			+ ',' + MapUtils.toString(params) + '): invoked');
		if(newPage == null){
			return null;
		}
		if(params == null || params.isEmpty()){
			params = savedParams;
		} else {
			params = params.clone();
			for(String key : savedParams.keySet()){
				params.put(key,savedParams.get(key));
			}
		}
		
		if(params == null || params.isEmpty()){
			return PageUtils.redirect(newPage.getUrl());
		}
		System.debug('### params spliced: ' + MapUtils.toString(params) );
		Map<String,String> urlEncodedParams = new Map<String,String>();
		String value = null;
		for(String key : params.keySet()){
			value = params.get(key);
			if(StringUtils.isBlank(key) || StringUtils.isBlank(value)){
				continue;
			}
			urlEncodedParams.put(key,EncodingUtil.urlEncode(value, 'UTF-8'));
			//urlEncodedParams.put(key,value);
		}
		System.debug('### urlEncodedParams: ' + MapUtils.toString(urlEncodedParams) );
		if(urlEncodedParams.isEmpty()){
			return PageUtils.redirect(newPage.getUrl());
		}
		System.debug('###   url: ' + newPage.getUrl() + '?' + MapUtils.joinMap(urlEncodedParams,'=','&') );
		PageReference returnPage = PageUtils.redirect(newPage.getUrl() + '?' + MapUtils.joinMap(urlEncodedParams,'=','&'));
		System.debug('### p url: ' + returnPage );
		System.debug('### p url: ' + returnPage.getUrl() );
		return returnPage;
	}
	

}