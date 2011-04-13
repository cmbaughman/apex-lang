/* ============================================================
 * Contributor: Caleb Sidel
 * 
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
private class EmailUtilsTest {

    static testMethod void testsendEmail_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        EmailUtils.sendTextEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
        EmailUtils.sendHTMLEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
    } 
    
    static testMethod void testsendEmailNoReceipients_test() {
        List<String> recepients=null;
        EmailUtils.sendTextEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
        
        recepients=new List<String>();
        EmailUtils.sendHTMLEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
    }
    
    static testMethod void testsendEmailWithAttachment_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        List<Attachment> stdAttachments = new List<Attachment>();
        Attachment a = new Attachment();
        a.Name = 'Test';
        a.Body = EncodingUtil.base64Decode('Test Body');
        stdAttachments.add(a);
        EmailUtils.sendEmailWithStandardAttachments(recepients,'Test method', 'This is to test the sendTextNotificationEmail method',false,stdAttachments);
    }
    
    static testMethod void testsendEmailWithAttachmentIDs_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        List<ID> stdAttachments = new List<ID>();
        
        Account acct = new Account(name='Test Account');
        insert acct;
        
        Attachment a = new Attachment();
        a.ParentId = acct.Id;
        a.Name = 'Test';
        a.Body = EncodingUtil.base64Decode('Test Body');
        insert a;
        stdAttachments.add(a.Id);
        EmailUtils.sendEmailWithStandardAttachments(recepients,'Test method', 'This is to test the sendTextNotificationEmail method',false,stdAttachments);
    }

    private static testmethod void testIsNotValidEmailAddress(){
        //test:  global static Boolean isNotValidEmailAddress(String str)
        System.assertEquals(true,EmailUtils.isNotValidEmailAddress(null));
        System.assertEquals(true,EmailUtils.isNotValidEmailAddress('  '));
        System.assertEquals(true,EmailUtils.isNotValidEmailAddress('x'));
        System.assertEquals(true,EmailUtils.isNotValidEmailAddress('x@'));
        System.assertEquals(true,EmailUtils.isNotValidEmailAddress('x@x'));
        System.assertEquals(false,EmailUtils.isNotValidEmailAddress('x@x.x'));
    }
    
    
}