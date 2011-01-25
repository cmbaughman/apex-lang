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
private class FieldTest {
    
    private static testmethod void testName(){
        Field field = new Field('test');
        System.assertNotEquals(null,field);
        System.assertEquals('test',field.toSoql());
    }

    private static testmethod void testToLabel(){
        Field field = new Field('test').toLabelx();
        System.assertNotEquals(null,field);
        System.assertEquals('toLabel(test)',field.toSoql());
    }


}