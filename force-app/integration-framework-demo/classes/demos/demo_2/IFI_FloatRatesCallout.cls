/**
 * Demo #2 Example of class responsible for Float Rates REST-based GET Callouts
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
global without sharing class IFI_FloatRatesCallout implements IFI_InterfaceCallout {
    private static final String ENDPOINT_URL = 'http://www.floatrates.com/daily/usd.json';
    private Map<String, String> hiddenParams = new Map<String, String>();
    private Integer timeout = 120000;

    public IFI_FloatRatesCallout() {
    }

    public IFI_FloatRatesCallout(Integer timeout) {
        this.timeout = timeout;
    }

    public Type getType() {
        return IFI_FloatRatesCallout.class;
    }

    public String getHTTPMethod() {
        return IFI_HTTPMethod.GET.name();
    }

    public String getEndpointURL() {
        return ENDPOINT_URL;
    }

    public Integer getTimeout() {
        return timeout;
    }

    public String buildRequestBody() {
        return '';
    }

    public Object parseResponseBody(String responseBody) {
        return JSON.deserialize(responseBody, Map<String, CurrencyObj>.class);
    }

    public Map<String, String> getHiddenParams() {
        return hiddenParams;
    }

    public class CurrencyObj {
        public String alphaCode;
        public Decimal rate;
        public Decimal inverseRate;
    }
}