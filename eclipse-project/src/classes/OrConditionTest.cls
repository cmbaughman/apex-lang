@IsTest
private class OrConditionTest {
    
    private static testmethod void testOrConditionEmpty(){
        System.assertEquals('',new OrCondition().toSoql());   
    }

    private static testmethod void testNestedOrConditionEmpty(){
        System.assertEquals('',new OrCondition().add(new OrCondition()).add(new OrCondition()).toSoql());   
    }

    private static testmethod void testOrConditionWithOneConditionOnly(){
        System.assertEquals(
            'name = \'acme\'',
            new OrCondition()
                .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
                .toSoql());   
    }

    private static testmethod void testTwoFieldConditions(){
        System.assertEquals(
            '(name = \'acme\' OR ispartner = true)',
            new OrCondition()
                .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
                .add(new FieldCondition('ispartner',Operator.EQUALS,true))
                .toSoql()
        );   
    }

}