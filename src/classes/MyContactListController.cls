public class MyContactListController {
@AuraEnabled
public static List<Contact> getContacts() {
    return [Select Id, Name, Email, Title, Phone From Contact limit 10];
}
@AuraEnabled
public static List<Account> getAccounts(){
    return [select id,name from Account];    
    }
}