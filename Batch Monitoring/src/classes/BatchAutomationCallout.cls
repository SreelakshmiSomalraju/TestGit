/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchAutomationCallout>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 9/1/2016
Last Modified By: 
Last Modified Date:
Description: Batch class used to invoke the callout class.

################################################################################*/
global class BatchAutomationCallout implements Database.Batchable<string>,
   Database.AllowsCallouts{
    global Iterable<string> start(Database.Batchablecontext BC){    
        BulkMonitorJob monitorJob = new BulkMonitorJob();
        monitorJob.getBulkJobContent();
        return new list<string>{'Do'};                
    }
    
    global void execute(Database.BatchableContext BC, List<string> Strings){     
    }
    
    global void finish(Database.BatchableContext info){               
    }
}