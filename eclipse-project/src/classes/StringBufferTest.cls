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
private class StringBufferTest {
    
    private static testmethod void testDecimal(){
        Decimal value = 3.14159;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testDouble(){
        Double value = 3.14159;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testInteger(){
        Integer value = 792392;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testLong(){
        Long value = 792392;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testID(){
        Account acct = new Account(name='test');
        insert acct;
        Id value = acct.id;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testBoolean(){
        Boolean value = true;
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(!value).toStr(), ''+value+''+value+''+(!value));
    }

    private static testmethod void testString(){
        String value = 'rwkrfkdekf';
        System.assertEquals((new StringBuffer()).append(value).toStr(), ''+value);
        System.assertEquals((new StringBuffer()).append(value).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }
 
    private static testmethod void testDate(){
        Date value = date.newinstance(1960, 2, 17);
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testDatetime(){
        Datetime value = datetime.newInstance(2008, 12, 1);
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testTime(){
        Time value = Time.newInstance(18, 30, 2, 20);
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

    private static testmethod void testBlob(){
        Blob value = Blob.valueOf('test123');
        System.assertEquals((new StringBuffer(value)).append(value).toStr(), ''+value+''+value);
        System.assertEquals((new StringBuffer(value)).append(value).append(value).toStr(), ''+value+''+value+''+value);
    }

}