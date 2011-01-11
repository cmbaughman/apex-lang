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
private class FieldConditionTest {

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

    private static testmethod void testInvalidOperator_INCLUDES(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',Operator.INCLUDES,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testInvalidOperator_EXCLUDES(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',Operator.EXCLUDES,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testInvalidOperator_INX(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',Operator.INX,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testInvalidOperator_NOT_IN(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',Operator.NOT_IN,null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testInvalidValue(){
        Boolean exceptionCaught = false;
        try{
            new FieldCondition('x',new DecimalRange(0,1)).toSoql();
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValue(){
        System.assertEquals('name = null',new FieldCondition('name',Operator.EQUALS,null).toSoql());   
    }

    private static testmethod void testStringValue(){
        System.assertEquals('name = \'acme\'',new FieldCondition().field('name').equals('acme').toSoql());   
        System.assertEquals('name = \'acme\'',new FieldCondition('name').equals('acme').toSoql());   
        System.assertEquals('name = \'acme\'',new FieldCondition('name',Operator.EQUALS,'acme').toSoql());   
        System.assertEquals('name like \'%acme%\'',new FieldCondition().field('name').likex('%acme%').toSoql());   
        System.assertEquals('name like \'%acme%\'',new FieldCondition('name').likex('%acme%').toSoql());   
        System.assertEquals('name like \'%acme%\'',new FieldCondition('name',Operator.LIKEX,'%acme%').toSoql());   
    }

    private static testmethod void testBooleanValue(){
        System.assertEquals('ispartner = true',new FieldCondition('ispartner',Operator.EQUALS,true).toSoql());   
        System.assertEquals('ispartner = false',new FieldCondition('ispartner',Operator.EQUALS,false).toSoql());   
    }

    private static testmethod void testIntegerValue(){
        System.assertEquals('employees = 1',new FieldCondition('employees',Operator.EQUALS,1).toSoql());   
        System.assertEquals('employees != 1',new FieldCondition('employees',Operator.NOT_EQUALS,1).toSoql());   
        System.assertEquals('employees < 1',new FieldCondition('employees',Operator.LESS_THAN,1).toSoql());   
        System.assertEquals('employees > 1',new FieldCondition('employees',Operator.GREATER_THAN ,1).toSoql());   
        System.assertEquals('employees <= 1',new FieldCondition('employees',Operator.LESS_THAN_OR_EQUAL_TO,1).toSoql());   
        System.assertEquals('employees >= 1',new FieldCondition('employees',Operator.GREATER_THAN_OR_EQUAL_TO,1).toSoql());   
    }

    private static testmethod void testDoubleValue(){
        System.assertEquals('employees = 1.1',new FieldCondition('employees',Operator.EQUALS,1.1).toSoql());   
        System.assertEquals('employees != 1.1',new FieldCondition('employees',Operator.NOT_EQUALS,1.1).toSoql());   
        System.assertEquals('employees < 1.1',new FieldCondition('employees',Operator.LESS_THAN,1.1).toSoql());   
        System.assertEquals('employees > 1.1',new FieldCondition('employees',Operator.GREATER_THAN ,1.1).toSoql());   
        System.assertEquals('employees <= 1.1',new FieldCondition('employees',Operator.LESS_THAN_OR_EQUAL_TO,1.1).toSoql());   
        System.assertEquals('employees >= 1.1',new FieldCondition('employees',Operator.GREATER_THAN_OR_EQUAL_TO,1.1).toSoql());   
    }

    private static testmethod void testDateValue(){
        System.assertEquals('createddate < 1960-02-17',new FieldCondition('createddate',Operator.LESS_THAN,Date.newinstance(1960, 2, 17)).toSoql());   
    }

    private static testmethod void testDatetimeValue(){
        System.assertEquals('createddate >= 2008-12-01T12:00:00Z',new FieldCondition('createddate',Operator.GREATER_THAN_OR_EQUAL_TO,Datetime.newInstance(2008, 12, 1)).toSoql());   
    }

    private static testmethod void testOperatorMethod_equals(){
        System.assertEquals('x = 1',new FieldCondition().field('x').equals(1).toSoql());   
        System.assertEquals('x = 1',new FieldCondition('x').equals(1).toSoql());   
        System.assertEquals('x = 1',new FieldCondition('x',Operator.EQUALS,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_notEquals(){
        System.assertEquals('x != 1',new FieldCondition().field('x').notEquals(1).toSoql());   
        System.assertEquals('x != 1',new FieldCondition('x').notEquals(1).toSoql());   
        System.assertEquals('x != 1',new FieldCondition('x',Operator.NOT_EQUALS,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_lessThan(){
    	System.assertEquals('x < 1',new FieldCondition().field('x').lessThan(1).toSoql());   
        System.assertEquals('x < 1',new FieldCondition('x').lessThan(1).toSoql());   
        System.assertEquals('x < 1',new FieldCondition('x',Operator.LESS_THAN,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_lessThanOrEqualTo(){
        System.assertEquals('x <= 1',new FieldCondition().field('x').lessThanOrEqualTo(1).toSoql());   
        System.assertEquals('x <= 1',new FieldCondition('x').lessThanOrEqualTo(1).toSoql());   
        System.assertEquals('x <= 1',new FieldCondition('x',Operator.LESS_THAN_OR_EQUAL_TO,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_greaterThan(){
        System.assertEquals('x > 1',new FieldCondition().field('x').greaterThan(1).toSoql());   
        System.assertEquals('x > 1',new FieldCondition('x').greaterThan(1).toSoql());   
        System.assertEquals('x > 1',new FieldCondition('x',Operator.GREATER_THAN,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_greaterThanOrEqualTo(){
        System.assertEquals('x >= 1',new FieldCondition().field('x').greaterThanOrEqualTo(1).toSoql());   
        System.assertEquals('x >= 1',new FieldCondition('x').greaterThanOrEqualTo(1).toSoql());   
        System.assertEquals('x >= 1',new FieldCondition('x',Operator.GREATER_THAN_OR_EQUAL_TO,1).toSoql());   
    }

    private static testmethod void testOperatorMethod_likex(){
        System.assertEquals('x like \'acme\'',new FieldCondition().field('x').likex('acme').toSoql());   
        System.assertEquals('x like \'acme\'',new FieldCondition('x').likex('acme').toSoql());   
        System.assertEquals('x like \'acme\'',new FieldCondition('x',Operator.LIKEX,'acme').toSoql());   

        System.assertEquals('x like \'%acme%\'',new FieldCondition().field('x').likex('acme').toSoql(new SoqlOptions().wildcardStringsInLikeOperators()));   
        System.assertEquals('x like \'%acme%\'',new FieldCondition('x').likex('acme').toSoql(new SoqlOptions().wildcardStringsInLikeOperators()));   
        System.assertEquals('x like \'%acme%\'',new FieldCondition('x',Operator.LIKEX,'acme').toSoql(new SoqlOptions().wildcardStringsInLikeOperators()));   
    }

}