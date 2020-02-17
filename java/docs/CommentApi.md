# CommentApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1CommentsGet**](CommentApi.md#apiV1CommentsGet) | **GET** /api/v1/comments | list comments
[**apiV1CommentsIdDelete**](CommentApi.md#apiV1CommentsIdDelete) | **DELETE** /api/v1/comments/{id} | delete comment
[**apiV1CommentsIdGet**](CommentApi.md#apiV1CommentsIdGet) | **GET** /api/v1/comments/{id} | show comment
[**apiV1CommentsIdPut**](CommentApi.md#apiV1CommentsIdPut) | **PUT** /api/v1/comments/{id} | update comment
[**apiV1CommentsPost**](CommentApi.md#apiV1CommentsPost) | **POST** /api/v1/comments | create comment

<a name="apiV1CommentsGet"></a>
# **apiV1CommentsGet**
> apiV1CommentsGet(authorization, postId, page, per)

list comments

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CommentApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CommentApi apiInstance = new CommentApi();
String authorization = "authorization_example"; // String | JWT token for Authorization
Integer postId = 56; // Integer | Post Id
Integer page = 56; // Integer | Page number
Integer per = 56; // Integer | Per page number
try {
    apiInstance.apiV1CommentsGet(authorization, postId, page, per);
} catch (ApiException e) {
    System.err.println("Exception when calling CommentApi#apiV1CommentsGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| JWT token for Authorization | [optional]
 **postId** | **Integer**| Post Id | [optional]
 **page** | **Integer**| Page number | [optional]
 **per** | **Integer**| Per page number | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1CommentsIdDelete"></a>
# **apiV1CommentsIdDelete**
> apiV1CommentsIdDelete(id, authorization)

delete comment

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CommentApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CommentApi apiInstance = new CommentApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CommentsIdDelete(id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CommentApi#apiV1CommentsIdDelete");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1CommentsIdGet"></a>
# **apiV1CommentsIdGet**
> apiV1CommentsIdGet(id, authorization)

show comment

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CommentApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CommentApi apiInstance = new CommentApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CommentsIdGet(id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CommentApi#apiV1CommentsIdGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1CommentsIdPut"></a>
# **apiV1CommentsIdPut**
> apiV1CommentsIdPut(body, id, authorization)

update comment

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CommentApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CommentApi apiInstance = new CommentApi();
Object body = null; // Object | 
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CommentsIdPut(body, id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CommentApi#apiV1CommentsIdPut");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Object**](Object.md)|  |
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

<a name="apiV1CommentsPost"></a>
# **apiV1CommentsPost**
> apiV1CommentsPost(body, authorization)

create comment

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CommentApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CommentApi apiInstance = new CommentApi();
Object body = null; // Object | 
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CommentsPost(body, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CommentApi#apiV1CommentsPost");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Object**](Object.md)|  |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

