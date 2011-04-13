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
private class DoubleRangeTest {
    
    private static testmethod void testContains(){
        assertContains(new DoubleRange(0),0,true);
        assertContains(new DoubleRange(-1,1),-1.1,false);
        assertContains(new DoubleRange(-1,1),-0.5,true);
        assertContains(new DoubleRange(-1,1),0,true);
        assertContains(new DoubleRange(-1,1),0.5,true);
        assertContains(new DoubleRange(-1,1),1.1,false);
    }
    
    private static void assertContains(DoubleRange range1, Double aNumber, Boolean expected){
        Boolean actual = range1.contains(aNumber);
        System.assert(actual==expected, 'DoubleRange(' + range1.toAString() 
            + ').contains(' + aNumber + ') returned ' + actual);
    }

    private static testmethod void testContainsRange(){
        assertContainsRange(new DoubleRange(0),new DoubleRange(0),true);
        assertContainsRange(new DoubleRange(0,1),new DoubleRange(0,1),true);
        assertContainsRange(new DoubleRange(1.5,2.5),new DoubleRange(4,5),false);
        assertContainsRange(new DoubleRange(1.5,2.5),new DoubleRange(2.5,5),false);
        assertContainsRange(new DoubleRange(1.5,2.5),new DoubleRange(1.5,2.5),true);
        assertContainsRange(new DoubleRange(1.5,2.5),new DoubleRange(2,2.1),true);
    }
    
    private static void assertContainsRange(DoubleRange range1, DoubleRange range2, Boolean expected){
        Boolean actual = range1.contains(range2);
        System.assert(actual==expected, 'DoubleRange(' + range1.toAString() 
            + ').contains(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testOverlaps(){
        assertOverlaps(new DoubleRange(0),new DoubleRange(0),true);
        assertOverlaps(new DoubleRange(-1,1),new DoubleRange(0,1),true);
        assertOverlaps(new DoubleRange(-1,1),new DoubleRange(1.1,1.5),false);
        assertOverlaps(new DoubleRange(-1,1),new DoubleRange(0.5,1.5),true);
        assertOverlaps(new DoubleRange(-1,1),new DoubleRange(-1.5,-0.5),true);
        assertOverlaps(new DoubleRange(-1,1),new DoubleRange(-1.5,-1.1),false);
    }
    
    private static void assertOverlaps(DoubleRange range1, DoubleRange range2, Boolean expected){
        Boolean actual = range1.overlaps(range2);
        System.assert(actual==expected, 'DoubleRange(' + range1.toAString() 
            + ').overlaps(' + (range2==null ? '' : range2.toAString()) + ') returned ' + actual);
    }

    private static testmethod void testMin(){
        assertMin(new DoubleRange(0),0);
        assertMin(new DoubleRange(-1.5,1.5),-1.5);
        assertMin(new DoubleRange(1.5,-1.5),-1.5);
    }
    
    private static void assertMin(DoubleRange range1, Double expected){
        Double actual = range1.min();
        System.assert(actual==expected, 'DoubleRange(' + range1.toAString() 
            + ').getMinimum() returned ' + actual);
    }

    private static testmethod void testMax(){
        assertMax(new DoubleRange(0),0);
        assertMax(new DoubleRange(-1.5,1.5),1.5);
        assertMax(new DoubleRange(1.5,-1.5),1.5);
    }
    
    private static void assertMax(DoubleRange range1, Double expected){
        Double actual = range1.max();
        System.assert(actual==expected, 'DoubleRange(' + range1.toAString() 
            + ').getMaximum() returned ' + actual);
    }

    private static testmethod void testNullsConstructor1(){
        Boolean exceptionCaught = false;
        try{ new DoubleRange(null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new DoubleRange(null)\' did not throw IllegalArgumentException');
    }
    
    private static testmethod void testNullsConstructor2(){
        Boolean exceptionCaught = false;
        try{ new DoubleRange(null,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new DoubleRange(null,null)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new DoubleRange(null,0); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new DoubleRange(null,0)\' did not throw IllegalArgumentException');
        
        exceptionCaught = false;
        try{ new DoubleRange(0,null); }catch(IllegalArgumentException e){ exceptionCaught = true; }
        System.assert(exceptionCaught,'Call to \'new DoubleRange(0,null)\' did not throw IllegalArgumentException');
    }
}