@isTest 
private class BulkMonitorJob_Test
{   
    static testMethod void testMonitorJob() {
        //test record insertion for BulkAPIJob__c
        BulkAPIJob__c bulkJob =BatchAutomation_DataFactory.createBulkJob('75090000003oP3S');
        insert bulkJob;
        //test record insertion for BulkJobsConfig__c
        BulkJobsConfig__c bulkJobConfig = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig;
        BulkAPIAuthenticationConfig__c authDetails = new BulkAPIAuthenticationConfig__c();
        authDetails = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert authDetails;
        
        Test.StartTest();
        BulkMonitorJob bulkMonitor = new BulkMonitorJob();      
        Test.setMock(HttpCalloutMock.class, new BatchAutomationOAuth_Mock());
        Test.setMock(HttpCalloutMock.class, new BatchAutomationGetJob_Mock());                
        bulkMonitor.getBulkJobContent();                     
        Test.StopTest();                 
    }
}