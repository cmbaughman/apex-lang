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
private class SelectOptionComparatorTest {

    private static testmethod void testSortOnLabelDescending(){
        SelectOptionWrapper o1 = new SelectOptionWrapper(new SelectOption('xyz','abc'));
        SelectOptionWrapper o2 = new SelectOptionWrapper(new SelectOption('uvw','def'));
        SelectOptionComparator comp = new SelectOptionComparator();
        System.assertEquals(true,comp.sortDescending);
        System.assertEquals(false,comp.sortAscending);
        System.assertEquals(true,comp.sortOnLabel);
        System.assertEquals(false,comp.sortOnValue);
        
        System.assertEquals(-1,comp.compare(o1,o2));
        System.assertEquals(1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));

        comp = new SelectOptionComparator(true);
        System.assertEquals(-1,comp.compare(o1,o2));
        System.assertEquals(1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));

        comp = new SelectOptionComparator(true,true);
        System.assertEquals(-1,comp.compare(o1,o2));
        System.assertEquals(1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));
    }
    
    private static testmethod void testSortOnValueDescending(){
        SelectOptionWrapper o1 = new SelectOptionWrapper(new SelectOption('xyz','abc'));
        SelectOptionWrapper o2 = new SelectOptionWrapper(new SelectOption('uvw','def'));
        SelectOptionComparator comp = new SelectOptionComparator(true,false);
        System.assertEquals(1,comp.compare(o1,o2));
        System.assertEquals(-1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));
    }
    
    private static testmethod void testSortOnValueAscending(){
        SelectOptionWrapper o1 = new SelectOptionWrapper(new SelectOption('xyz','abc'));
        SelectOptionWrapper o2 = new SelectOptionWrapper(new SelectOption('uvw','def'));
        SelectOptionComparator comp = new SelectOptionComparator(false,false);
        System.assertEquals(-1,comp.compare(o1,o2));
        System.assertEquals(1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));
    }
    
    private static testmethod void testSortOnLabelAscending(){
        SelectOptionWrapper o1 = new SelectOptionWrapper(new SelectOption('xyz','abc'));
        SelectOptionWrapper o2 = new SelectOptionWrapper(new SelectOption('uvw','def'));
        SelectOptionComparator comp = new SelectOptionComparator(false,true);
        System.assertEquals(1,comp.compare(o1,o2));
        System.assertEquals(-1,comp.compare(o2,o1));
        System.assertEquals(0,comp.compare(o1,o1));
        System.assertEquals(0,comp.compare(o2,o2));
    }
    
    private static testmethod void testNulls(){
        SelectOptionWrapper o1 = new SelectOptionWrapper(new SelectOption('xyz','abc'));
        
        SelectOptionComparator comp = new SelectOptionComparator(true,true);
        System.assertEquals(-1,comp.compare(null,o1));
        System.assertEquals(1,comp.compare(o1,null));

        comp = new SelectOptionComparator(false,true);
        System.assertEquals(1,comp.compare(null,o1));
        System.assertEquals(-1,comp.compare(o1,null));
    }
    
    private static testmethod void testInvalidType(){
        Boolean exceptionCaught = false;
        try{
        	(new SelectOptionComparator()).compare(1,1);
        }catch(IllegalArgumentException e){
        	exceptionCaught = true;
        }
        System.assert(exceptionCaught==true,'IllegalArgumentException was not thrown');
    }
    
    private static testmethod void testSortDescendingOnLabel(){
    	List<SelectOption> theList = new List<SelectOption>{
    		new SelectOption('XXXXX','ghi')
    		,new SelectOption('XXXXX','jkl')
    		,new SelectOption('XXXXX','abc')
    		,new SelectOption('XXXXX','def')
    	};
    	theList = SelectOptionComparator.sort(theList);
    	System.assertNotEquals(null,theList);
    	System.assertNotEquals(null,theList.get(0));
    	System.assertNotEquals(null,theList.get(1));
    	System.assertNotEquals(null,theList.get(2));
    	System.assertNotEquals(null,theList.get(3));
    	System.assertEquals('abc',theList.get(0).getLabel());
    	System.assertEquals('def',theList.get(1).getLabel());
    	System.assertEquals('ghi',theList.get(2).getLabel());
    	System.assertEquals('jkl',theList.get(3).getLabel());
    }
    
    private static testmethod void testSortAscendingOnLabel(){
    	List<SelectOption> theList = new List<SelectOption>{
    		new SelectOption('XXXXX','ghi')
    		,new SelectOption('XXXXX','jkl')
    		,new SelectOption('XXXXX','abc')
    		,new SelectOption('XXXXX','def')
    	};
    	theList = SelectOptionComparator.sort(theList,false,true);
    	System.assertNotEquals(null,theList);
    	System.assertNotEquals(null,theList.get(0));
    	System.assertNotEquals(null,theList.get(1));
    	System.assertNotEquals(null,theList.get(2));
    	System.assertNotEquals(null,theList.get(3));
    	System.assertEquals('abc',theList.get(3).getLabel());
    	System.assertEquals('def',theList.get(2).getLabel());
    	System.assertEquals('ghi',theList.get(1).getLabel());
    	System.assertEquals('jkl',theList.get(0).getLabel());
    }

    private static testmethod void testSortDescendingOnValue(){
    	List<SelectOption> theList = new List<SelectOption>{
    		new SelectOption('ghi','XXXXX')
    		,new SelectOption('abc','XXXXX')
    		,new SelectOption('jkl','XXXXX')
    		,new SelectOption('def','XXXXX')
    	};
    	theList = SelectOptionComparator.sort(theList,true,false);
    	System.assertNotEquals(null,theList);
    	System.assertNotEquals(null,theList.get(0));
    	System.assertNotEquals(null,theList.get(1));
    	System.assertNotEquals(null,theList.get(2));
    	System.assertNotEquals(null,theList.get(3));
    	System.assertEquals('abc',theList.get(0).getValue());
    	System.assertEquals('def',theList.get(1).getValue());
    	System.assertEquals('ghi',theList.get(2).getValue());
    	System.assertEquals('jkl',theList.get(3).getValue());
    }
    
    private static testmethod void testSortAscendingOnValue(){
    	List<SelectOption> theList = new List<SelectOption>{
    		new SelectOption('ghi','XXXXX')
    		,new SelectOption('abc','XXXXX')
    		,new SelectOption('jkl','XXXXX')
    		,new SelectOption('def','XXXXX')
    	};
    	theList = SelectOptionComparator.sort(theList,false,false);
    	System.assertNotEquals(null,theList);
    	System.assertNotEquals(null,theList.get(0));
    	System.assertNotEquals(null,theList.get(1));
    	System.assertNotEquals(null,theList.get(2));
    	System.assertNotEquals(null,theList.get(3));
    	System.assertEquals('abc',theList.get(3).getValue());
    	System.assertEquals('def',theList.get(2).getValue());
    	System.assertEquals('ghi',theList.get(1).getValue());
    	System.assertEquals('jkl',theList.get(0).getValue());
    }
    
    

}