@isTest
global class BatchAutomationOAuth_Mock implements HttpCalloutMock
{
    global HTTPResponse respond(HttpRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setheader('Content-Type', 'application/json');
        res.setbody('{"access_token":"00D28000000c0K5!ARMAQN9W_o5S8l4AkSoBoEv.HNGrqfQBLMMQk00I3EYvVZBl7MZCpQFV3ZEDIzlwCmQxbKjeZHoelB0bJWClfqWPZNhDLlMO","instance_url":"https://ap2.salesforce.com","id":"https://login.salesforce.com/id/00D28000000c0K5EAI/00528000000SrgVAAS","token_type":"Bearer","issued_at":"1468404075579","signature":"n++ONcqgz3/TAU+FHEtNgB8NBL3RkXGq0cWX3aUHork="}');
        res.setStatusCode(200);
        return res;
    }
}