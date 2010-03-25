@IsTest
private class FieldConditionTest {
	

    private static testmethod void testCallToAdd(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',Operator.Equals,null).add(null);
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'call to FieldCondition.add() did not throw IllegalStateException');
    }

    private static testmethod void testInvalidField(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('  ',null,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'empty field param to FieldCondition constructor did not throw IllegalArgumentException');
    }

    private static testmethod void testInvalidOperator(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',null,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'null operator param to FieldCondition constructor did not throw IllegalArgumentException');
    }

    private static testmethod void testInvalidValue(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',new FieldCondition('test','test'));
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'invalid value param to FieldCondition constructor did not throw IllegalArgumentException');
    }

    private static testmethod void testNullValue(){
        System.assertEquals('name = null',new FieldCondition('name',Operator.EQUALS,null).toSoql());   
    }

    private static testmethod void testStringValue(){
        System.assertEquals('name = \'acme\'',new FieldCondition('name',Operator.EQUALS,'acme').toSoql());   
        System.assertEquals('name like \'%acme%\'',new FieldCondition('name',Operator.LIK,'%acme%').toSoql());   
    }

    private static testmethod void testBooleanValue(){
        System.assertEquals('ispartner = true',new FieldCondition('ispartner',Operator.EQUALS,true).toSoql());   
        System.assertEquals('ispartner = false',new FieldCondition('ispartner',Operator.EQUALS,false).toSoql());   
    }

    private static testmethod void testIntegerValue(){
        System.assertEquals('employees = 1',new FieldCondition('employees',Operator.EQUALS,1).toSoql());   
        System.assertEquals('employees != 1',new FieldCondition('employees',Operator.NOT_EQUALS,1).toSoql());   
        System.assertEquals('employees < 1',new FieldCondition('employees',Operator.LESS,1).toSoql());   
        System.assertEquals('employees > 1',new FieldCondition('employees',Operator.GREATER,1).toSoql());   
        System.assertEquals('employees <= 1',new FieldCondition('employees',Operator.LESS_OR_EQUAL,1).toSoql());   
        System.assertEquals('employees >= 1',new FieldCondition('employees',Operator.GREATER_OR_EQUAL,1).toSoql());   
    }

    private static testmethod void testDoubleValue(){
        System.assertEquals('employees = 1.1',new FieldCondition('employees',Operator.EQUALS,1.1).toSoql());   
        System.assertEquals('employees != 1.1',new FieldCondition('employees',Operator.NOT_EQUALS,1.1).toSoql());   
        System.assertEquals('employees < 1.1',new FieldCondition('employees',Operator.LESS,1.1).toSoql());   
        System.assertEquals('employees > 1.1',new FieldCondition('employees',Operator.GREATER,1.1).toSoql());   
        System.assertEquals('employees <= 1.1',new FieldCondition('employees',Operator.LESS_OR_EQUAL,1.1).toSoql());   
        System.assertEquals('employees >= 1.1',new FieldCondition('employees',Operator.GREATER_OR_EQUAL,1.1).toSoql());   
    }

    private static testmethod void testDateValue(){
        System.assertEquals('createddate < 1960-02-17',new FieldCondition('createddate',Operator.LESS,Date.newinstance(1960, 2, 17)).toSoql());   
    }

    private static testmethod void testDatetimeValue(){
        System.assertEquals('createddate >= 2008-12-01T12:00:00Z',new FieldCondition('createddate',Operator.GREATER_OR_EQUAL,Datetime.newInstance(2008, 12, 1)).toSoql());   
    }

}