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
@IsTest
private class TestDecimalRangeComparator {

	private static testmethod void testIllegalArgumentExceptionThrown(){
		IObjectComparator drc = new DecimalRangeComparator();
		Boolean exceptionThrown = false;
		try{
			drc.compare(null,null);
		}catch(IllegalArgumentException e){
			exceptionThrown = true;
		}
		System.assert(exceptionThrown);
	}

	private static testmethod void testCompare(){
		IObject r1 = new DecimalRange(1,2);
		IObject r2 = new DecimalRange(1.5,1.7);
		IObjectComparator drc = new DecimalRangeComparator();
		System.assertEquals(-1,drc.compare(r1,r2));
		System.assertEquals(0,drc.compare(r1,r1));
		System.assertEquals(1,drc.compare(r2,r1));
	}

}