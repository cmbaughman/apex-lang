global class StringBuffer {

	private String theString;
	
	global StringBuffer(){
		this('');
	}
	
	global StringBuffer(String str){
		theString = str;
	}
	
	global StringBuffer append(String str){
		theString += str; return this;	
	}
	/*
	global StringBuffer append(Decimal d){
		theString += d;	return this;
	}
	
	global StringBuffer append(Double d){
		theString += d;	return this;
	}
	
	global StringBuffer append(Long l){
		theString += l;	return this;
	}
	
	global StringBuffer append(Integer i){
		theString += i;	return this;
	}
	
	global StringBuffer append(Blob b){
		theString += b;	return this;
	}
	
	global StringBuffer append(Boolean b){
		theString += b;	return this;
	}
	
	global StringBuffer append(Date d){
		theString += d;	return this;
	}
	
	global StringBuffer append(Datetime d){
		theString += d;	return this;
	}
	
	global StringBuffer append(ID id){
		theString += id; return this;
	}
	
	global StringBuffer append(Time t){
		theString += t;	return this;
	}
	*/
	global String toStr(){
		return theString;
	}
}