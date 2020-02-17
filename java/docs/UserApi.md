# UserApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1UsersGet**](UserApi.md#apiV1UsersGet) | **GET** /api/v1/users | list users
[**apiV1UsersPost**](UserApi.md#apiV1UsersPost) | **POST** /api/v1/users | create user
[**apiV1UsersUsernameDelete**](UserApi.md#apiV1UsersUsernameDelete) | **DELETE** /api/v1/users/{_username} | delete user
[**apiV1UsersUsernameGet**](UserApi.md#apiV1UsersUsernameGet) | **GET** /api/v1/users/{_username} | show user

<a name="apiV1UsersGet"></a>
# **apiV1UsersGet**
> apiV1UsersGet(page, authorization)

list users

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.UserApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

UserApi apiInstance = new UserApi();
String page = "page_example"; // String | Page number
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1UsersGet(page, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling UserApi#apiV1UsersGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **String**| Page number |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1UsersPost"></a>
# **apiV1UsersPost**
> apiV1UsersPost(body)

create user

### Example
```java
// Import classes:
//import io.swagger.client.ApiException;
//import io.swagger.client.api.UserApi;


UserApi apiInstance = new UserApi();
Object body = null; // Object | 
try {
    apiInstance.apiV1UsersPost(body);
} catch (ApiException e) {
    System.err.println("Exception when calling UserApi#apiV1UsersPost");
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

<a name="apiV1UsersUsernameDelete"></a>
# **apiV1UsersUsernameDelete**
> apiV1UsersUsernameDelete(_username, authorization)

delete user

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.UserApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

UserApi apiInstance = new UserApi();
Object _username = null; // Object | username
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1UsersUsernameDelete(_username, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling UserApi#apiV1UsersUsernameDelete");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_username** | [**Object**](.md)| username |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1UsersUsernameGet"></a>
# **apiV1UsersUsernameGet**
> apiV1UsersUsernameGet(_username, authorization)

show user

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.UserApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

UserApi apiInstance = new UserApi();
Object _username = null; // Object | username
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1UsersUsernameGet(_username, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling UserApi#apiV1UsersUsernameGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_username** | [**Object**](.md)| username |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

