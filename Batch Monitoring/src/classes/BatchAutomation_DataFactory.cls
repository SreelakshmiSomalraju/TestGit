@isTest
public class BatchAutomation_DataFactory
{
    public static BulkAPIJob__c createBulkJob(String name)
    {
        BulkAPIJob__c bulkJob = new BulkAPIJob__c();    
        bulkJob.Name = name;
        //bulkJob.status__c= Status;
        return bulkJob;
    }
    public static BulkAPIJobBatches__c createBulkJobBatches(String jobId,String BatchId)
    {
        BulkAPIJobBatches__c batch = new BulkAPIJobBatches__c();    
        batch.Name = BatchId;
        batch.BulkAPIJob_ID__c = jobId;
        batch.NumberOfRecordsFailed__c = '12';
        //bulkJob.status__c= Status;
        return batch;
    }
    public static BulkJobsConfig__c createConfigRecord()
    {
        BulkJobsConfig__c bulkJobConfig = new BulkJobsConfig__c();
        bulkJobConfig.name = 'BatchMonitor';
        bulkJobConfig.BulkAPIJobURL__c = 'https://ap2.salesforce.com/750';       
        bulkJobConfig.AuthenticationURL__c ='https://login.salesforce.com/services/oauth2/token';
        bulkJobConfig.SendToAddress__c='test@gmail.com;test1@yahoo.com';
        bulkJobConfig.Namespace__c='http://www.force.com/2009/06/asyncapi/dataload';
        bulkJobConfig.Email_Notification__c = true;
        bulkJobConfig.Success_Status__c = False;
        bulkJobConfig.Failure_Status__c = true;  
        bulkJobConfig.SendToAddress__c  = '0054C000000YJotQAG';           
        return bulkJobConfig;
    }
    public static BulkAPIAuthenticationConfig__c createAuthenticationRecord(string name)
    {
        BulkAPIAuthenticationConfig__c auth = new BulkAPIAuthenticationConfig__c();
        auth.Name = name;      
        auth.consumerKey__c ='3MVG9AJuBE3rTYDhjPN.ghgfjhgjhjhj';
        auth.ConsumerSecret__c = '25657568678678546';
        auth.USERNAME__c = 'sampleUsername.toyota.com.amsinfy';
        auth.password__c ='dummypassword';        
        auth.LastProcessedTime__c = System.Now()-2;
        auth.LastHourlyProcessedTime__c = DateTime.Now()-2;
        return auth;
        
    }
    public static emailtemplate createEmailTemplate(string name)
    {
        emailtemplate temp = new emailtemplate();
        temp.Name = name;
        return temp;
    }
    
}