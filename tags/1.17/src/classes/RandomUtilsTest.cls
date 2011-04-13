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
global class RandomUtilsTest {

    private static testmethod void testNextBoolean(){
    	System.assertNotEquals(null,RandomUtils.nextBoolean());
    }

    private static testmethod void testNextInteger(){
        assertNextInteger(NumberUtils.MAX_INTEGER_RANGE,true,RandomUtils.nextInteger());
    }

    private static testmethod void testNextInteger_Integer(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            inputRange = new IntegerRange(0,Math.abs(i));
            assertNextInteger(inputRange,true,RandomUtils.nextInteger(i));
        }
    }

    private static testmethod void testNextInteger_Integer_Boolean(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            inputRange = new IntegerRange(0,Math.abs(i));
            assertNextInteger(inputRange,true,RandomUtils.nextInteger(i,true));
            assertNextInteger(inputRange,false,RandomUtils.nextInteger(i,false));
        }
    }

    private static testmethod void testNextInteger_Integer_Integer(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            for(Integer j = -2; j <= 2; j++){
                inputRange = new IntegerRange(i,j);
                assertNextInteger(inputRange,true,RandomUtils.nextInteger(i,j));
            }
        }
    }

    private static testmethod void testNextInteger_Integer_Integer_Boolean(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            for(Integer j = -2; j <= 2; j++){
                inputRange = new IntegerRange(i,j);
                assertNextInteger(inputRange,true,RandomUtils.nextInteger(i,j,true));
                assertNextInteger(inputRange,false,RandomUtils.nextInteger(i,j,false));
            }
        }
    }

    private static testmethod void testNextInteger_IntegerRange(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            for(Integer j = -2; j <= 2; j++){
                inputRange = new IntegerRange(i,j);
                assertNextInteger(inputRange,true,RandomUtils.nextInteger(inputRange));
            }
        }
    }

    private static testmethod void testNextInteger_IntegerRange_Boolean(){
        IntegerRange inputRange = null;
        for(Integer i = -2; i <= 2; i++){
            for(Integer j = -2; j <= 2; j++){
                inputRange = new IntegerRange(i,j);
                assertNextInteger(inputRange,true,RandomUtils.nextInteger(inputRange,true));
                assertNextInteger(inputRange,false,RandomUtils.nextInteger(inputRange,false));
            }
        }
    }

    private static testmethod void testNextInteger_IntegerRange_Boolean_NULL(){
    	final IntegerRange nullRange = null;
    	System.assertEquals(null,RandomUtils.nextInteger(nullRange,true));
    }

    private static void assertNextInteger(IntegerRange inputRange, Boolean inclusive, Integer actual){
        IntegerRange acceptableRange = null;
        if(!inclusive && (inputRange.max()-inputRange.min()) <= 2){
            acceptableRange = new IntegerRange(inputRange.min(),inputRange.min());
        } else {
            Integer inclusiveChange = 1;
            if(inclusive) inclusiveChange = 0;
        	acceptableRange = new IntegerRange(
        	   inputRange.min() - inclusiveChange
        	   ,inputRange.max() - inclusiveChange
        	);
        }
        System.assert(
            acceptableRange.contains(actual), 
            'RandomUtils.nextInteger(' + inputRange.toAString() + ',' + inclusive + ') returned ' + actual);
    }
    
    private static testmethod void testNextLong(){
        assertNextLong(NumberUtils.MAX_LONG_RANGE,true,RandomUtils.nextLong());
    }

    private static testmethod void testNextLong_Long(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            inputRange = new LongRange(0,Math.abs(i));
            assertNextLong(inputRange,true,RandomUtils.nextLong(i));
        }
    }

    private static testmethod void testNextLong_Long_Boolean(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            inputRange = new LongRange(0,Math.abs(i));
            assertNextLong(inputRange,true,RandomUtils.nextLong(i,true));
            assertNextLong(inputRange,false,RandomUtils.nextLong(i,false));
        }
    }

    private static testmethod void testNextLong_Long_Long(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            for(Long j = -2; j <= 2; j++){
                inputRange = new LongRange(i,j);
                assertNextLong(inputRange,true,RandomUtils.nextLong(i,j));
            }
        }
    }

    private static testmethod void testNextLong_Long_Long_Boolean(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            for(Long j = -2; j <= 2; j++){
                inputRange = new LongRange(i,j);
                assertNextLong(inputRange,true,RandomUtils.nextLong(i,j,true));
                assertNextLong(inputRange,false,RandomUtils.nextLong(i,j,false));
            }
        }
    }

    private static testmethod void testNextLong_LongRange(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            for(Long j = -2; j <= 2; j++){
                inputRange = new LongRange(i,j);
                assertNextLong(inputRange,true,RandomUtils.nextLong(inputRange));
            }
        }
    }

    private static testmethod void testNextLong_LongRange_Boolean(){
        LongRange inputRange = null;
        for(Long i = -2; i <= 2; i++){
            for(Long j = -2; j <= 2; j++){
                inputRange = new LongRange(i,j);
                assertNextLong(inputRange,true,RandomUtils.nextLong(inputRange,true));
                assertNextLong(inputRange,false,RandomUtils.nextLong(inputRange,false));
            }
        }
    }

    private static testmethod void testNextLong_LongRange_Boolean_NULL(){
        final LongRange nullRange = null;
        System.assertEquals(null,RandomUtils.nextLong(nullRange,true));
    }

    private static void assertNextLong(LongRange inputRange, Boolean inclusive, Long actual){
        LongRange acceptableRange = null;
        if(!inclusive && (inputRange.max()-inputRange.min()) <= 2){
            acceptableRange = new LongRange(inputRange.min(),inputRange.min());
        } else {
	        Integer inclusiveChange = 1;
	        if(inclusive) inclusiveChange = 0;
        	
            acceptableRange = new LongRange(
               inputRange.min() - inclusiveChange
               ,inputRange.max() - inclusiveChange
            );
        }
        System.assert(
            acceptableRange.contains(actual), 
            'RandomUtils.nextLong(' + inputRange.toAString() + ',' + inclusive + ') returned ' + actual);
    }    

}