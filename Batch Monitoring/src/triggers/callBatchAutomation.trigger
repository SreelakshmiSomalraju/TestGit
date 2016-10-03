trigger callBatchAutomation on BulkAPIJob__c (after insert, after update) {
    
    for(BulkAPIJob__c bulkJob: Trigger.New)
    {
        if(bulkJob.Status__c !='Open')
        {                                 
           system.debug('am invoking future method');
           BatchAutomationHelper.getCalloutresponse(bulkJob.Name);
        }
    }   
}