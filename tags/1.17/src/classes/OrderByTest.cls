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
private class OrderByTest {

    private static testmethod void testNullFieldName(){
        assertIllegalArgumentThrown(null);
    }

    private static testmethod void testBlankFieldName(){
        assertIllegalArgumentThrown(' ');
    }

    private static void assertIllegalArgumentThrown(final String name){
        Boolean exceptionCaught = false;
        try{
            new OrderBy(name);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void testNameOnly(){
        final OrderBy orderBy = new OrderBy('name');
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals('name',orderBy.toSoql());
    }

    private static testmethod void testAscendingNullsLast(){
        OrderBy orderBy = new OrderBy('name').ascending().nullsLast();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals('name ASC NULLS LAST',orderBy.toSoql());

        orderBy = new OrderBy('name').nullsLast().ascending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals('name ASC NULLS LAST',orderBy.toSoql());
    }

    private static testmethod void testDescendingNullsFirst(){
        OrderBy orderBy = new OrderBy('name').descending().nullsFirst();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.descending);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.ascending);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals('name DESC NULLS FIRST',orderBy.toSoql());

        orderBy = new OrderBy('name').nullsFirst().descending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.descending);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.ascending);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals('name DESC NULLS FIRST',orderBy.toSoql());
    }

    private static testmethod void testAscendingNullsFirst(){
        OrderBy orderBy = new OrderBy('name').ascending().nullsFirst();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals('name ASC NULLS FIRST',orderBy.toSoql());

        orderBy = new OrderBy('name').nullsFirst().ascending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals('name ASC NULLS FIRST',orderBy.toSoql());
    }

    private static testmethod void testDescendingNullsLast(){
        OrderBy orderBy = new OrderBy('name').descending().nullsLast();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.descending);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.ascending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals('name DESC NULLS LAST',orderBy.toSoql());

        orderBy = new OrderBy('name').nullsLast().descending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.descending);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.ascending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals('name DESC NULLS LAST',orderBy.toSoql());
    }


    private static testmethod void testAscending(){
        OrderBy orderBy = new OrderBy('name').ascending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals('name ASC',orderBy.toSoql());
    }

    private static testmethod void testDescending(){
        final OrderBy orderBy = new OrderBy('name').descending();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.descending);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.ascending);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals('name DESC',orderBy.toSoql());
    }

    private static testmethod void testNullsFirst(){
        final OrderBy orderBy = new OrderBy('name').nullsFirst();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(true,orderBy.nullsFirst);
        System.assertEquals(false,orderBy.nullsLast);
        System.assertEquals('name NULLS FIRST',orderBy.toSoql());
    }

    private static testmethod void testNullsLast(){
        final OrderBy orderBy = new OrderBy('name').nullsLast();
        System.assertNotEquals(null,orderBy);
        System.assertEquals(true,orderBy.ascending);
        System.assertEquals(false,orderBy.descending);
        System.assertEquals(false,orderBy.nullsFirst);
        System.assertEquals(true,orderBy.nullsLast);
        System.assertEquals('name NULLS LAST',orderBy.toSoql());
    }


}