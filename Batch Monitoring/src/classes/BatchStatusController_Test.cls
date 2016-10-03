@isTest 
private class BatchStatusController_Test
{ 
     static testMethod void testBatchStatus() {
        //test record insertion for BulkJobsConfig__c     
        list<BulkJobsConfig__c> configList = new list<BulkJobsConfig__c>();
        BulkJobsConfig__c bulkJobConfig1 = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig1;  
        BulkAPIAuthenticationConfig__c b = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert b;           
        Test.StartTest();
        BatchAutomationUtils.getBatchStatuslist();
        BulkJobsConfig__c configjob =[select id,name,Success_Status__c,Failure_status__c from BulkJobsConfig__c where name ='BatchMonitor'];
        configjob.Success_Status__c = true;
        configjob.Failure_Status__c = False;
        update configjob;
        BatchStatusController batchStatus = new BatchStatusController();
        batchStatus.getBatchlist();
        Test.StopTest();                 
    }
}