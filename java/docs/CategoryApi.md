# CategoryApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1CategoriesGet**](CategoryApi.md#apiV1CategoriesGet) | **GET** /api/v1/categories | list categories
[**apiV1CategoriesIdDelete**](CategoryApi.md#apiV1CategoriesIdDelete) | **DELETE** /api/v1/categories/{id} | delete category
[**apiV1CategoriesIdGet**](CategoryApi.md#apiV1CategoriesIdGet) | **GET** /api/v1/categories/{id} | show category
[**apiV1CategoriesIdPut**](CategoryApi.md#apiV1CategoriesIdPut) | **PUT** /api/v1/categories/{id} | update category
[**apiV1CategoriesPost**](CategoryApi.md#apiV1CategoriesPost) | **POST** /api/v1/categories | create category

<a name="apiV1CategoriesGet"></a>
# **apiV1CategoriesGet**
> apiV1CategoriesGet(authorization, page, per, postPage, postPer)

list categories

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CategoryApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CategoryApi apiInstance = new CategoryApi();
String authorization = "authorization_example"; // String | JWT token for Authorization
Integer page = 56; // Integer | Page number
Integer per = 56; // Integer | Per page number
Integer postPage = 56; // Integer | Page number for Post
Integer postPer = 56; // Integer | Per page number For Post
try {
    apiInstance.apiV1CategoriesGet(authorization, page, per, postPage, postPer);
} catch (ApiException e) {
    System.err.println("Exception when calling CategoryApi#apiV1CategoriesGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| JWT token for Authorization | [optional]
 **page** | **Integer**| Page number | [optional]
 **per** | **Integer**| Per page number | [optional]
 **postPage** | **Integer**| Page number for Post | [optional]
 **postPer** | **Integer**| Per page number For Post | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1CategoriesIdDelete"></a>
# **apiV1CategoriesIdDelete**
> apiV1CategoriesIdDelete(id, authorization)

delete category

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CategoryApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CategoryApi apiInstance = new CategoryApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CategoriesIdDelete(id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CategoryApi#apiV1CategoriesIdDelete");
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

<a name="apiV1CategoriesIdGet"></a>
# **apiV1CategoriesIdGet**
> apiV1CategoriesIdGet(id, authorization, postPage, postPer)

show category

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CategoryApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CategoryApi apiInstance = new CategoryApi();
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
Integer postPage = 56; // Integer | Page number for Post
Integer postPer = 56; // Integer | Per page number For Post
try {
    apiInstance.apiV1CategoriesIdGet(id, authorization, postPage, postPer);
} catch (ApiException e) {
    System.err.println("Exception when calling CategoryApi#apiV1CategoriesIdGet");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id |
 **authorization** | **String**| JWT token for Authorization | [optional]
 **postPage** | **Integer**| Page number for Post | [optional]
 **postPer** | **Integer**| Per page number For Post | [optional]

### Return type

null (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

<a name="apiV1CategoriesIdPut"></a>
# **apiV1CategoriesIdPut**
> apiV1CategoriesIdPut(body, id, authorization)

update category

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CategoryApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CategoryApi apiInstance = new CategoryApi();
Object body = null; // Object | 
String id = "id_example"; // String | id
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CategoriesIdPut(body, id, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CategoryApi#apiV1CategoriesIdPut");
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

<a name="apiV1CategoriesPost"></a>
# **apiV1CategoriesPost**
> apiV1CategoriesPost(body, authorization)

create category

### Example
```java
// Import classes:
//import io.swagger.client.ApiClient;
//import io.swagger.client.ApiException;
//import io.swagger.client.Configuration;
//import io.swagger.client.auth.*;
//import io.swagger.client.api.CategoryApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: Bearer
ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
Bearer.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//Bearer.setApiKeyPrefix("Token");

CategoryApi apiInstance = new CategoryApi();
Object body = null; // Object | 
String authorization = "authorization_example"; // String | JWT token for Authorization
try {
    apiInstance.apiV1CategoriesPost(body, authorization);
} catch (ApiException e) {
    System.err.println("Exception when calling CategoryApi#apiV1CategoriesPost");
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

