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
private class SoqlBuilderTest {

    private static testmethod void testLimit(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account LIMIT 1000',
            new SoqlBuilder().selectx('id').fromx('account').limitx(1000).toSoql());   
    }

    private static testmethod void testNoObjectName(){
        Boolean exceptionCaught = false;
        try{
            new SoqlBuilder().toSoql();
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void testBadField1(){
        Boolean exceptionCaught = false;
        try{
            String aNull = null;
            new SoqlBuilder().selectx(aNull);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testBadField2(){
        Boolean exceptionCaught = false;
        try{
            List<Object> anObjectList = new List<Object>{new DecimalRange(0,1)};
            new SoqlBuilder().selectx(anObjectList);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testBasicSelect(){
        SoqlUtils.assertEquals(
            'SELECT id,name FROM account WHERE name like \'%acme%\'',
            new SoqlBuilder()
                .selectx(new List<String>{'id','name'})
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'%acme%'))
                .toSoql());   
    }

    private static testmethod void testBasicSelectStringListSelectx(){
        SoqlUtils.assertEquals(
            'SELECT id,name FROM account WHERE name like \'%acme%\'',
            new SoqlBuilder()
                .selectx(new List<String>{'id','name'})
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'%acme%'))
                .toSoql());   
    }

    private static testmethod void testOption_wildcardStringsInLikeOperators(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account WHERE name like \'%acme%\'',
            new SoqlBuilder()
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'acme'))
                .toSoql(new SoqlOptions().wildcardStringsInLikeOperators()));   
    }

    private static testmethod void testOption_wildcardStringsInLikeOperatorsAlreadyWildcarded(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account WHERE name like \'%acme%\'',
            new SoqlBuilder()
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'%acme%'))
                .toSoql(new SoqlOptions().wildcardStringsInLikeOperators()));   
    }

    private static testmethod void testOption_doNotWildcardStringsInLikeOperators(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account WHERE name like \'acme\'',
            new SoqlBuilder()
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'acme'))
                .toSoql(new SoqlOptions().doNotWildcardStringsInLikeOperators()));   
    }

    private static testmethod void testOption_escapeSingleQuotes(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account WHERE name like \'Bill\\\'s Chop Shop\'',
            new SoqlBuilder()
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'Bill\'s Chop Shop'))
                .toSoql(new SoqlOptions().escapeSingleQuotes()));   
    }

    private static testmethod void testOption_doNotEscapeSingleQuotes(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account WHERE name like \'Bill\'s Chop Shop\'',
            new SoqlBuilder()
                .fromx('account')
                .wherex(new FieldCondition('name',Operator.LIKEX,'Bill\'s Chop Shop'))
                .toSoql(new SoqlOptions().doNotEscapeSingleQuotes()));   
    }

    private static testmethod void testNestedConditions(){
        SoqlUtils.assertEquals(
            'SELECT id,name FROM account WHERE ((name like \'%acme%\' OR description = \'yo\') AND ispartner = true) ORDER BY name DESC LIMIT 500',
            new SoqlBuilder()
                .selectx(new List<String>{'id','name'})
                .fromx('account')
                .wherex(
                    new AndCondition()
                    .add(
                        new OrCondition()
                        .add(new FieldCondition('name',Operator.LIKEX,'%acme%'))
                        .add(new FieldCondition('description',Operator.EQUALS,'yo'))
                    )
                    .add(new FieldCondition('ispartner',Operator.EQUALS,true))
                ).orderByx(new OrderBy('name').descending())
                .limitx(500)
                .toSoql());   
    }

    private static testmethod void testOrderBy1(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account ORDER BY name',
            new SoqlBuilder()
                .fromx('account')
                .orderByx(new List<OrderBy>{new OrderBy('name')})
                .toSoql());   
    }

    private static testmethod void testOrderBy2(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account ORDER BY name ASC NULLS LAST, rating DESC, industry DESC NULLS FIRST',
            new SoqlBuilder()
                .fromx('account')
                .orderByx(new List<OrderBy>{
                    new OrderBy('name').ascending().nullsLast()
                    ,new OrderBy('rating').descending()
                    ,new OrderBy('industry').descending().nullsFirst()})
                .toSoql());   
    }

    private static testmethod void testANullOrderBy(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account ORDER BY name',
            new SoqlBuilder()
                .fromx('account')
                .orderByx(new List<OrderBy>{
                    new OrderBy('name')
                    ,null})
                .toSoql());   
    }


    private static testmethod void testGroupBy(){
        SoqlUtils.assertEquals(
            'SELECT id FROM account GROUP BY name',
            new SoqlBuilder()
                .fromx('account')
                .groupByx('name')
                .toSoql());   
    }

    private static testmethod void testParentToChildQuery1(){
        SoqlUtils.assertEquals(
            'SELECT ID, Name, toLabel(Rating), (SELECT FirstName, LastName FROM Contacts) FROM Account',
            new SoqlBuilder()
                .selectx('ID')
                .selectx('Name')
                .selectx(new Field('Rating').toLabelx())
                .selectx(
                    new SoqlBuilder()
                    .selectx('FirstName')
                    .selectx('LastName')
                    .fromx('Contacts'))
                .fromx('Account')
                .toSoql());   
    }

    private static testmethod void testParentToChildQuery2(){
        SoqlUtils.assertEquals(
            'SELECT    ID, Name,    toLabel(Rating), (SELECT FirstName, LastName FROM Contacts) FROM Account',
            new SoqlBuilder()
                .selectx(new List<Object>
                    {
                        'ID'
                        ,'Name'
                        ,new Field('Rating').toLabelx()
                        ,new SoqlBuilder()
                            .selectx('FirstName')
                            .selectx('LastName')
                            .fromx('Contacts')
                    }
                )
                .fromx('Account')
                .toSoql());   
    }

    private static testmethod void testSelectCount1(){
        SoqlUtils.assertEquals(
            'SELECT count() from Contact c, c.Account a WHERE a.name = \'MyriadPubs\'',
            new SoqlBuilder()
                .selectCount()
                .fromx('Contact c, c.Account a')
                .wherex(new FieldCondition('a.name','MyriadPubs'))
                .toSoql());   
    }

    private static testmethod void testSelectCount2(){
        SoqlUtils.assertEquals(
            'SELECT count() FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectCount()
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());   
    }


    private static testmethod void testSelectCountWithArg(){
        SoqlUtils.assertEquals(
            'SELECT count(Id) FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectCount('Id')
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());     
    }  

    private static testmethod void testSelectAverage(){
        SoqlUtils.assertEquals(
            'SELECT AVG(Amount) FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectAveragex('Amount')
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());     
    }    


    private static testmethod void testSelectMax(){  
        SoqlUtils.assertEquals(
            'SELECT Max(Amount) FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectMaxx('Amount')
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());     
    }  

    private static testmethod void testSelectMin(){
        SoqlUtils.assertEquals(
            'SELECT Min(Amount) FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectMinx('Amount')
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());     
    }  

    private static testmethod void testSelectSumx(){
        SoqlUtils.assertEquals(
            'SELECT Sum(Amount) FROM Account WHERE Name LIKE \'a%\'',
            new SoqlBuilder()
                .selectSumx('Amount')
                .fromx('Account')
                .wherex(new FieldCondition('Name',Operator.LIKEX,'a%'))
                .toSoql());     
    }  


    private static testmethod void testSelectNullCondition(){
        SoqlUtils.assertEquals(
            'SELECT Id FROM Case WHERE Contact.Lastname = null',
            new SoqlBuilder()
                .fromx('Case')
                .wherex(new FieldCondition('Contact.Lastname',null))
                .toSoql());   
    }

    private static testmethod void testIncludes(){
        SoqlUtils.assertEquals(
            'SELECT Id, MSP1__c from CustObj__c WHERE MSP1__c INCLUDES (\'AAA;BBB\',\'CCC\')',
            new SoqlBuilder()
                .selectx(new List<String>{'id','MSP1__c'})
                .fromx('CustObj__c')
                .wherex(new SetCondition('MSP1__c').includes(new List<String>{'AAA;BBB','CCC'}))
                .toSoql());   
    }

    private static testmethod void testExcludes(){
        SoqlUtils.assertEquals(
            'SELECT Id, MSP1__c from CustObj__c WHERE MSP1__c EXCLUDES (\'AAA;BBB\',\'CCC\')',
            new SoqlBuilder()
                .selectx(new List<String>{'id','MSP1__c'})
                .fromx('CustObj__c')
                .wherex(new SetCondition('MSP1__c').excludes(new List<String>{'AAA;BBB','CCC'}))
                .toSoql());   
    }

    private static testmethod void testIn(){
        SoqlUtils.assertEquals(
            'SELECT id FROM ACCOUNT WHERE BillingState IN (\'California\',\'New York\')',
            new SoqlBuilder()
                .fromx('ACCOUNT')
                .wherex(new SetCondition('BillingState').inx(new List<String>{'California','New York'}))
                .toSoql());   
    }

    private static testmethod void testNotIn(){
        SoqlUtils.assertEquals(
            'SELECT id FROM ACCOUNT WHERE BillingState NOT IN (\'California\',\'New York\')',
            new SoqlBuilder()
                .fromx('ACCOUNT')
                .wherex(new SetCondition('BillingState').notIn(new List<String>{'California','New York'}))
                .toSoql());   
    }

    private static testmethod void testDateFormula_NEXT_N_FISCAL_QUARTERS(){
        SoqlUtils.assertEquals(
            'SELECT Id FROM Account WHERE CreatedDate < NEXT_N_FISCAL_QUARTERS:6',
            new SoqlBuilder()
                .fromx('Account')
                .wherex(new FieldCondition('CreatedDate', Operator.LESS_THAN, new DateFormula().next(6,UnitOfTime.FiscalQuarter)))
                .toSoql());
    }

    private static testmethod void testDateFormula_TOMORROW(){
        SoqlUtils.assertEquals(
            'SELECT Id FROM Opportunity WHERE CloseDate = TOMORROW',
            new SoqlBuilder()
                .fromx('Opportunity')
                .wherex(new FieldCondition('CloseDate', new DateFormula().tomorrowx()))
                .toSoql());
    }

    private static testmethod void test_EQUALS_1(){
        SoqlUtils.assertEquals(
            'SELECT name,employees FROM account WHERE employees = 10',
            new SoqlBuilder()
                .selectx('name')
                .selectx(new Set<Object>{'employees'})
                .fromx('account')
                .wherex(new FieldCondition('employees', 10))
                .toSoql());
    }

    private static testmethod void test_EQUALS_1_SetString(){
        SoqlUtils.assertEquals(
            'SELECT name,employees FROM account WHERE employees = 10',
            new SoqlBuilder()
                .selectx('name')
                .selectx(new Set<String>{'employees'})
                .fromx('account')
                .wherex(new FieldCondition('employees', 10))
                .toSoql());
    }

    private static testmethod void test_EQUALS_2(){
        SoqlUtils.assertEquals(
            'SELECT name,employees FROM account WHERE employees = 10',
            new SoqlBuilder()
                .selectx('name')
                .selectx('employees')
                .fromx('account')
                .wherex(new FieldCondition('employees').equals(10))
                .toSoql());
    }

    private static testmethod void test_EQUALS_3(){
        SoqlUtils.assertEquals(
            'SELECT name,employees FROM account WHERE employees = 10',
            new SoqlBuilder()
                .selectx(new Set<Object>{'name','employees'})
                .fromx('account')
                .wherex(new FieldCondition().field('employees').equals(10))
                .toSoql());
    }

    private static testmethod void test_EQUALS_3_SetString(){
        SoqlUtils.assertEquals(
            'SELECT name,employees FROM account WHERE employees = 10',
            new SoqlBuilder()
                .selectx(new Set<String>{'name','employees'})
                .fromx('account')
                .wherex(new FieldCondition().field('employees').equals(10))
                .toSoql());
    }

    private static testmethod void test_INX_1(){
        SoqlUtils.assertEquals(
            'SELECT id,industry FROM account WHERE industry in (\'Agriculture\',\'Apparel\')',
            new SoqlBuilder()
                .selectx(new List<Object>{'industry','id'})
                .fromx('account')
                .wherex(new SetCondition('industry', Operator.INX, new List<Object>{'Agriculture','Apparel'}))
                .toSoql());
    }

    private static testmethod void test_INX_1_ListString(){
        SoqlUtils.assertEquals(
            'SELECT id,industry FROM account WHERE industry in (\'Agriculture\',\'Apparel\')',
            new SoqlBuilder()
                .selectx(new List<String>{'industry','id'})
                .fromx('account')
                .wherex(new SetCondition('industry', Operator.INX, new List<Object>{'Agriculture','Apparel'}))
                .toSoql());
    }

    private static testmethod void test_INX_2(){
        SoqlUtils.assertEquals(
            'SELECT id,industry FROM account WHERE industry in (\'Agriculture\',\'Apparel\')',
            new SoqlBuilder()
                .selectx(new List<Object>{'industry','id'})
                .fromx('account')
                .wherex(new SetCondition('industry').inx(new List<Object>{'Agriculture','Apparel'}))
                .toSoql());
    }

    private static testmethod void test_INX_3(){
        SoqlUtils.assertEquals(
            'SELECT id,industry FROM account WHERE industry in (\'Agriculture\',\'Apparel\')',
            new SoqlBuilder()
                .selectx(new List<Object>{'industry','id'})
                .fromx('account')
                .wherex(new SetCondition().field('industry').inx(new List<Object>{'Agriculture','Apparel'}))
                .toSoql());
    }

    private static testmethod void testBasicSemiJoin(){
        SoqlUtils.assertEquals(
            'SELECT id FROM Account WHERE ID IN '
            +'(SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SoqlBuilder()
                .fromx('Account')
                .wherex(new SetCondition('ID').inx(
                    new SoqlBuilder()
                    .selectx('AccountId')
                    .fromx('Opportunity')
                    .wherex(new FieldCondition('StageName','Closed Lost'))))
                .toSoql());
    }

    private static testmethod void testDuplicateFields(){
        SoqlUtils.assertEquals(
            'SELECT name FROM Account',
            new SoqlBuilder()
                .selectx('name')
                .selectx(new Field('name'))
                .fromx('Account')
                .toSoql());
    }

    private static testmethod void testSelectAll_ApexClass(){
    	final String actualSoql = 
            new SoqlBuilder()
                .selectAll()
                .fromx('ApexClass')
                .toSoql();
        Set<String> fieldsActual = SetUtils.listToSet(ArrayUtils.lowerCase(ArrayUtils.trim(StringUtils.split(StringUtils.substringAfter(StringUtils.substringBefore(actualSoql, ' FROM'), 'SELECT '),','))));
        System.assertNotEquals(null,fieldsActual);
        final Set<String> fieldsExpected = new Set<String>{'id','createdbyid','body','name'};
        for(String fieldExpected : fieldsExpected){
            System.assert(fieldsActual.contains(fieldExpected), 'expected soql to contain column ' + fieldExpected + ': ' + actualSoql);
        }
        final String fromObjectNameActual = StringUtils.substringAfter(actualSoql, 'FROM ');
        System.assertEquals('ApexClass',fromObjectNameActual);
    }



}