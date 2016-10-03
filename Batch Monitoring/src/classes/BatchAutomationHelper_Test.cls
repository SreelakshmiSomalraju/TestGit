@isTest
public class BatchAutomationHelper_Test
{     
    
    //test method to cover callout reponse
    static testmethod void checkResponse()
    {
        //test record insertion for BulkAPIJob__c
        list<BulkAPIJob__c> bulkJobList = new list<BulkAPIJob__c>();       
        BulkAPIJob__c bulkJob1 = BatchAutomation_DataFactory.createBulkJob('75090000003oP3R');
        bulkJobList.add(bulkJob1);       
        //test record insertion for BulkJobsConfig__c
        BulkJobsConfig__c bulkJobConfig = BatchAutomation_DataFactory.createConfigRecord();
        insert bulkJobConfig;
        BulkAPIAuthenticationConfig__c authDetails = new BulkAPIAuthenticationConfig__c();
        authDetails = BatchAutomation_DataFactory.createAuthenticationRecord('BatchMonitor');
        insert authDetails;
        
        Test.StartTest();             
        Test.setMock(HttpCalloutMock.class, new BatchAutomationOAuth_Mock());
        Test.setMock(HttpCalloutMock.class, new BatchAutomationGetJob_Mock());                
        BatchAutomationHelper.getCalloutresponse(bulkJobList);                     
        Test.StopTest();              
                        
    }
}