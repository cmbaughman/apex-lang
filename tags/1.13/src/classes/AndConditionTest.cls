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