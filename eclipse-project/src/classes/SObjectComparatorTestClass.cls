global class SObjectComparatorTestClass implements SObjectComparator {
	global Integer compare(SObject record1, SObject record2){
		if(record1==null || !(record1 instanceof Account) ||
		   record2==null || !(record2 instanceof Account))
			throw new IllegalArgumentException();
		Account acc1=(Account)record1;
		Account acc2=(Account)record2;
		return acc1.Name.compareTo(acc2.Name);
	}
	
	private static testMethod void unitTest(){
		Account acc1 = new Account(name='test1');
		Account acc2 = null;
		SObjectComparatorTestClass comparator = new SObjectComparatorTestClass();
		try{
		comparator.compare(acc1, acc2);
		}catch(Exception exp){
			System.assertEquals(exp instanceof IllegalArgumentException, true);
		}
		
		acc2 = new Account(name='test2');
		System.assertEquals(comparator.compare(acc1, acc2)<0,true);
	}
}