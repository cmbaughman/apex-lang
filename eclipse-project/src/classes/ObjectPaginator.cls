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
global class ObjectPaginator {

	global static final Integer DEFAULT_PAGE_SIZE = 20;
	global static final Integer DEFAULT_SKIP_SIZE = 3;
	private static final Integer MAX_SKIP_SIZE = 20;

	private List<ObjectPaginatorListener> listeners = new List<ObjectPaginatorListener>();
	
	global List<Object> all {get;private set;}
	global List<Object> page {get;private set;}
	global Integer pageSize = DEFAULT_PAGE_SIZE;
	global Integer skipSize = DEFAULT_SKIP_SIZE;
	global Integer pageNumber {get;private set;}
	global Integer pageCount { get{ Double allSize = this.all == null ? 0 : this.all.size(); Double pageSize = this.pageSize; return this.all == null ? 0 : Math.ceil(allSize/pageSize).intValue(); } }
	global Integer recordCount {get{ return this.all == null ? 0 : this.all.size(); } }
	global Boolean hasNext{get{ return pageNumber >= 0 && pageNumber < this.pageCount-1;}}
	global Boolean hasPrevious{get{return pageNumber > 0 && pageNumber <= this.pageCount-1;}}
	global Integer pageStartPosition {get{ return this.pageNumber * this.pageSize; } }
	global Integer pageEndPosition {
		get{ 
			Integer endPosition = (this.pageNumber + 1) * this.pageSize - 1;
			endPosition = endPosition < this.all.size() ? endPosition : this.all.size()-1;
			return endPosition; 
		} 
	}
	global List<Integer> previousSkipPageNumbers {
		get{
			List<Integer> returnValues = new List<Integer>();
			for(Integer i = skipSize; i > 0; i--){
				if(pageNumber-i < 0){
					continue;
				}
				returnValues.add(pageNumber-i);
			}
			return returnValues;
		}
	}
	global List<Integer> nextSkipPageNumbers {
		get{
			List<Integer> returnValues = new List<Integer>();
			for(Integer i = 1; i <= skipSize; i++){
				if(pageNumber+i >= pageCount){
					break;
				}
				returnValues.add(pageNumber+i);
			}
			return returnValues;
		}
	}

	global Integer pageNumberDisplayFriendly {get{ return this.pageNumber + 1; } }
	global Integer pageStartPositionDisplayFriendly {get{ return this.pageStartPosition + 1; } }
	global Integer pageEndPositionDisplayFriendly {get{ return this.pageEndPosition + 1; } }

	global ObjectPaginator(List<Object> all){
		this(all,DEFAULT_PAGE_SIZE,DEFAULT_SKIP_SIZE,null);
	}
	
	global ObjectPaginator(List<Object> all, Integer pageSize){
		this(all,pageSize,DEFAULT_SKIP_SIZE,null);
	}
	
	global ObjectPaginator(List<Object> all, ObjectPaginatorListener listener){
		this(all,DEFAULT_PAGE_SIZE,listener);
	}
	
	global ObjectPaginator(List<Object> all, Integer pageSize, Integer skipSize){
		this(all,pageSize,skipSize,null);
	}
	
	global ObjectPaginator(List<Object> all, Integer pageSize, ObjectPaginatorListener listener){
		this(all,pageSize,DEFAULT_SKIP_SIZE,listener);
	}
	
	global ObjectPaginator(List<Object> all, Integer pageSize, Integer skipSize, ObjectPaginatorListener listener){
		setSkipSize(skipSize);
		addListener(listener);
		reset(all,pageSize);
	}
	
	global void setRecords(List<Object> all){
		reset(all,this.pageSize);
	}
	
	global void setPageSize(Integer pageSize){
		reset(this.all,pageSize);
	}

	global void setSkipSize(Integer skipSize){
		this.skipSize = skipSize < 0 || skipSize > MAX_SKIP_SIZE ? this.skipSize : skipSize;
	}
	
	global PageReference skipToPage(Integer pageNumber){
		if(pageNumber < 0 || pageNumber > this.pageCount-1){
			throw new IllegalArgumentException();
		}
		this.pageNumber = pageNumber;
		updatePage();
		return null;
	}
	
	global PageReference next(){
		if(!this.hasNext){
			throw new IllegalStateException();
		}
		pageNumber++;
		updatePage();
		return null;
	}
	
	global PageReference previous(){
		if(!this.hasPrevious){
			throw new IllegalStateException();
		}
		pageNumber--;
		updatePage();
		return null;
	}
	
	global PageReference first(){
		pageNumber = 0;
		updatePage();
		return null;
	}
	
	global PageReference last(){
		pageNumber = pageCount - 1;
		updatePage();
		return null;
	}
	
	private void reset(List<Object> all, Integer pageSize){
		this.all = all;
		this.pageSize = pageSize < 1 ? DEFAULT_PAGE_SIZE : pageSize;
		this.pageNumber = 0;
		updatePage();
	}

	private void updatePage() {
		this.page = null;
		if(this.all != null && this.all.size() > 0){
			/*
			Integer startPosition = this.pageNumber * this.pageSize;
			Integer endPosition = (this.pageNumber + 1) * this.pageSize - 1;
			endPosition = endPosition < this.all.size() ? endPosition : this.all.size()-1;
			*/
			this.page = new List<Object>();
			for (Integer i = this.pageStartPosition; i <= this.pageEndPosition; i++) {
				this.page.add(this.all.get(i));
			}
		}
		for(ObjectPaginatorListener listener : listeners){
			listener.handlePageChange(this.page);
		}
		/*
		System.debug('==============================================================');
		System.debug('After Update Page:');
		System.debug('this.all         = ' + ArrayUtils.toString(this.all));
		System.debug('this.page        = ' + ArrayUtils.toString(this.page));
		System.debug('this.pageSize    = ' + this.pageSize);
		System.debug('this.pageNumber  = ' + this.pageNumber);
		System.debug('this.pageCount   = ' + this.pageCount);
		System.debug('this.recordCount = ' + this.recordCount);
		System.debug('this.hasNext     = ' + this.hasNext);
		System.debug('this.hasPrevious = ' + this.hasPrevious);
		System.debug('==============================================================');
		*/
	}
	 
	global void addListener(ObjectPaginatorListener listener){
		if(listener != null){
			listeners.add(listener);
		}
	}

}