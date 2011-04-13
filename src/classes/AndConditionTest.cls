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
private class AndConditionTest {
    
    private static testmethod void testAndConditionEmpty(){
        System.assertEquals('',new AndCondition().toSoql());   
    }

    private static testmethod void testNestedAndConditionEmpty(){
        System.assertEquals('',new AndCondition().add(new AndCondition()).add(new AndCondition()).toSoql());   
    }

    private static testmethod void testAndConditionWithOneConditionOnly(){
        System.assertEquals(
            'name = \'acme\'',
            new AndCondition()
                .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
                .toSoql());   
    }

    private static testmethod void testTwoFieldConditions(){
        System.assertEquals(
            '(name = \'acme\' AND ispartner = true)',
            new AndCondition()
                .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
                .add(new FieldCondition('ispartner',Operator.EQUALS,true))
                .toSoql()
        );   
    }

}