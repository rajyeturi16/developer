trigger SendConfirmationEmail on Session_Speaker__c (after insert) {
	//Collect the new email address from the inserted record
	List<Id> sessionSpeakerIds = new List<Id>();
    for(Session_Speaker__c newItem : trigger.new)
    {
        sessionSpeakerIds.add(newItem.Id);
    }
    
    //Retrieve session name from the session details
    List<Session_Speaker__c> sessionSpeakers = [SELECT Session__r.Name, 
                                              Session__r.Session_Date__c,
                    						  Speaker__r.First_Name__c,
                                              Speaker__r.Last_Name__c,
                                              Speaker__r.Email__c 
                                              from Session_Speaker__c where Id iN :SessionSpeakerIds];
    
    if(sessionSpeakers.size() > 0)
    {
     Session_Speaker__c sessionSpeaker = sessionSpeakers[0];
        
        if(sessionSpeaker.Speaker__r.Email__c != null){
            
            String Address = sessionSpeaker.Speaker__r.Email__c;
            String Subject = 'New Session is assigned to you';
            String body = 'Dear, '+ sessionSpeaker.Speaker__r.First_Name__c + ',\n Your Session "' + sessionSpeaker.session__r.Name + 'is confirmed . \n\n' + 'Thanks for speaking at the conference';
            EmailManager.sendMail(address, subject, body);
        }
    }
   
}