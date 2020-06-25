trigger accountMaster on Account (after update) {
    Schema.DescribeSObjectResult objSchema = Account.sObjectType.getDescribe();
    Set<String> fields = objSchema.fields.getMap().keySet();
    
    String accId,accOwner;
    
    String[] updatedFields  = new String[]{};
    for(Account acc: trigger.new){
        for(string s: fields){
            if(acc.get(s) != trigger.oldMap.get(acc.Id).get(s)){
                updatedFields.add(s + ' - old:' + trigger.oldMap.get(acc.Id).get(s) + ' new:' + acc.get(s));
            }
        }
        accId = acc.Id;
        accOwner = acc.ownerid;
    }
    
    User usr=[select name,id,email from user where id =:accOwner];
    //system.debug('-------------user------'+usr);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 
    //EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'notifyAccountOwner'];
    //mail.setTemplateId(et.id);

    //mail.setSenderDisplayName('Your Loving Administrator');
    //mail.setToAddresses(new string[]{UserInfo.getUserEmail()});
    mail.setToAddresses(new string[] {usr.email});
    //mail.setReplyTo(UserInfo.getUserEmail());
    mail.setSubject('Account updated');

    string htmlBody = '';

    if(updatedFields.size()>0){
        for (String s : updatedFields){
            htmlBody += '<div>' + s + '</div>';
        }
    }

    mail.setHtmlBody(htmlBody + 
    'To view your account <a href=https://cunning-koala-9i13xn-dev-ed.lightning.force.com/'+accId+'> click here </a>');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
}