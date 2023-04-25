/**
 * Interface that is implemented by each concrete callout.
 *
 * @author: Melikyan Ed
 * @date: 19.04.2023
 *
 */
 public interface IFI_InterfaceCallout{
  
    Type getType();
    String getHTTPMethod();
    String getEndpointURL();
    Integer getTimeout();
    Map<String,String> getHiddenParams();
    String buildRequestBody();
    Object parseResponseBody(String responseBody);
}