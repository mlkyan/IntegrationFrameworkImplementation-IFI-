/**
 * Generic class for mocking HTTP incorrect responses.
 *
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
public class IFI_MockIncorrectResponseCallout implements HttpCalloutMock {
    private static final String RESPONSE_ERROR_MESSAGE = '404 Not Found';
        private static final String RESPONSE_BODY = 'Hi World';
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatus(RESPONSE_ERROR_MESSAGE);
        res.setBody(RESPONSE_BODY);
        return res;
    }
}