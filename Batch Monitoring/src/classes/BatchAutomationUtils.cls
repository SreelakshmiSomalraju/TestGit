/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchAutomationUtils>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 8/10/2016
Last Modified By:Jothi
Last Modified Date:8/11/2016
Description: Utils Class for common query results 

################################################################################*/
public class BatchAutomationUtils
{
    public static List<BulkAPIJobBatches__c> getBatchStatuslist()
    {
        List<BulkAPIJobBatches__c> batchList = new List<BulkAPIJobBatches__c>();
        BulkAPIAuthenticationConfig__c auth = new BulkAPIAuthenticationConfig__c();
        auth = getAuthenticationDetails();
        DateTime sentDate = auth.LastProcessedTime__c;        
        String query;
        if(BulkJobsConfig__c.getvalues('BatchMonitor').Failure_Status__c == true)       
        query = 'SELECT id,Name,BulkAPIJob_ID__c,State__c,Created_Date__c,NumberOfRecordsProcessed__c,NumberOfRecordsFailed__c,BulkAPIJob_ID__r.Name,BulkAPIJob_ID__r.Object__c,BulkAPIJob_ID__r.Operation__c FROM BulkAPIJobBatches__c WHERE createddate >:sentDate and NumberOfRecordsFailed__c !='+'\''+ 0 +'\'';        
        else if(BulkJobsConfig__c.getvalues('BatchMonitor').Success_Status__c == True)
        query = 'SELECT id,Name,BulkAPIJob_ID__c,State__c,Created_Date__c,NumberOfRecordsProcessed__c,NumberOfRecordsFailed__c,BulkAPIJob_ID__r.Name,BulkAPIJob_ID__r.Object__c,BulkAPIJob_ID__r.Operation__c FROM BulkAPIJobBatches__c WHERE createddate >:sentDate and NumberOfRecordsFailed__c= '+'\''+ 0+'\'';       
        try
        {
            if(query !=  null)
            batchList = Database.Query(query);
        }
        Catch(Exception e)
        {
        }
        return batchList;
    }
    public static id getEmailTemplate(String Name)
    {        
        return [select id, name from EmailTemplate where developername =: Name].id;   
    }
    public static BulkAPIAuthenticationConfig__c getAuthenticationDetails()
    {
        BulkAPIAuthenticationConfig__c authenticationKeys = [select ConsumerKey__c,ConsumerSecret__c,Username__c,Password__c,LastProcessedTime__c,LastHourlyProcessedTime__c from BulkAPIAuthenticationConfig__c where name ='BatchMonitor'];  
        return authenticationKeys;
       
    }
   
}