# PostMultipartformDataApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1PostsIdAttachedAttachedIdDelete**](PostMultipartformDataApi.md#apiV1PostsIdAttachedAttachedIdDelete) | **DELETE** /api/v1/posts/{id}/attached/{attached_id} | delete post attached file
[**apiV1PostsIdPut**](PostMultipartformDataApi.md#apiV1PostsIdPut) | **PUT** /api/v1/posts/{id}/ | update multipart form
[**apiV1PostsPost**](PostMultipartformDataApi.md#apiV1PostsPost) | **POST** /api/v1/posts/ | create multipart form

<a name="apiV1PostsIdAttachedAttachedIdDelete"></a>
# **apiV1PostsIdAttachedAttachedIdDelete**
> apiV1PostsIdAttachedAttachedIdDelete(id, attachedId, authorization)

delete post attached file

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostMultipartformDataApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostMultipartformDataApi apiInstance = new PostMultipartformDataApi();
String id = "id_example"; // String | id
String attachedId = "attachedId_example"; // String | attached_id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsIdAttachedAttachedIdDelete(id, attachedId, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostMultipartformDataApi#apiV1PostsIdAttachedAttachedIdDelete");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id |
 **attachedId** | **String**| attached_id |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1PostsIdPut"></a>
# **apiV1PostsIdPut**
> apiV1PostsIdPut(postTitle, postBody, postFiles, id, authorization)

update multipart form

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostMultipartformDataApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostMultipartformDataApi apiInstance = new PostMultipartformDataApi();
String postTitle = "postTitle_example"; // String | 
String postBody = "postBody_example"; // String | 
File postFiles = new File("postFiles_example"); // File | 
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsIdPut(postTitle, postBody, postFiles, id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostMultipartformDataApi#apiV1PostsIdPut");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postTitle** | **String**|  |
 **postBody** | **String**|  |
 **postFiles** | **File**|  |
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

<a name="apiV1PostsPost"></a>
# **apiV1PostsPost**
> apiV1PostsPost(postTitle, postBody, postCategoryId, postFiles, authorization)

create multipart form

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.PostMultipartformDataApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

PostMultipartformDataApi apiInstance = new PostMultipartformDataApi();
String postTitle = "postTitle_example"; // String | 
String postBody = "postBody_example"; // String | 
Integer postCategoryId = 56; // Integer | 
File postFiles = new File("postFiles_example"); // File | 
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1PostsPost(postTitle, postBody, postCategoryId, postFiles, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling PostMultipartformDataApi#apiV1PostsPost");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postTitle** | **String**|  |
 **postBody** | **String**|  |
 **postCategoryId** | **Integer**|  |
 **postFiles** | **File**|  |
 **authorization** | **String**| JWT token for Authorization | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

