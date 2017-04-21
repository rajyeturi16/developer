public class ContactAura {
@AuraEnabled
    Public static List<Contact> get10Contacts() {
        return [SELECT Id,NAME from Contact limit 10];        
    }
}