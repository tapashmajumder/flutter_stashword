import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

enum RequestMethod {
  get("GET"),
  post("POST"),
  ;

  final String value;

  const RequestMethod(this.value);
}

enum QueryParam {
  id("id"),
  ;

  final String value;

  const QueryParam(this.value);
}

enum HeaderParam {
  contentType("Content-Type"),
  login("login"),
  securityCode("sc"),
  token("token"),
  encryptedSanity("ec"),
  ;

  final String value;

  const HeaderParam(this.value);
}

class NetworkError implements Exception {
  final String errorDescription;

  NetworkError(this.errorDescription);

  @override
  String toString() {
    return errorDescription;
  }
}

enum NetworkRequestType {
  json,
  binary,
  ;
}

enum NetworkResponseType {
  json,
  binary,
  ;
}

abstract class INetworkFetcher {
  Future<dynamic> fetch({
    required String server,
    required String path,
    required RequestMethod requestMethod,
    required NetworkRequestType requestType,
    required NetworkResponseType responseType,
    required Map<HeaderParam, String>? headers,
    required Map<QueryParam, String>? queryParams,
    required dynamic data,
  });
}

class HttpNetworkFetcher implements INetworkFetcher {
  const HttpNetworkFetcher();

  @override
  Future<dynamic> fetch({
    required String server,
    required String path,
    required RequestMethod requestMethod,
    required NetworkRequestType requestType,
    required NetworkResponseType responseType,
    required Map<HeaderParam, String>? headers,
    required Map<QueryParam, String>? queryParams,
    required dynamic data,
  }) async {
    final uri = Uri.https(server, path, NetworkUtil.createQueryParams(queryParams: queryParams));
    final request = http.Request(requestMethod.value, uri);
    request.headers.addAll(NetworkUtil.createHeaderParams(requestType: requestType, headers: headers));
    if (data != null) {
      if (requestType == NetworkRequestType.json) {
        request.body = jsonEncode(data);
      } else {
        request.bodyBytes = data;
      }
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      if (responseType == NetworkResponseType.json) {
        final strResponse = await response.stream.bytesToString();
        return jsonDecode(strResponse);
      } else {
        return await response.stream.toBytes();
      }
    } else {
      throw NetworkError(NetworkUtil.getInvalidResponseMessage(
          statusCode: response.statusCode,
          message: await response.stream.bytesToString(),));
    }
  }
}

final class NetworkOperation {
  final INetworkFetcher networkFetcher;
  final RequestMethod requestMethod;
  final String server;
  final String path;
  Map<HeaderParam, String>? headers;
  Map<QueryParam, String>? queryParams;

  NetworkOperation({
    this.networkFetcher = const HttpNetworkFetcher(),
    required this.requestMethod,
    required this.server,
    required this.path,
    this.headers,
    this.queryParams,
  });

  Future<T> fetchResult<T>({
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? jsonBody,
  }) async {
    final jsonResponse = await sendRequest(jsonBody: jsonBody);
    try {
      return fromJson(jsonResponse);
    } catch (e) {
      throw NetworkError("Deserialization to type $T failed: $e");
    }
  }

  Future<Map<String, dynamic>> sendRequest({Map<String, dynamic>? jsonBody}) async {
    return await networkFetcher.fetch(
      server: server,
      path: path,
      requestMethod: requestMethod,
      requestType: NetworkRequestType.json,
      responseType: NetworkResponseType.json,
      headers: headers,
      queryParams: queryParams,
      data: jsonBody,
    );
  }

  Future<dynamic> uploadData({required Uint8List data}) async {
    return await networkFetcher.fetch(
      server: server,
      path: path,
      requestMethod: requestMethod,
      requestType: NetworkRequestType.binary,
      responseType: NetworkResponseType.json,
      headers: headers,
      queryParams: queryParams,
      data: data,
    );
  }

  Future<Uint8List> downloadData() async {
    final base64EncodedData = await networkFetcher.fetch(
      server: server,
      path: path,
      requestMethod: requestMethod,
      requestType: NetworkRequestType.json,
      responseType: NetworkResponseType.binary,
      headers: headers,
      queryParams: queryParams,
      data: null,
    );
    try {
      return NetworkUtil.decodeBase64DataToBinary(base64EncodedData);
    } catch (e) {
      throw NetworkError("Deserialization of data failed: $e");
    }
  }
}

class NetworkUtil {
  static Map<String, String> createHeaderParams({
    required NetworkRequestType requestType,
    required Map<HeaderParam, String>? headers,
  }) {
    final userAddedHeaders = headers;
    final Map<HeaderParam, String> toAdd;
    switch (requestType) {
      case NetworkRequestType.json:
        toAdd = {HeaderParam.contentType: "application/json"};
        break;
      case NetworkRequestType.binary:
        toAdd = {HeaderParam.contentType: "application/octet-stream"};
    }
    if (userAddedHeaders != null) {
      toAdd.addAll(userAddedHeaders);
    }
    return {for (var entry in toAdd.entries) entry.key.value: entry.value};
  }

  static Map<String, String>? createQueryParams({required Map<QueryParam, String>? queryParams}) {
    if (queryParams == null) {
      return null;
    } else {
      return {for (var entry in queryParams.entries) entry.key.value: entry.value};
    }
  }

  static String getInvalidResponseMessage({int? statusCode, String message = "Invalid response from server"}) {
    final errorResponse = jsonDecode(message);
    final errorMessage = _extractErrorMessageFromJson(errorResponse);

    if (errorMessage != null) {
      return statusCode != null ? "Invalid status code: $statusCode: $errorMessage" : "Invalid response from server: $errorMessage";
    } else {
      return statusCode != null ? "Invalid status code: $statusCode" : message;
    }
  }

  static Uint8List encodeBinaryToBase64Data(List<int> binaryData) {
    final base64String = base64.encode(binaryData);
    final encodedData = utf8.encode(base64String);
    return Uint8List.fromList(encodedData);
  }

  static Uint8List decodeBase64DataToBinary(List<int> base64Data) {
    final base64String = utf8.decode(base64Data);
    final decodedData = base64.decode(base64String);
    return Uint8List.fromList(decodedData);
  }

  static String? _extractErrorMessageFromJson(Map<String, dynamic> serverJson) {
    return serverJson.containsKey("message") ? serverJson["message"] : null;
  }
}
