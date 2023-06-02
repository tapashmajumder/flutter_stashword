import 'dart:core';

import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/network/server_jsons.dart';
import 'package:Stashword/sync/sync_server_jsons.dart';
import 'package:dio/dio.dart';

Future<void> withReturnType() async {
  final jsonOperation = JsonOperation(
    requestMethod: RequestMethod.post,
    baseUrl: "https://api2.stashword.com",
    path: "/app/csc",
  );
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+1@gmail.com",
    HeaderParam.securityCode: "123",
  };

  SyncConfirmCodeResult result = await jsonOperation.fetchAndDeserialize(SyncConfirmCodeResult.fromJson);
}

Future<void> withoutReturnType() async {
  final jsonOperation = JsonOperation(
    requestMethod: RequestMethod.post,
    baseUrl: "https://api2.stashword.com",
    path: "/app/updateItem",
  );
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+3@gmail.com",
    HeaderParam.token: "5a882dee04084a3ab4d4f5772ec5a288",
    HeaderParam.encryptedSanity: "zcjlsWuXyqjm7QmNNa9qVPt6njvwGFZImGda3KEbPn4=",
  };
  final itemJson = ItemJson(
    itemType: ItemType.password,
    id: "1a23a8634f1640319ccd30841a4e316a",
    iv: "QzoBSlvF29T9eKxNjvWGhw==",
    shared: true,
    sharedSecret: "wxZVajDLmR2Gkb3xffGJTdGUlg9zn1zsqausf6aga0mmC3OSPhkmGz2wrcjO5k1x",
    rgbInt: 10065516,
  );
  jsonOperation.jsonBody = itemJson.toJson();
  await jsonOperation.fetchResponse();
}

Future<void> main() async {
  await withReturnType();
  await withoutReturnType();
}

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

final class JsonOperation {
  final RequestMethod requestMethod;
  final String baseUrl;
  final String path;
  Map<HeaderParam, String>? headers;
  Map<QueryParam, String>? queryParams;
  Map<String, dynamic>? jsonBody;

  JsonOperation({
    required this.requestMethod,
    required this.baseUrl,
    required this.path,
  });

  Future<T> fetchAndDeserialize<T>(T Function(Map<String, dynamic>) fromJson) async {
    final jsonResponse = await fetchResponse();
    try {
      return fromJson(jsonResponse);
    } catch (e) {
      throw NetworkError("Deserialization to type $T failed: $e");
    }
  }

  Future<Map<String, dynamic>> fetchResponse() async {
    try {
      final dio = Dio();
      final response = await _sendRequest(dio);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
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
    final url = _createUrl(baseUrl: baseUrl, path: path);
    return dio.fetch(RequestOptions(
      path: url,
      method: requestMethod.value,
      queryParameters: _createQueryParams(),
      headers: _createHeaderParams(),
      data: jsonBody,
    ));
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
        return statusCode != null ? "Invalid status code: $statusCode: $errorMessage" : "Invalid response from server: $errorMessage";
      }
    }

    return statusCode != null ? "Invalid status code: $statusCode" : "Invalid response from server";
  }

  Map<String, String> _createHeaderParams() {
    final userAddedHeaders = headers;
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
