/**
 * Class used to execute callout implementations.
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
public class IFI_CalloutsExecutor {
    private static List<Integration_Log__c> logs = new List<Integration_Log__c>();
    private static IFI_CalloutsExecutor instance;
    private static final List<Integer> SUCCESS_STATUS_CODES = new List<Integer>{ 200, 201 };
    private Map<String, String> hiddenParams = new Map<String, String>();

    private IFI_CalloutsExecutor() {
    }

    public static IFI_CalloutsExecutor getInstance() {
        if (instance == null) {
            instance = new IFI_CalloutsExecutor();
        }
        return instance;
    }

    public Object execute(IFI_InterfaceCallout callout) {
        Object executionResult;
        HttpRequest request = initHttpRequest(callout);
        Integration_Log__c log = initLog(callout);
        Datetime startDT = Datetime.now();
        try {
            executionResult = processRequest(callout, request, log);
        } catch (Exception e) {
            handleResponseException(e, log);
        } finally {
            log.Callout_Duration__c = System.now().getTime() - startDT.getTime();
        }
        return executionResult;
    }

    public void saveLogs() {
        insert logs;
        logs = new List<Integration_Log__c>();
    }

    public List<Integration_Log__c> getLogs() {
        return logs;
    }

    private HttpRequest initHttpRequest(IFI_InterfaceCallout callout) {
        HttpRequest request = new HttpRequest();
        String endPoint = callout.getEndpointURL();
        String httpMethod = callout.getHTTPMethod();
        request.setEndpoint(endPoint);
        request.setMethod(httpMethod);
        request.setTimeout(callout.getTimeout());
        request.setHeader('Content-Type', 'text/xml; charset=UTF-8');
        request.setHeader('SOAPAction', 'Wololo');
        return request;
    }

    private Integration_Log__c initLog(IFI_InterfaceCallout callout) {
        Integration_Log__c log = new Integration_Log__c(
            Callout_Class__c = callout.getType().toString(),
            Endpoint_URL__c = callout.getEndpointURL(),
            Success__c = true
        );
        logs.add(log);
        return log;
    }

    private Object processRequest(IFI_InterfaceCallout callout, HttpRequest request, Integration_Log__c log) {
        String requestBody = callout.buildRequestBody();
        requestBody = replaceSecuredParams(requestBody, callout.getHiddenParams());
        request.setBody(requestBody);
        HttpResponse response = sendRequest(callout, request, log);
        if (SUCCESS_STATUS_CODES.contains(response.getStatusCode())) {
            Object parsedResponse = callout.parseResponseBody(response.getBody());
            log.Success__c = true;
            log.Request_Body__c = replaceSecuredParams(
                requestBody.mid(0, Integration_Log__c.Request_Body__c.getDescribe().length),
                callout.getHiddenParams()
            );
            return parsedResponse;
        } else {
            log.Request_Body__c = requestBody;
            log.Error_Message__c = response.getStatus();
            log.Success__c = false;
        }
        return null;
    }

    private HttpResponse sendRequest(IFI_InterfaceCallout callout, HttpRequest request, Integration_Log__c log) {
        Http http = new Http();
        HttpResponse response = http.send(request);
        log.Response_Status_Code__c = response.getStatusCode();
        log.Response_Body__c = response.getBody();
        return response;
    }

    private String replaceSecuredParams(String requestBody, Map<String, String> hiddenParams) {
        String result = requestBody;
        for (String param : hiddenParams.keySet()) {
            result = result.replaceAll(param, Matcher.quoteReplacement(hiddenParams.get(param)));
        }
        return result;
    }

    private void handleResponseException(Exception e, Integration_Log__c log) {
        Datetime endLog = Datetime.now();
        String errorMessage = e.getMessage() + ' ' + e.getStackTraceString();
        log.Error_Message__c = e.getMessage();
        log.Success__c = false;
    }
}