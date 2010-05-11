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