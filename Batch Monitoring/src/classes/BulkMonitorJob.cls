/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BulkMonitorJob>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 9/1/2016
Last Modified By: 
Last Modified Date:
Description:This class is to parse Bulk data monitor job page. 
################################################################################*/

public class  BulkMonitorJob
{
    // Variable Declaration  
    private string bulkJobValues;
    private list<BulkAPIJob__c> bulkJobList;
    private set<String> oldBulkJobIDs = new set<String>();              
    private PageReference bulkJobPage;
    private DateTime startTime;
      
    //Method to get JobIDs from standard Monitor Bulk Data Load Jobs.
    public void getBulkJobContent()
    {
        startTime = System.Now();
        bulkJobPage = new PageReference(BulkJobsConfig__c.getvalues('BatchMonitor').BulkAPIJobURL__c);
        bulkJobList = [select id,name,status__c from BulkAPIJob__c order by CreatedDate desc limit 100];
        if(bulkJobList.size()>0)
        {
            for(BulkAPIJob__c job1 : bulkJobList)
            {
                oldBulkJobIDs.add(job1.Name);               
            }            
        }
        readHTMLContent();                                  
    }
    //Method to read the HTML content 
    private void readHTMLContent()
    {
        //List to add new jobids 
        list<BulkAPIJob__c> bulkJobListNew = new list<BulkAPIJob__c>();              
        try 
        {                              
            if(Test.isrunningTest())            
                bulkJobValues = '<h3>Completed last 7 days</h3><th scope="row" class=" dataCell  "><a href="/75090000003oP3R">75090000003oP3R</a></th><td class=" dataCell  "><a href="/00590000001xlUx">dev, jo</a></td><td class=" dataCell  ">7/4/2016 10:19 PM</td><td class=" dataCell  ">7/4/2016 10:19 PM</td><td class=" dataCell  ">Closed</td><td class=" dataCell  ">Query</td><td class=" dataCell  ">Case</td><td class=" dataCell  ">90</td><td class=" dataCell  ">0</td><td class=" dataCell  ">00:01</td></tr><tr class=" dataRow odd last" onblur="if (window.hiOff){hiOff(this);}" onfocus="if (window.hiOn){hiOn(this);}" onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}">';
            else
                bulkJobValues = bulkJobPage.getContent().toString();                                               
            list<String> completedJobIDS = bulkJobValues.split('<h3>Completed last 7 days</h3>');
            list<String> splittedJobIDS = completedJobIDS[1].split('<th scope="row" class=" dataCell  "><a href="/');
            for(Integer i=1;i<splittedJobIDS.size();i++)
            {               
                list<String> getAllValues = splittedJobIDS[i].split('<td class=" dataCell  ">');                                              
                if(!oldBulkJobIDs.contains(splittedJobIDS[i].substring(0,15)))
                {                                    
                    system.debug('new record');
                    BulkAPIJob__c bulkJob = initializeBulkJob(getAllValues);               
                    bulkJob.Name = splittedJobIDS[i].substring(0,15);                                      
                    bulkJobListNew.add(bulkJob);
                }                
                    
            }
            if(bulkJobListNew.size()>0)
            {
                
                system.debug('am invoking callout method');
                BatchAutomationHelper.getCalloutresponse(bulkJobListNew);
            }
            //updating lastParsedtime 
            BulkAPIAuthenticationConfig__c authDetails= BatchAutomationUtils.getAuthenticationDetails();
            authDetails.LastProcessedTime__c = startTime;
            update authDetails;                               
        } catch (VisualforceException e) {        
            
            
        }
    }
    //Method to map field values for BulkAPIJob__c object
    private BulkAPIJob__c initializeBulkJob(list<String> getAllValues)
    {        
        BulkAPIJob__c bulkJobs = new BulkAPIJob__c();
        if(getAllValues != null)
        {
            bulkJobs.StartTime__c = getAllValues[2].replaceAll('</td>','');
            bulkJobs.EndTime__c = getAllValues[3].replaceAll('</td>','');
            bulkJobs.Status__c = getAllValues[4].replaceAll('</td>','');
            bulkJobs.Operation__c = getAllValues[5].replaceAll('</td>','');
            bulkJobs.Object__c = getAllValues[6].replaceAll('</td>','');
            bulkJobs.Records_Processed__c = getAllValues[7].replaceAll('</td>','');
            bulkJobs.Records_Failed__c = getAllValues[8].replaceAll('</td>','');     
        }       
        return bulkJobs;                                      
    }
}