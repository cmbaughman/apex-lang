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
private class IntegerRangeTest {
    
    private static testmethod void testContains(){
        assertContains(new IntegerRange(0),0,true);
        assertContains(new IntegerRange(-1,1),-2,false);
        assertContains(new IntegerRange(-1,1),-0,true);
        assertContains(new IntegerRange(-1,1),0,true);
        assertContains(new IntegerRange(-1,1),2,false);
    }
    
    private static void assertContains(IntegerRange range1, Integer aNumber, Boolean expected){
        Boolean actual = range1.contains(aNumber);
        System.assert(actual==expected, 'IntegerRange(' + range1.toAString() 
            + ').contains(' + aNumber + ') returned ' + actual);
    }

    private static testmethod void testContainsRange(){
        assertContainsRange(new IntegerRange(0),new IntegerRange(0),true);
        assertContainsRange(new IntegerRange(0,1),new IntegerRange(0,1),true);
        assertContainsRange(new IntegerRange(1,2),new IntegerRange(4,5),false);
        assertContainsRange(new IntegerRange(1,2),new IntegerRange(2,5),false);
        assertContainsRange(new IntegerRange(1,2),new IntegerRange(1,2),true);
        assertContainsRange(new IntegerRange(1,2),new IntegerRange(2,2),true);
    }
    
    private static void assertContainsRange(IntegerRange range1, IntegerRange range2, Boolean expected){
        Boolean actual = range1.contains(range2);
        System.assert(actual==expected, 'IntegerRange(' + range1.toAString() 
            + ').contains(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testOverlaps(){
        assertOverlaps(new IntegerRange(0),new IntegerRange(0),true);
        assertOverlaps(new IntegerRange(-1,1),new IntegerRange(0,1),true);
        assertOverlaps(new IntegerRange(-1,1),new IntegerRange(2),false);
        assertOverlaps(new IntegerRange(-1,1),new IntegerRange(0,1),true);
        assertOverlaps(new IntegerRange(-1,1),new IntegerRange(-1,-0),true);
        assertOverlaps(new IntegerRange(-1,1),new IntegerRange(-3,-2),false);
    }
    
    private static void assertOverlaps(IntegerRange range1, IntegerRange range2, Boolean expected){
        Boolean actual = range1.overlaps(range2);
        System.assert(actual==expected, 'IntegerRange(' + range1.toAString() 
            + ').overlaps(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testMin(){
        assertMin(new IntegerRange(0),0);
        assertMin(new IntegerRange(-1,1),-1);
        assertMin(new IntegerRange(1,-1),-1);
    }
    
    private static void assertMin(IntegerRange range1, Integer expected){
        Integer actual = range1.min();
        System.assert(actual==expected, 'IntegerRange(' + range1.toAString() 
            + ').getMinimum() returned ' + actual);
    }

    private static testmethod void testMax(){
        assertMax(new IntegerRange(0),0);
        assertMax(new IntegerRange(-1,1),1);
        assertMax(new IntegerRange(1,-1),1);
    }
    
    private static void assertMax(IntegerRange range1, Integer expected){
        Integer actual = range1.max();
        System.assert(actual==expected, 'IntegerRange(' + range1.toAString() 
            + ').getMaximum() returned ' + actual);
    }

    private static testmethod void testNullsConstructor1(){
        Boolean exceptionCaught = false;
        try{ new IntegerRange(null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new IntegerRange(null)\' did not throw IllegalArgumentException');
    }
    
    private static testmethod void testNullsConstructor2(){
        Boolean exceptionCaught = false;
        try{ new IntegerRange(null,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new IntegerRange(null,null)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new IntegerRange(null,0); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new IntegerRange(null,0)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new IntegerRange(0,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new IntegerRange(0,null)\' did not throw IllegalArgumentException');
    }
    
}