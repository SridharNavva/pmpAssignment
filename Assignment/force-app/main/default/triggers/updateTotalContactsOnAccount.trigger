trigger updateTotalContactsOnAccount on Contact (before insert,before update,before delete) {
    Set <Id> accountIds = new Set <Id>();
    List <Account> lstAccountsToUpdate = new List <Account>();
    
    if(Trigger.isInsert){
        for(Contact con:trigger.new){
            accountIds.add(con.accountID);
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Contact con:trigger.old){
            accountIds.add(con.accountID);
        }
    }

    for(Account acc:[SELECT Id,Name,Total_Contacts__c,(Select Id from Contacts) from Account where Id IN: accountIds]){
        Account accObj = new Account ();
        accObj.Id = acc.Id;
        accObj.Total_Contacts__c = acc.Contacts.size();
        lstAccountsToUpdate.add(accObj);
    }

    UPDATE lstAccountsToUpdate;
}