@isTest
private class BatchAutomationCallout_Test
{
    static testmethod void testCallout()
    {
        //test record insertion for BulkAPIJob__c
        list<BulkAPIJob__c> bulkJobList = new list<BulkAPIJob__c>();
        Set<String> bulkJobIDs = new Set<String>();
        BulkAPIJob__c bulkJob1 = BatchAutomation_DataFactory.createBulkJob('75090000003oP3R');
        bulkJobList.add(bulkJob1);
        BulkAPIJob__c bulkJob2 = BatchAutomation_DataFactory.createBulkJob('75090000003oP3Q');
        bulkJobList.add(bulkJob2);
        insert bulkJobList;        
        //test record insertion for BulkJobsConfig__c
        BulkJobsConfig__c bulkJobConfig = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig;
        BulkAPIAuthenticationConfig__c authDetails = new BulkAPIAuthenticationConfig__c();
        authDetails = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert authDetails;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BatchAutomationOAuth_Mock());
        Test.setMock(HttpCalloutMock.class, new BatchAutomationGetJob_Mock());  
        Iterable<string> IS;
        Database.Batchablecontext BC;
        list<string> values = new list<string>{'Do','Done'}; 
        BatchAutomationCallout b = new BatchAutomationCallout();
        IS = b.start(BC);
        b.execute(BC,values);
        b.finish(BC);
        Test.stopTest();
    }
}