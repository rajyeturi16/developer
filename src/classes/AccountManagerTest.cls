@IsTest
private class AccountManagerTest {

    @isTest static void testGetAccountById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ap2.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccountById();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('TestAccount rest record', thisAccount.Name);
    }   
     // Helper method
    static Id createTestRecord() {
        // Create test record
        Account AccountTest = new Account(
            Name='TestAccount rest record'
           );
        insert AccountTest;
        return AccountTest.Id;
    }      
}