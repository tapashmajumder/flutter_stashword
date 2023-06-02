import 'dart:core';

import 'package:Stashword/network/server_jsons.dart';
import 'package:dio/dio.dart';

void main() async {
  final jsonOperation = JsonOperation<SyncConfirmCodeResult>(
    requestMethod: RequestMethod.post,
    baseUrl: "https://api2.stashword.com",
    path: "/app/csc",
    fromJson: SyncConfirmCodeResult.fromJson,
  );
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+1@gmail.com",
    HeaderParam.securityCode: "123",
  };

  SyncConfirmCodeResult result = await jsonOperation.fetchAndDeserialize();
  print(result);
}

enum RequestMethod {
  get,
  post,
  ;
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

final class JsonOperation<T> {
  final RequestMethod requestMethod;
  final String baseUrl;
  final String path;
  final T Function(Map<String, dynamic>) fromJson;
  Map<HeaderParam, String>? headers;
  Map<QueryParam, String>? queryParams;

  JsonOperation({
    required this.requestMethod,
    required this.baseUrl,
    required this.path,
    required this.fromJson,
  });

  Future<T> fetchAndDeserialize() async {
    try {
      final dio = Dio();
      final response = await _sendRequest(dio);

      if (response.statusCode == 200) {
        final jsonResponse = response.data as Map<String, dynamic>;
        try {
          return fromJson(jsonResponse);
        } catch (e) {
          throw NetworkError("Deserialization to type $T failed: $e");
        }
      } else {
        throw NetworkError(_getInvalidResponseMessage(response));
      }
    } catch (e) {
      if (e is NetworkError) {
        rethrow;
      } else if (e is DioError) {
        final dioError = e;
        final response = dioError.response;
        if (response != null) {
          throw NetworkError(_getInvalidResponseMessage(response));
        } else {
          throw NetworkError('Exception: $e');
        }
      } else {
        throw NetworkError('Exception: $e');
      }
    }
  }

  Future<Response> _sendRequest(Dio dio) async {
    final options = Options(
      responseType: ResponseType.json,
      headers: _createHeaderParams(),
    );
    final url = _createUrl(baseUrl: baseUrl, path: path);

    if (requestMethod == RequestMethod.get) {
      return dio.get(url, options: options, queryParameters: _createQueryParams());
    } else if (requestMethod == RequestMethod.post) {
      return dio.post(url, options: options, queryParameters: _createQueryParams());
    } else {
      throw NetworkError("Unsupported request method");
    }
  }

  static String _createUrl({required String baseUrl, required String path}) {
    return Uri.parse(baseUrl).resolve(path).toString();
  }

  static String _getInvalidResponseMessage(Response response) {
    final responseData = response.data;
    final statusCode = response.statusCode;

    if (responseData != null) {
      final errorResponse = responseData as Map<String, dynamic>;
      final errorMessage = _extractErrorMessageFromJson(errorResponse);

      if (errorMessage != null) {
        return statusCode != null
            ? "Invalid status code: $statusCode: $errorMessage"
            : "Invalid response from server: $errorMessage";
      }
    }

    return statusCode != null
        ? "Invalid status code: $statusCode"
        : "Invalid response from server";
  }

  Map<String, String> _createHeaderParams() {
    final userAddedHeaders = this.headers;
    final Map<HeaderParam, String> toAdd = {HeaderParam.contentType: "application/json"};
    if (userAddedHeaders != null) {
      toAdd.addAll(userAddedHeaders);
    }
    return {for (var entry in toAdd.entries) entry.key.value: entry.value};
  }

  Map<String, String>? _createQueryParams() {
    final queryParams = this.queryParams;
    if (queryParams == null) {
      return null;
    } else {
      return {for (var entry in queryParams.entries) entry.key.value: entry.value};
    }
  }

  static String? _extractErrorMessageFromJson(Map<String, dynamic> serverJson) {
    return serverJson.containsKey("message") ? serverJson["message"] : null;
  }
}
