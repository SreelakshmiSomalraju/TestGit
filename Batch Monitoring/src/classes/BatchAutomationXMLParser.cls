/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchAutomationXMLParser>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 9/01/2016
Last Modified By:
Last Modified Date:
Description:This class to parse Response XML. 
################################################################################*/

public class BatchAutomationXMLParser
{
    //Variable  Declaration
    public static list<BulkAPIJobBatches__c> batchList = new list<BulkAPIJobBatches__c>();      
    public static BulkAPIJobBatches__c batch;
    
    //This method is to parse response XML    
    public list<BulkAPIJobBatches__c> parseXML(string responseXml,string jobID)
    {
        DOM.Document xmlDOC = new DOM.Document();
        xmlDOC.load(responseXml);      
        DOM.XMLNode rootElement = xmlDOC.getRootElement();        
               
        for(DOM.XMLNode child:rootElement.getChildElements())      
        {             
            
            BulkAPIJobBatches__c b = loadChilds(child,jobId); 
            batchList.add(b);
               
        } 
        return batchList;
        
    }
    //Method to get APIVersion of the job
    public string getAPIVersion(string responseXml)
    {
        String nameSpace = BulkJobsConfig__c.getvalues('BatchMonitor').Namespace__c;       
        DOM.Document xmlDOC = new DOM.Document();
        xmlDOC.load(responseXml);      
        DOM.XMLNode rootElement = xmlDOC.getRootElement(); 
        string errorMessage = rootElement.getChildElement('exceptionMessage',nameSpace).gettext();            
        system.debug('print error message###'+errorMessage);
        string apiVersion;
        if(errorMessage != null)
        {
            errorMessage = errorMessage.trim();
            system.debug('###trimmed'+errorMessage.right(4));
            apiVersion = errorMessage.right(4);
        } 
        return apiVersion;        
    }
    // This method loads the child elements and Maps the corresponding fields
    public static BulkAPIJobBatches__c loadChilds(DOM.XMLNode xmlnode,String jobid)
    {                          
        BulkAPIJob__c job = new BulkAPIJob__c();
        String nameSpace = BulkJobsConfig__c.getvalues('BatchMonitor').Namespace__c;       
        batch = new BulkAPIJobBatches__c();      
        batch.JobId__c = jobid;
        batch.Name = xmlnode.getChildElement('id',nameSpace).gettext();
        batch.State__c= xmlnode.getChildElement('state',nameSpace).gettext();
        batch.Created_Date__c= xmlnode.getChildElement('createdDate',nameSpace).gettext();
        batch.NumberOfRecordsProcessed__c= xmlnode.getChildElement('numberRecordsProcessed',nameSpace).gettext();
        batch.NumberOfRecordsFailed__c= xmlnode.getChildElement('numberRecordsFailed',nameSpace).gettext();
        batch.SystemModstamp__c= xmlnode.getChildElement('systemModstamp',nameSpace).gettext();
        batch.TotalProcessingTime__c= xmlnode.getChildElement('totalProcessingTime',nameSpace).gettext();
        batch.APIActiveProcessingTime__c =xmlnode.getChildElement('apiActiveProcessingTime',nameSpace).gettext();
        batch.ApexProcessingTime__c=xmlnode.getChildElement('apexProcessingTime',nameSpace).gettext();                           
        return batch;
              
        
    }


}