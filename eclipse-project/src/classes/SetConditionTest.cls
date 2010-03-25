@IsTest
private class SetConditionTest {
    
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
            new SetCondition('name').includes(new List<Object>{new SetCondition()});   
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNullValuesList(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition('name').includes(null);   
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
        System.assertEquals(
            'name includes (\'test\',123)',
            new SetCondition('name').includes(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testExcludes(){
        System.assertEquals(
            'name excludes (\'test\',123)',
            new SetCondition('name').excludes(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testIn(){
        System.assertEquals(
            'name in (\'test\',123)',
            new SetCondition('name').inn(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testNotIn(){
        System.assertEquals(
            'name not in (\'test\',123)',
            new SetCondition('name').notIn(new List<Object>{'test',123}).toSoql());   
    }

    private static testmethod void testCallToAdd(){
        Boolean exceptionCaught = false;
        try{
            new SetCondition().add(null);
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(
            exceptionCaught == true, 
            'call to SetCondition.add() did not throw IllegalStateException');
    }


}