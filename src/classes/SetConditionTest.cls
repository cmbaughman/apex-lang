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
private class SetConditionTest {
    
    private static testmethod void testInvalidField(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('  ');
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'empty field param to FieldCondition constructor did not throw IllegalArgumentException');
    }

    private static testmethod void testInvalidOperator_EQUALS(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('x',Operator.EQUALS,new List<Object>{1,2});
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValue_List(){
        Boolean exceptionCaught = false;
        List<Object> value = null;
        try{
            new SetCondition('x',Operator.INCLUDES,value);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValue_SoqlBuilder(){
        Boolean exceptionCaught = false;
        SoqlBuilder value = null;
        try{
            new SetCondition('x',Operator.NOT_IN,value);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testEmptyValue(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('x',Operator.INCLUDES,new List<Object>{});
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNameNotDefined(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition().toSoql();   
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void testOperationNotDefined(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('name').toSoql();   
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void testInvalidValue(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('name').includes(new List<Object>{new DecimalRange(0,1)}).toSoql();   
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValuesList(){
        Boolean exceptionCaught = false;
        List<Object> value = null;
        try{
            new SetCondition('name').includes(value);   
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testEmptyValuesList(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('name').includes(new List<Object>());   
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testIncludes(){
        asertEqualsAfterRemovingNewLines(
            'name INCLUDES (\'test\',123)',
            new SetCondition('name').includes(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testExcludes(){
        asertEqualsAfterRemovingNewLines(
            'name EXCLUDES (\'test\',123)',
            new SetCondition('name').excludes(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testIn(){
        asertEqualsAfterRemovingNewLines(
            'name IN (\'test\',123)',
            new SetCondition('name').inx(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testNotIn(){
        asertEqualsAfterRemovingNewLines(
            'name NOT IN (\'test\',123)',
            new SetCondition('name').notIn(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testOperatorMethod_includes(){
        asertEqualsAfterRemovingNewLines('x INCLUDES (1,2)',new SetCondition().field('x').includes(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x INCLUDES (1,2)',new SetCondition('x').includes(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x INCLUDES (1,2)',new SetCondition('x',Operator.INCLUDES,new List<Object>{1,2}).toSoql());   
    }

    private static testmethod void testOperatorMethod_excludes(){
        asertEqualsAfterRemovingNewLines('x EXCLUDES (1,2)',new SetCondition().field('x').excludes(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x EXCLUDES (1,2)',new SetCondition('x').excludes(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x EXCLUDES (1,2)',new SetCondition('x',Operator.excludes,new List<Object>{1,2}).toSoql());   
    }

    private static testmethod void testOperatorMethod_inx(){
        asertEqualsAfterRemovingNewLines('x IN (1,2)',new SetCondition().field('x').inx(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x IN (1,2)',new SetCondition('x').inx(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x IN (1,2)',new SetCondition('x',Operator.INX,new List<Object>{1,2}).toSoql());   
    }

    private static testmethod void testOperatorMethod_notIn(){
        asertEqualsAfterRemovingNewLines('x NOT IN (1,2)',new SetCondition().field('x').notIn(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x NOT IN (1,2)',new SetCondition('x').notIn(new List<Object>{1,2}).toSoql());   
        asertEqualsAfterRemovingNewLines('x NOT IN (1,2)',new SetCondition('x',Operator.NOT_IN,new List<Object>{1,2}).toSoql());   
    }


    private static testmethod void testBasicSemiJoin_Constructor(){
        asertEqualsAfterRemovingNewLines('ID IN (SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SetCondition('ID', Operator.INX, 
                new SoqlBuilder().selectx('AccountId').fromx('Opportunity').wherex(new FieldCondition('StageName','Closed Lost'))
            ).toSoql());   
    }
    
    private static testmethod void testBasicSemiJoin_1(){
        asertEqualsAfterRemovingNewLines('ID IN (SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SetCondition('ID').inx(
                new SoqlBuilder().selectx('AccountId').fromx('Opportunity').wherex(new FieldCondition('StageName','Closed Lost'))
            ).toSoql());   
    }

    private static testmethod void testBasicSemiJoin_2(){
        asertEqualsAfterRemovingNewLines('ID NOT IN (SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SetCondition('ID').notIn(
                new SoqlBuilder().selectx('AccountId').fromx('Opportunity').wherex(new FieldCondition('StageName','Closed Lost'))
            ).toSoql());   
    }

    private static testmethod void testBasicSemiJoin_3(){
        asertEqualsAfterRemovingNewLines('ID INCLUDES (SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SetCondition('ID').includes(
                new SoqlBuilder().selectx('AccountId').fromx('Opportunity').wherex(new FieldCondition('StageName','Closed Lost'))
            ).toSoql());   
    }

    private static testmethod void testBasicSemiJoin_4(){
        asertEqualsAfterRemovingNewLines('ID EXCLUDES (SELECT AccountId FROM Opportunity WHERE StageName = \'Closed Lost\')',
            new SetCondition('ID').excludes(
                new SoqlBuilder().selectx('AccountId').fromx('Opportunity').wherex(new FieldCondition('StageName','Closed Lost'))
            ).toSoql());   
    }
    
    private static void asertEqualsAfterRemovingNewLines(String expected, String actual){
        System.assertEquals(StringUtils.replace(expected, '\n', ''),StringUtils.replace(actual, '\n', ''));   
    }
    
    


}