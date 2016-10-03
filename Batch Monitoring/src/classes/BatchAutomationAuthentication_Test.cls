@isTest 
private class BatchAutomationAuthentication_Test
{ 
     static testMethod void testBatchAuthentication() {
        //test record insertion for BulkJobsConfig__c     
        BulkJobsConfig__c bulkJobConfig = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig;
        
        BulkAPIAuthenticationConfig__c authDetails = new BulkAPIAuthenticationConfig__c();
        authDetails = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert authDetails;
        
        Test.StartTest();
        BatchAutomationAuthentication batchAuthentication= new BatchAutomationAuthentication();      
        Test.setMock(HttpCalloutMock.class, new BatchAutomationOAuth_Mock());                      
        batchAuthentication.getAccessToken();                     
        Test.StopTest();                 
    }
}