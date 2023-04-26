/**
 * Test class for IFI_FloatRatesCallout demo callout using Mocks.
 *
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
@isTest
public class IFI_Demo2CalloutTest {
    private static final String RESPONSE_ERROR_MESSAGE = 'Internal Server Error';
    private static final String RESPONSE_NA_MESSAGE = '404 Not Found';
    private static final Integer RESPONSE_STATUS_CODE_SUCCESS = 200;
    private static final Integer RESPONSE_STATUS_CODE_ERROR = 500;
    private static final String RESPONSE_BODY = '{"eur":{"code":"EUR","alphaCode":"EUR","numericCode":"978","name":"Euro","rate":0.90651397253215,"date":"Tue, 25 Apr 2023 11:55:01 GMT","inverseRate":1.1031269570029}}';
    private static final String RESPONSE_KEY = 'eur';

    @isTest
    static void testDemo1CalloutFail() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockFailedCallout());
        IFI_CalloutsExecutor.getInstance().execute(new IFI_FloatRatesCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.assertEquals(
            log.Response_Status_Code__c,
            RESPONSE_STATUS_CODE_ERROR,
            'ERROR in testDemo1CalloutFail() : Expected value of' +
                RESPONSE_STATUS_CODE_ERROR +
                ' for log.Response_Status_Code__c but got "' +
                log.Response_Status_Code__c +
                '".'
        );
        System.assertEquals(
            log.Error_Message__c,
            RESPONSE_ERROR_MESSAGE,
            'ERROR in testDemo2CalloutFail() : Expected value of' +
                RESPONSE_ERROR_MESSAGE +
                ' for log.Error_Message__c but got "' +
                log.Error_Message__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            false,
            'ERROR in testDemo2CalloutFail() : Expected value of false for log.Success__c but got "' + log.Success__c + '".'
        );
    }

    @isTest
    static void testDemo1CalloutIncorrectResponse() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockIncorrectResponseCallout());
        Map<String, IFI_FloatRatesCallout.CurrencyObj> currencyMap = (Map<String, IFI_FloatRatesCallout.CurrencyObj>) IFI_CalloutsExecutor.getInstance().execute(new IFI_FloatRatesCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Request_Body__c, Response_Body__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.assertNotEquals(
            log.Response_Body__c,
            RESPONSE_BODY,
            'ERROR in testDemo2CalloutIncorrectResponse() : Expected value of' +
                RESPONSE_BODY +
                ' for log.Response_Body__c but got "' +
                log.Response_Body__c +
                '".'
        );
        System.assertEquals(
            log.Error_Message__c,
            RESPONSE_NA_MESSAGE,
            'ERROR in testDemo2CalloutIncorrectResponse() : Expected value of' +
                RESPONSE_NA_MESSAGE +
                ' for log.Error_Message__c but got "' +
                log.Error_Message__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            false,
            'ERROR in testDemo2CalloutIncorrectResponse() : Expected value of false for log.Success__c but got "' +
                log.Success__c +
                '".'
        );
    }

    @isTest
    static void testDemo1CalloutSuccess() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockSuccessCallout());
        Map<String, IFI_FloatRatesCallout.CurrencyObj> currencyMap = (Map<String, IFI_FloatRatesCallout.CurrencyObj>) IFI_CalloutsExecutor.getInstance().execute(new IFI_FloatRatesCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Request_Body__c, Response_Body__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        Boolean hasMapEurCurrencyKey = currencyMap.containsKey(RESPONSE_KEY);
        System.assertEquals(
            log.Response_Status_Code__c,
            RESPONSE_STATUS_CODE_SUCCESS,
            'ERROR in testDemo1CalloutSuccess() : Expected value of' +
                RESPONSE_STATUS_CODE_SUCCESS +
                ' for log.Response_Status_Code__c but got "' +
                log.Response_Status_Code__c +
                '".'
        );
        System.assertEquals(
            log.Response_Body__c,
            RESPONSE_BODY,
            'ERROR in testDemo2CalloutSuccess() : Expected value of' +
                RESPONSE_BODY +
                ' for log.Response_Body__c but got "' +
                log.Response_Body__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            true,
            'ERROR in testDemo2CalloutSuccess() : Expected value of false for log.Success__c but got "' + log.Success__c + '".'
        );
        System.assertEquals(
            hasMapEurCurrencyKey,
            true,
            'ERROR in testDemo2CalloutSuccess() : Expected value of true for hasMapEurCurrencyKey but got "' + hasMapEurCurrencyKey + '".'
        );
    }

    private class IFI_MockSuccessCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(RESPONSE_STATUS_CODE_SUCCESS);
            res.setBody(RESPONSE_BODY);
            return res;
        }
    }
}