@isTest 
private class BatchAutomationUtils_Test
{ 
     static testMethod void testUtils() {
        //test record insertion for BulkJobsConfig__c  
        /*EmailTemplate t = BatchAutomation_DataFactory.createEmailTemplate('Batch Status');  
        insert t;
        BatchAutomationUtils.getEmailTemplate(t.developername);*/    
        list<BulkJobsConfig__c> configList = new list<BulkJobsConfig__c>();
        BulkJobsConfig__c bulkJobConfig1 = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig1; 
        BulkAPIAuthenticationConfig__c b = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert b;        
        BatchAutomationUtils.getBatchStatuslist();                  
        Test.StartTest();               
        BulkJobsConfig__c configjob =[select id,name,Success_Status__c,Failure_status__c from BulkJobsConfig__c where name ='BatchMonitor'];
        configjob.Success_Status__c = true;
        configjob.Failure_Status__c = False;
        update configjob; 
        BatchAutomationUtils.getBatchStatuslist();                   
        Test.StopTest();                 
    }
}