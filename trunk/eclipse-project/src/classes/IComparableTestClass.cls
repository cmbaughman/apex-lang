global class IComparableTestClass implements IComparable{
	public Double attribute{get; set;}
	public IComparableTestClass(Double arg){
		this.attribute=arg;
	}
	global Integer compareTo(IComparable arg){
		if(arg==null || !(arg instanceof IComparableTestClass))
			throw new IllegalArgumentException();
		IComparableTestClass result=(IComparableTestClass)arg;
		if(this.attribute==result.attribute)
			return 0;
		if(this.attribute>result.attribute){
			return 1;
		}else{
			return -1;
		}
	}
	
	private static testMethod void unitTest(){
		IComparableTestClass arg1 = new IComparableTestClass(1);
		IComparableTestClass arg2 = null;
		try{
		arg1.compareTo(arg2);
		}catch(Exception exp){
			System.assertEquals(exp instanceof IllegalArgumentException, true);
		}
		
		arg2 = new IComparableTestClass(2);
		System.assertEquals(arg1.compareTo(arg2)==-1,true);
		arg2 = new IComparableTestClass(1);
		System.assertEquals(arg1.compareTo(arg2)==0,true);
		arg2 = new IComparableTestClass(0);
		System.assertEquals(arg1.compareTo(arg2)==1,true);
	}
}