/**
 * Test class for IFI_SFLoginCallout demo callout using Mocks.
 *
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
@isTest
public class IFI_Demo1CalloutTest {
    public static final String RESPONSE_ERROR_MESSAGE = 'Internal Server Error';
    public static final String RESPONSE_NA_MESSAGE = '404 Not Found';
    public static final Integer RESPONSE_STATUS_CODE_SUCCESS = 200;
    public static final Integer RESPONSE_STATUS_CODE_ERROR = 500;
    public static final String RESPONSE_BODY =
        '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body>' +
        '<loginResponse><result><metadataServerUrl>https://iengage--test.sandbox.my.salesforce.com/services/Soap/m/35.0/00D8C0000004f4P</metadataServerUrl><passwordExpired>false</passwordExpired><sandbox>true</sandbox><serverUrl>' + 
        'https://worldCorp--test.sandbox.my.salesforce.com/services/Soap/u/35.0/00D8C0000004f4P</serverUrl><sessionId>MASKED_SESSIONID</sessionId> <userId>0058C000000ffl1QAA</userId><userInfo>' +
        '<accessibilityMode>false</accessibilityMode><currencySymbol>$</currencySymbol><orgAttachmentFileSizeLimit>10485760</orgAttachmentFileSizeLimit><orgDefaultCurrencyIsoCode>USD</orgDefaultCurrencyIsoCode><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments>' + 
        '<orgHasPersonAccounts>true</orgHasPersonAccounts><organizationId>00D8C000000564PUAQ</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>World Corporation</organizationName>' +
        '<profileId>00ed0000000yXCzRAM</profileId><roleId>00Ed0000000YOpyDAG</roleId><sessionSecondsValid>14400</sessionSecondsValid><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>helloWorld@worldCorporation.com</userEmail><userFullName>Bob Smith</userFullName><userId>0058C000000ffl1DHG</userId>' + 
        '<userLanguage>en_US</userLanguage><userLocale>en_US</userLocale><userName>helloWorld@worldCorporation.com.test</userName><userTimeZone>America/New_York</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></userInfo>' +
        '</result></loginResponse></soapenv:Body></soapenv:Envelope>';

    @isTest
    static void testDemo1CalloutFail() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockFailedCallout());
        IFI_CalloutsExecutor.getInstance().execute(new IFI_SFLoginCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.debug('log.Response_Status_Code__c ::' + log.Response_Status_Code__c);
        System.debug('log.Error_Message__c ::' + log.Error_Message__c);
        System.debug('log.Success__c ::' + false);
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
            'ERROR in testDemo1CalloutFail() : Expected value of' +
                RESPONSE_ERROR_MESSAGE +
                ' for log.Error_Message__c but got "' +
                log.Error_Message__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            false,
            'ERROR in testDemo1CalloutFail() : Expected value of false for log.Success__c but got "' + log.Success__c + '".'
        );
    }

    @isTest
    static void testDemo1CalloutIncorrectResponse() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockIncorrectResponseCallout());
        String sessionId = (String) IFI_CalloutsExecutor.getInstance().execute(new IFI_SFLoginCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Request_Body__c, Response_Body__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.debug('log.Response_Body__c::' + log.Response_Body__c);
        System.debug('log.Error_Message__c ::' + log.Error_Message__c);
        System.debug('log.Success__c ::' + false);
        System.assertNotEquals(
            log.Response_Body__c,
            RESPONSE_BODY,
            'ERROR in testDemo1CalloutIncorrectResponse() : Expected value of' +
                RESPONSE_BODY +
                ' for log.Response_Body__c but got "' +
                log.Response_Body__c +
                '".'
        );
        System.assertEquals(
            log.Error_Message__c,
            RESPONSE_NA_MESSAGE,
            'ERROR in testDemo1CalloutIncorrectResponse() : Expected value of' +
                RESPONSE_NA_MESSAGE +
                ' for log.Error_Message__c but got "' +
                log.Error_Message__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            false,
            'ERROR in testDemo1CalloutIncorrectResponse() : Expected value of false for log.Success__c but got "' +
                log.Success__c +
                '".'
        );
    }

    @isTest
    static void testDemo1CalloutSuccess() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new IFI_MockSuccessCallout());
        String sessionId = (String) IFI_CalloutsExecutor.getInstance().execute(new IFI_SFLoginCallout());
        IFI_CalloutsExecutor.getInstance().saveLogs();
        Test.stopTest();
        Integration_Log__c log = [
            SELECT Id, Response_Status_Code__c, Success__c, Request_Body__c, Response_Body__c, Error_Message__c
            FROM Integration_Log__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.debug('log.Response_Body__c::' + log.Response_Body__c);
        System.debug('log.Error_Message__c ::' + log.Error_Message__c);
        System.debug('log.Success__c ::' + false);
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
            'ERROR in testDemo1CalloutSuccess() : Expected value of' +
                RESPONSE_BODY +
                ' for log.Response_Body__c but got "' +
                log.Response_Body__c +
                '".'
        );
        System.assertEquals(
            log.Success__c,
            true,
            'ERROR in testDemo1CalloutSuccess() : Expected value of false for log.Success__c but got "' + log.Success__c + '".'
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