@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the AccountId from the end of the URL
        String AccountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT id,name,(select id,name from contacts)
                        FROM Account
                        WHERE Id = :AccountId];
        return result;
    }
}