# Integration Framework Implementation (IFI)

## Description

A simple and generic integration framework for making Salesforce Callouts via HTTP services

**Industry**: Any

**Key Features**:
1) Allows to easily set up new integration callouts (REST/SOAP-based)
2) Has a support for logging each callout into custom object


**Technical Stack**: Apex, REST API, SOAP API

## Class Diagram

![IFI_ClassDIagramV2 drawio](https://user-images.githubusercontent.com/54051511/234540607-4c4f11d7-0375-49f5-9748-80236290d1c1.png)


**NOTE** :
IFI_CalloutsExecutor is a Singleton, so rather than initializing via 'new' keyword each time, call by IL_CalloutExecutor.getInstance();

## Data Model

| Type          | API Name                | Description                                                             |
|---------------|-------------------------|-------------------------------------------------------------------------|
| Custom Object | Integration_Log__c      | Used for logging any callout results, both successful and unsuccessful. |
| Custom Field  | Callout_Class__c        | Name of the callout class.                                              |
| Custom Field  | Callout_Duration__c     | Callout duration in milliseconds.                                       |
| Custom Field  | Endpoint_URL__c         | Callout endpoint URL.                                                   |
| Custom Field  | Error_Message__c        | Error message.                                                          |
| Custom Field  | Request_Body__c         | Text body of callout request.                                           |
| Custom Field  | Response_Body__c        | Text body of callout response.                                          |
| Custom Field  | Response_Status_Code__c | Callout response status code.                                           |
| Custom Field  | Success__c              | True if callout executed successfully.                                  |

## Permission Sets

N/A

## Configuration

N/A

## Code examples
Extending a new callout implementation: 

    global without sharing class IFI_XXXCallout implements IFI_InterfaceCallout {
    private static final String ENDPOINT_URL = 'ADD_YOUR_URL_HERE';
    private Map<String, String> hiddenParams = new Map<String, String>(); // populate with parameters that need hiding in request/response bodies
    private Integer timeout = 120000; // default


    public IFI_XXXCallout() {
    }

    public IFI_XXXCallout(Integer timeout) { / override default timeout via constructor if needed
        this.timeout = timeout;
    }

    public Type getType() {
        return IFI_XXXCallout.class;
    }

    public String getHTTPMethod() {
        return IFI_HTTPMethod.GET.name(); // add HTTP method here 
    }

    public String getEndpointURL() {
        return ENDPOINT_URL;
    }

    public Integer getTimeout() {
        return timeout;
    }

    public String buildRequestBody() { // construct XML/JSON request body here
        return '';
    }

    public Object parseResponseBody(String responseBody) { // parse incoming response body here
    }

    public Map<String, String> getHiddenParams() { // use for hiding any parameters in requests/responses for security purposes, before logging into database
        return hiddenParams;
    }
    }
