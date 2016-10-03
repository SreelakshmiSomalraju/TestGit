/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchStatusController>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 9/01/2016
Last Modified By:
Last Modified Date:8/11/2016
Description: Class is used to get BatchStauslist from utils class 

################################################################################*/
public  class BatchStatusController
{     
    public String currentBaseURL{get;set;}
    public List<BulkAPIJobBatches__c> getBatchlist()
    {
        currentBaseURL = System.URL.getSalesforceBaseURL().getHost();
        List<BulkAPIJobBatches__c> batchList = BatchAutomationUtils.getBatchStatuslist(); 
        return batchList;
    }
}