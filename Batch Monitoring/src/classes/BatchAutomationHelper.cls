/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchAutomationHelper>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 9/01/2016
Last Modified By: Jothi
Last Modified Date: 9/07/2016 - Removed custom settings values for lastemailsenttime,added custom object field update code for lastemailsenttime
Description: Helper Class for Batch Monitoring Automation 

################################################################################*/
public class BatchAutomationHelper
{   
    //Variable Declaration
    public static list<BulkAPIJobBatches__c> batchList;        
    public static string accessToken;
                  
    //This method is to invoke callout and get Batch Details as response 
    public static void getCalloutresponse(List<BulkAPIjob__c> bulkJobListNew)
    {   
        String endPoint = BulkJobsConfig__c.getvalues('BatchMonitor').EndPointURL__c;
        String apiVersion = BulkJobsConfig__c.getvalues('BatchMonitor').APIVersion__c;
        BatchAutomationAuthentication auth = new BatchAutomationAuthentication();
        accessToken = auth.getAccessToken();
        map<String,Id> bulkAPIJobs = new map<String,Id>();
        Set<String> jobIds = new Set<String>();
         
        for(BulkAPIjob__c job : bulkJobListNew)
        {
            jobIds.add(job.Name);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endPoint+apiVersion+'/job/' +job.Name+'/batch');
            request.setMethod('GET');
            request.setHeader('X-SFDC-Session',accessToken);       
            Http http = new Http();            
            HttpResponse response = new HttpResponse();              
            response = http.send(request);                        
            //Added code to handle APIVersion issue
            Integer statusCode = response.getStatusCode();              
            string responseXml = response.getBody();
            BatchAutomationXMLParser parse =  new BatchAutomationXMLParser();   
            if(statusCode == 400)  
            {
                apiVersion = parse.getAPIVersion(responseXml);      
                request.setEndpoint(endPoint+apiVersion+'/job/' +job.Name+'/batch');                             
                response = http.send(request); 
                statusCode = response.getStatusCode();
                if(statusCode == 200)
                {
                    responseXml = response.getBody();
                    system.debug('print batch response###'+responseXml);
                    batchList = parse.parseXML(responseXml,job.Name);
                }                
            }
            else
                batchList = parse.parseXML(responseXml,job.Name);
            
        }
        insert bulkJobListNew;
        for(BulkAPIJob__c b:[select Id,Name,Object__c,Operation__c from BulkAPIJob__c where Name in: jobids])
        {
            bulkAPIJobs.put(b.Name,b.id);
        }      
                        
               
        if(batchList.size()>0)
        {     
            for(BulkAPIJobBatches__c batch : batchList)
            {
                batch.BulkAPIJob_ID__c = bulkAPIJobs.get(batch.JobId__c);
            }
            insert batchList;
            list<BulkAPIJobBatches__c> batchStatusList = BatchAutomationUtils.getBatchStatuslist();             
            Id  templateId = BatchAutomationUtils.getEmailTemplate('Batch_Status_Notification');
            if(BulkJobsConfig__c.getvalues('BatchMonitor').Email_Notification__c == true)       
            {               
                                 
                Messaging.SingleEmailMessage Singlemail = new Messaging.SingleEmailMessage();
                Singlemail.setTargetObjectId(userInfo.getUserID());                      
                Singlemail.setTemplateId(templateId);                                                 
                Singlemail.setSaveAsActivity(false); 
                if(batchStatusList.size()>0)
                {              
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {Singlemail});                   
                    
                }
            }
        }
                    
        
                                                                           
    }
}