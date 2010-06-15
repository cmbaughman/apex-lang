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
private class LongRangeTest {
    
    private static testmethod void testContains(){
        assertContains(new LongRange(0),0,true);
        assertContains(new LongRange(-1,1),-2,false);
        assertContains(new LongRange(-1,1),-0,true);
        assertContains(new LongRange(-1,1),0,true);
        assertContains(new LongRange(-1,1),2,false);
    }
    
    private static void assertContains(LongRange range1, Long aNumber, Boolean expected){
        Boolean actual = range1.contains(aNumber);
        System.assert(actual==expected, 'LongRange(' + range1.toAString() 
            + ').contains(' + aNumber + ') returned ' + actual);
    }

    private static testmethod void testContainsRange(){
        assertContainsRange(new LongRange(0),new LongRange(0),true);
        assertContainsRange(new LongRange(0,1),new LongRange(0,1),true);
        assertContainsRange(new LongRange(1,2),new LongRange(4,5),false);
        assertContainsRange(new LongRange(1,2),new LongRange(2,5),false);
        assertContainsRange(new LongRange(1,2),new LongRange(1,2),true);
        assertContainsRange(new LongRange(1,2),new LongRange(2,2),true);
    }
    
    private static void assertContainsRange(LongRange range1, LongRange range2, Boolean expected){
        Boolean actual = range1.contains(range2);
        System.assert(actual==expected, 'LongRange(' + range1.toAString() 
            + ').contains(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testOverlaps(){
        assertOverlaps(new LongRange(0),new LongRange(0),true);
        assertOverlaps(new LongRange(-1,1),new LongRange(0,1),true);
        assertOverlaps(new LongRange(-1,1),new LongRange(2),false);
        assertOverlaps(new LongRange(-1,1),new LongRange(0,1),true);
        assertOverlaps(new LongRange(-1,1),new LongRange(-1,-0),true);
        assertOverlaps(new LongRange(-1,1),new LongRange(-2),false);
    }
    
    private static void assertOverlaps(LongRange range1, LongRange range2, Boolean expected){
        Boolean actual = range1.overlaps(range2);
        System.assert(actual==expected, 'LongRange(' + range1.toAString() 
            + ').overlaps(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testMin(){
        assertMin(new LongRange(0),0);
        assertMin(new LongRange(-1,1),-1);
        assertMin(new LongRange(1,-1),-1);
    }
    
    private static void assertMin(LongRange range1, Long expected){
        Long actual = range1.min();
        System.assert(actual==expected, 'LongRange(' + range1.toAString() 
            + ').getMinimum() returned ' + actual);
    }

    private static testmethod void testMax(){
        assertMax(new LongRange(0),0);
        assertMax(new LongRange(-1,1),1);
        assertMax(new LongRange(1,-1),1);
    }
    
    private static void assertMax(LongRange range1, Long expected){
        Long actual = range1.max();
        System.assert(actual==expected, 'LongRange(' + range1.toAString() 
            + ').getMaximum() returned ' + actual);
    }
    
    private static testmethod void testNullsConstructor1(){
        Boolean exceptionCaught = false;
        try{ new LongRange(null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new LongRange(null)\' did not throw IllegalArgumentException');
    }
    
    private static testmethod void testNullsConstructor2(){
        Boolean exceptionCaught = false;
        try{ new LongRange(null,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new LongRange(null,null)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new LongRange(null,0); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new LongRange(null,0)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new LongRange(0,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new LongRange(0,null)\' did not throw IllegalArgumentException');
    }
}