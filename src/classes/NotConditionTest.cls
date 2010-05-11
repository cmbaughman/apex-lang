@IsTest
private class NotConditionTest {
    
    private static testmethod void testNot1(){
        System.assertEquals(
            'NOT(((name = \'acme\' AND ispartner = true) OR rating = \'Hot\'))',
            new NotCondition()
                .add(
	                new OrCondition()
	                .add(new AndCondition()
	                    .add(new FieldCondition('name ',Operator.EQUALS,'acme'))
	                    .add(new FieldCondition('ispartner',Operator.EQUALS,true)))
	                .add(new FieldCondition('rating',Operator.EQUALS,'Hot')))
                .toSoql()
        );   
    }

}