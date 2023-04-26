/**
 * Generic class for mocking failed HTTP responses.
 *
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
public class IFI_MockFailedCallout implements HttpCalloutMock {
    private static final String RESPONSE_ERROR_MESSAGE = 'Internal Server Error';
    private static final Integer RESPONSE_STATUS_CODE_ERROR = 500;
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(RESPONSE_STATUS_CODE_ERROR);
        res.setStatus(RESPONSE_ERROR_MESSAGE);
        return res;
    }
}