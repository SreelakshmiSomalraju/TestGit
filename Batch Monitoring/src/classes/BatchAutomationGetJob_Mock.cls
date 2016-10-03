@isTest
global class BatchAutomationGetJob_Mock implements HttpCalloutMock
{

    global HTTPResponse respond(HttpRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setheader('Content-Type', 'text/xml');
        res.setbody('<?xml version="1.0" encoding="UTF-8"?>'
                +'<batchInfoList xmlns="http://www.force.com/2009/06/asyncapi/dataload">'                         
                +'<batchInfo>'
                +'<id>75128000003NcHDAA0</id>'
                +'<jobId>75128000003NfZ5AAK</jobId>'
                +'<state>Completed</state>'
                +'<createdDate>2016-07-04T07:00:17.000Z</createdDate>'
                +'<systemModstamp>2016-07-04T07:00:20.000Z</systemModstamp>'
                +'<numberRecordsProcessed>95</numberRecordsProcessed>'
                +'<numberRecordsFailed>5</numberRecordsFailed>'
                +'<totalProcessingTime>0</totalProcessingTime>'
                +'<apiActiveProcessingTime>0</apiActiveProcessingTime>'
                +'<apexProcessingTime>0</apexProcessingTime>'
                +'</batchInfo>'
               
        +'</batchInfoList>');
        res.setStatusCode(200);
        return res;
    }
}