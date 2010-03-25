@IsTest
private class SoqlBuilderTest {
    
    private static testmethod void testNoObjectName(){
        Boolean exceptionCaught = false;
        try{
            new SoqlBuilder().toSoql();
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void testBasicSelect(){
        System.assertEquals(
            'SELECT id,name FROM account WHERE name like \'%acme%\'',
            new SoqlBuilder()
                .columns(new List<String>{'id','name'})
                .table('account')
                .condition(new FieldCondition('name',Operator.LIK,'%acme%'))
                .toSoql());   
    }

    private static testmethod void testNestedConditions(){
        System.assertEquals(
            'SELECT id,name FROM account WHERE ((name like \'%acme%\' OR description = \'yo\') AND ispartner = true) ORDER BY name desc LIMIT 500',
            new SoqlBuilder()
                .columns(new List<String>{'id','name'})
                .table('account')
                .condition(
                    new AndCondition()
                    .add(
                        new OrCondition()
                        .add(new FieldCondition('name',Operator.LIK,'%acme%'))
                        .add(new FieldCondition('description',Operator.EQUALS,'yo'))
                    )
                    .add(new FieldCondition('ispartner',Operator.EQUALS,true))
                ).order('name desc')
                .max(500)
                .toSoql());   
    }

}