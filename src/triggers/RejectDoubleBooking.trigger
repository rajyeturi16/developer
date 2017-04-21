trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {

    // Collect id's to reduce the data calls
    List<Id> speakerIds = new List<Id>();
    Map<Id, DateTime> requested_bookings = new Map<Id, DateTime>();
    
    // Get all speakers related to trigger
    // set booking map with ids to fill later
    for(Session_Speaker__c newItem : trigger.new){
        requested_bookings.put(newItem.Session__c,Null);
        speakerIds.add(newItem.Speaker__c);
    }
    
    //fill out the start date/time for the related sessions
    List<Session__c> related_sessions = [SELECT Session_Date__c from Session__c where Id IN : requested_bookings.keySet() ];
    
   // update map with id and datetime
    for(Session__c related_session : related_sessions)
    {
        requested_bookings.put(related_session.Id, related_session.Session_Date__c);
    }
   // get related speaker sessions to check agianst
   List<Session_Speaker__c> related_speakers = [SELECT Id, Speaker__c, Session__c, session__r.Session_Date__c from Session_Speaker__c where Speaker__c IN :speakerIds];
   
   // Check the list against each other
    for(Session_Speaker__c requested_session_speaker : trigger.new){
        DateTime booking_Time = requested_bookings.get(requested_session_speaker.Session__c);
        for(Session_Speaker__c related_speaker : related_speakers)
        {
            if(related_speaker.Speaker__c == requested_session_speaker.speaker__c && related_speaker.session__r.Session_Date__c == booking_Time)
            {
                requested_session_speaker.addError('The speaker is already booked at that time');
            }
        }
    }
}