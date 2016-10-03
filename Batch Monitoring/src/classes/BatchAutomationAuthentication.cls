/*################################################################################
Project Name: <Batch Monitoring Automation>
File : <BatchAutomationAuthentication>
version: <1.0>
Created by : <Infosys Technologies>
Created Date: 7/27/2016
Last Modified By: Anitha Neelagandan
Last Modified Date: 8/4/2016
Description:This class is to Perform OAuth Authentication. 

################################################################################*/
public class BatchAutomationAuthentication
{
    //Variable Declaration 
    public static string consKey;
    public static string consSecret;
    public static string userName;
    public static string password;
    public string Access_Token;
    public static Map<string,string> decryptmap;
    
    
    //Wrapper class
    public class AccessDetails{
        public String access_token;
    }
    //This method is to perform Open source authentication and to get access token
    public string getAccessToken()
    {
        
        BulkAPIAuthenticationConfig__c authenticationKeys = BatchAutomationUtils.getAuthenticationDetails();
        String consumerKey = authenticationKeys.ConsumerKey__c;
        String consumerSecret  = authenticationKeys.ConsumerSecret__c;
        String accessKey =authenticationKeys.UserName__c;
        String accessSecret = authenticationKeys.Password__c;
        //OAuth Authentication
        string OAuthEndPoint = BulkJobsConfig__c.getvalues('BatchMonitor').AuthenticationURL__c;
        HttpRequest req = new HttpRequest();      
        req.setEndpoint(OAuthEndPoint);
        req.setMethod('GET');                                             
        req.setBody(
        'grant_type=password' +
        '&client_id=' + EncodingUtil.urlEncode(consumerKey, 'UTF-8') +
        '&client_secret=' + EncodingUtil.urlEncode(consumerSecret, 'UTF-8') +
        '&username=' + EncodingUtil.urlEncode(accessKey, 'UTF-8') +
        '&password=' + EncodingUtil.urlEncode(accessSecret, 'UTF-8'));
        Http http = new Http();      
        HttpResponse resp = new HttpResponse();
        
        //For testing purpose     
        if (Test.isRunningTest())
        {
            Access_Token = '00D28000000c0K5!ARMAQN9W_o5S8l4AkSoBoEv.HNGrqfQBLMMQk00I3EYvVZBl7MZCpQFV3ZEDIzlwCmQxbKjeZHoelB0bJWClfqWPZNhDLlMO';
        }
        else
        {
            resp = http.send(req);                                        
            AccessDetails jsonResp = (AccessDetails) JSON.deserialize(resp.getBody(), AccessDetails.class);            
            Access_Token =  jsonResp.access_token;
            
        }
    
        return Access_Token;        
    
    }
    

}