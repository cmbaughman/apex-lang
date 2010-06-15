@IsTest
private class ConditionGroupTest {
    
    private static testmethod void testNesting(){
        System.assertEquals(
            '((name = \'acme\' AND ispartner = true) OR rating = \'Hot\')',
            new OrCondition()
                .add(new AndCondition()
                    .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
                    .add(new FieldCondition('ispartner',Operator.EQUALS,true)))
                .add(new FieldCondition('rating',Operator.EQUALS,'Hot'))
                .toSoql()
        );   
    }

}