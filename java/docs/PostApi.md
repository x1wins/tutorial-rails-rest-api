# PostApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1PostsGet**](PostApi.md#apiV1PostsGet) | **GET** /api/v1/posts | list posts
[**apiV1PostsIdDelete**](PostApi.md#apiV1PostsIdDelete) | **DELETE** /api/v1/posts/{id} | delete post
[**apiV1PostsIdGet**](PostApi.md#apiV1PostsIdGet) | **GET** /api/v1/posts/{id} | show post
[**apiV1PostsIdPut**](PostApi.md#apiV1PostsIdPut) | **PUT** /api/v1/posts/{id} | update post
[**apiV1PostsPost**](PostApi.md#apiV1PostsPost) | **POST** /api/v1/posts | create post

<a name="apiV1PostsGet"></a>
# **apiV1PostsGet**
> apiV1PostsGet(authorization, categoryId, page, per, commentPage, commentPer, search)

list posts

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostApi apiInstance = new PostApi();
String authorization = "authorization_example"; // String | JWT token for Authorization
Integer categoryId = 56; // Integer | Category Id
Integer page = 56; // Integer | Page number
Integer per = 56; // Integer | Per page number
Integer commentPage = 56; // Integer | Page number for Comment
Integer commentPer = 56; // Integer | Per page number For Comment
String search = "search_example"; // String | Search Keyword
try {
    apiInstance.apiV1PostsGet(authorization, categoryId, page, per, commentPage, commentPer, search);
} catch (ApiException e) {
    System.err.println("Exception when calling PostApi#apiV1PostsGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| JWT token for Authorization | [optional]
 **categoryId** | **Integer**| Category Id | [optional]
 **page** | **Integer**| Page number | [optional]
 **per** | **Integer**| Per page number | [optional]
 **commentPage** | **Integer**| Page number for Comment | [optional]
 **commentPer** | **Integer**| Per page number For Comment | [optional]
 **search** | **String**| Search Keyword | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1PostsIdDelete"></a>
# **apiV1PostsIdDelete**
> apiV1PostsIdDelete(id, authorization)

delete post

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostApi apiInstance = new PostApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsIdDelete(id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostApi#apiV1PostsIdDelete");
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

<a name="apiV1PostsIdGet"></a>
# **apiV1PostsIdGet**
> apiV1PostsIdGet(id, authorization, commentPage, commentPer)

show post

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostApi apiInstance = new PostApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
Integer commentPage = 56; // Integer | Page number for Comment
Integer commentPer = 56; // Integer | Per page number For Comment
try {
    apiInstance.apiV1PostsIdGet(id, authorization, commentPage, commentPer);
} catch (ApiException e) {
    System.err.println("Exception when calling PostApi#apiV1PostsIdGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]
 **commentPage** | **Integer**| Page number for Comment | [optional]
 **commentPer** | **Integer**| Per page number For Comment | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1PostsIdPut"></a>
# **apiV1PostsIdPut**
> apiV1PostsIdPut(body, id, authorization)

update post

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostApi apiInstance = new PostApi();
Object body = null; // Object | 
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsIdPut(body, id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostApi#apiV1PostsIdPut");
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

<a name="apiV1PostsPost"></a>
# **apiV1PostsPost**
> apiV1PostsPost(body, authorization)

create post

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostApi apiInstance = new PostApi();
Object body = null; // Object | 
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsPost(body, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostApi#apiV1PostsPost");
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

