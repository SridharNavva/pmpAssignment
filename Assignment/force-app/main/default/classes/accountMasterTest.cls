@isTest
private class accountMasterTest {
    @isTest static void accountContactTest() 
    {
        // Test data setup
        // Create an account with an contact
        Account acc = new Account(Name='Test Account', Phone='1234567890');
        insert acc;

        Contact con = new Contact(AccountId=acc.Id, LastName='Test LN', FirstName='Test FN', Phone='1234567890', OwnerId = Userinfo.getUserid());
        insert con;
    }
    
    @isTest static void emailTest()
    {
        User usr=[select id,name,email from user where id =:UserInfo.getUserId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     
        mail.setToAddresses(new string[] {usr.email});
        mail.setSubject('Test Mail');
        mail.setHtmlBody('Test Email Body'); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}