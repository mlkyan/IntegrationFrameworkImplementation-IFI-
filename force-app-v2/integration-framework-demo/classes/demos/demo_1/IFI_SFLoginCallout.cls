/**
 * Demo #1 Example of class responsible for SF Login SOAP-based POST Callouts
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
global without sharing class IFI_SFLoginCallout implements IFI_InterfaceCallout {    
    private static final String MASKED_PREFIX = 'MASKED';
    private static final String ENDPOINT_URL = 'https://test.salesforce.com/services/Soap/u/35.0';
    private Map<String, String> hiddenParams = new Map<String, String>();
    private Integer timeout = 120000;

    public IFI_SFLoginCallout() {
    }

    public IFI_SFLoginCallout(Integer timeout) {
        this.timeout = timeout;
    }

    public IFI_SFLoginCallout(String username, String password) {
        hiddenParams.put(MASKED_PREFIX +'_USERNAME', username);
        hiddenParams.put(MASKED_PREFIX +'_PASSWORD', password);
    }

    public Type getType() {
        return IFI_SFLoginCallout.class;
    }

    public String getHTTPMethod() {
        return IFI_HTTPMethod.POST.name();
    }

    public String getEndpointURL() {
        return ENDPOINT_URL;
    }

    public Integer getTimeout() {
        return timeout;
    }

    public String buildRequestBody() {
        return '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<Header/><Body><login xmlns="urn:partner.soap.sforce.com">' +
            '<username>MASKED_USERNAME</username><password>MASKED_PASSWORD</password></login></Body></Envelope>';
    }

    public Object parseResponseBody(String responseBody) {
        Dom.Document doc = new Dom.Document();
        doc.load(responseBody);
        String xmlSoapNameSpace = 'http://schemas.xmlsoap.org/soap/envelope/';
        String urnNameSpace = 'urn:partner.soap.sforce.com';
        String sessionId = (String) doc.getRootElement()
            .getChildElement('Body', xmlSoapNameSpace)
            .getChildElement('loginResponse', urnNameSpace)
            .getChildElement('result', urnNameSpace)
            .getChildElement('sessionId', urnNameSpace)
            .getText();

        hiddenParams = arrangeMap(hiddenParams);
        hiddenParams.put(sessionId, MASKED_PREFIX + '_SESSIONID');
        return sessionId;
    }

    public Map<String, String> getHiddenParams() {
        return hiddenParams;
    }

    public Map<String, String> arrangeMap(Map<String, String> hiddenParams) {
        for (String key : hiddenParams.keySet()) {
            if (key.startsWith(MASKED_PREFIX)) {
                String value = hiddenParams.get(key);
                hiddenParams.put(value, key);
                hiddenParams.remove(key);
            }
        }
        return hiddenParams;
    }
}