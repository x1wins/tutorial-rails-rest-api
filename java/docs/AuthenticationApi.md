# AuthenticationApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1AuthLoginPost**](AuthenticationApi.md#apiV1AuthLoginPost) | **POST** /api/v1/auth/login | login authentication

<a name="apiV1AuthLoginPost"></a>
# **apiV1AuthLoginPost**
> apiV1AuthLoginPost(body)

login authentication

### Example
```java
// Import classes:
//import io.swagger.client.ApiException;
//import io.swagger.client.api.AuthenticationApi;


AuthenticationApi apiInstance = new AuthenticationApi();
Object body = null; // Object | 
try {
    apiInstance.apiV1AuthLoginPost(body);
} catch (ApiException e) {
    System.err.println("Exception when calling AuthenticationApi#apiV1AuthLoginPost");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Object**](Object.md)|  |

### Return type

null (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

