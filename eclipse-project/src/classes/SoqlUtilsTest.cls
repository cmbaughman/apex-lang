@IsTest
private class SoqlUtilsTest {
    
    private static testmethod void testInvalidValue(){
        Boolean exceptionCaught = false;
        try{
            SoqlUtils.primitiveToSoqlLiteral(new FieldCondition('test','test'));
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValue(){
        System.assertEquals('null',SoqlUtils.primitiveToSoqlLiteral(null));   
    }

    private static testmethod void testStringValue(){
        System.assertEquals('\'acme\'',SoqlUtils.primitiveToSoqlLiteral('acme'));   
    }

    private static testmethod void testBooleanValue(){
        System.assertEquals('true',SoqlUtils.primitiveToSoqlLiteral(true));   
        System.assertEquals('false',SoqlUtils.primitiveToSoqlLiteral(false));   
    }

    private static testmethod void testIntegerValue(){
        Integer i = 1;
        System.assertEquals('1',SoqlUtils.primitiveToSoqlLiteral(i));   
    }

    private static testmethod void testLongValue(){
        Long l = 1;
        System.assertEquals('1',SoqlUtils.primitiveToSoqlLiteral(l));   
    }

    private static testmethod void testDoubleValue(){
        Double d = 1.1;
        System.assertEquals('1.1',SoqlUtils.primitiveToSoqlLiteral(d));   
    }

    private static testmethod void testDecimalValue(){
        Decimal d = 1.1;
        System.assertEquals('1.1',SoqlUtils.primitiveToSoqlLiteral(d));   
    }

    private static testmethod void testDateValue(){
        System.assertEquals('1960-02-17',SoqlUtils.primitiveToSoqlLiteral(Date.newinstance(1960, 2, 17)));   
    }

    private static testmethod void testDatetimeValue(){
        System.assertEquals('2008-12-01T12:00:00Z',SoqlUtils.primitiveToSoqlLiteral(Datetime.newInstance(2008, 12, 1)));   
    }
    
    private static testmethod void testPrimitivesToSoqlLiterals(){
    	final List<Object> values = new List<Object>{1,'test123',1.1,true,null};
    	final List<String> literals = SoqlUtils.primitivesToSoqlLiterals(values);
        System.assertEquals('1',literals.get(0));
        System.assertEquals('\'test123\'',literals.get(1));
        System.assertEquals('1.1',literals.get(2));
        System.assertEquals('true',literals.get(3));
        System.assertEquals('null',literals.get(4));
    }

    private static testmethod void testEquals_1(){
        System.assertEquals(false,SoqlUtils.equals(
           'select id from account',
           'SELECT id FROM contact'
        ));
    }

    private static testmethod void testEquals_2(){
        System.assertEquals(true,SoqlUtils.equals(
           'select id from account',
           'SELECT id FROM account'
        ));
    }

    private static testmethod void testEquals_3(){
        System.assertEquals(false,SoqlUtils.equals(
           'select id,name from account',
           'SELECT id FROM account'
        ));
    }

    private static testmethod void testEquals_4(){
        System.assertEquals(true,SoqlUtils.equals(
           '  select    ispartner,rating,id, name    from   account  ',
           ' SELECT  name,rating,  ispartner,id  FROM   account   '
        ));
    }

    private static testmethod void testEquals_5(){
        System.assertEquals(false,SoqlUtils.equals(
           'xxx',
           ' SELECT  name,rating,  ispartner,id  FROM   account   '
        ));
    }

    private static testmethod void testAssertEquals(){
        SoqlUtils.assertEquals(
           'select id,name from account',
           'SELECT id,name FROM account'
        );
    }

}