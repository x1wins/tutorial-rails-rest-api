# UserMultipartformDataApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1UsersPost**](UserMultipartformDataApi.md#apiV1UsersPost) | **POST** /api/v1/users/ | create user
[**apiV1UsersUsernamePut**](UserMultipartformDataApi.md#apiV1UsersUsernamePut) | **PUT** /api/v1/users/{_username} | update user

<a name="apiV1UsersPost"></a>
# **apiV1UsersPost**
> apiV1UsersPost(userName, userUsername, userEmail, userPassword, userPasswordConfirmation, userAvatar)

create user

### Example
```java
// Import classes:
//import io.swagger.client.ApiException;
//import io.swagger.client.api.UserMultipartformDataApi;


UserMultipartformDataApi apiInstance = new UserMultipartformDataApi();
String userName = "userName_example"; // String | 
String userUsername = "userUsername_example"; // String | 
String userEmail = "userEmail_example"; // String | 
String userPassword = "userPassword_example"; // String | 
String userPasswordConfirmation = "userPasswordConfirmation_example"; // String | 
File userAvatar = new File("userAvatar_example"); // File | 
try {
    apiInstance.apiV1UsersPost(userName, userUsername, userEmail, userPassword, userPasswordConfirmation, userAvatar);
} catch (ApiException e) {
    System.err.println("Exception when calling UserMultipartformDataApi#apiV1UsersPost");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userName** | **String**|  |
 **userUsername** | **String**|  |
 **userEmail** | **String**|  |
 **userPassword** | **String**|  |
 **userPasswordConfirmation** | **String**|  |
 **userAvatar** | **File**|  |

### Return type

null (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

<a name="apiV1UsersUsernamePut"></a>
# **apiV1UsersUsernamePut**
> apiV1UsersUsernamePut(userName, userUsername, userEmail, userPassword, userPasswordConfirmation, userAvatar, _username, authorization)

update user

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.UserMultipartformDataApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

UserMultipartformDataApi apiInstance = new UserMultipartformDataApi();
String userName = "userName_example"; // String | 
String userUsername = "userUsername_example"; // String | 
String userEmail = "userEmail_example"; // String | 
String userPassword = "userPassword_example"; // String | 
String userPasswordConfirmation = "userPasswordConfirmation_example"; // String | 
File userAvatar = new File("userAvatar_example"); // File | 
Object _username = null; // Object | username
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1UsersUsernamePut(userName, userUsername, userEmail, userPassword, userPasswordConfirmation, userAvatar, _username, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling UserMultipartformDataApi#apiV1UsersUsernamePut");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userName** | **String**|  |
 **userUsername** | **String**|  |
 **userEmail** | **String**|  |
 **userPassword** | **String**|  |
 **userPasswordConfirmation** | **String**|  |
 **userAvatar** | **File**|  |
 **_username** | [**Object**](.md)| username |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

