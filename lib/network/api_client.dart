import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/general.dart';
import '../models/requests.dart';

class ApiClient {
  static ApiClient? _instance;

  BuildContext mContext;
  String mBaseUrl;
  String? mAuthToken;

  ApiClient(this.mBaseUrl, this.mContext);

  static ApiClient get instance => _instance!;

  static ApiClient create(BuildContext context) {
    String baseUrl = 'https://muraadmin.com/api';
    _instance = ApiClient(baseUrl, context);

    return _instance!;
  }

  static void setAuthToken(authToken) {
    _instance?.mAuthToken = authToken;
  }

  Future<ApiSingleResponse<T>> callObjectApi<T>({
    required String endPoint,
    ApiPayload? req,
    required ModelFromJson fromJson,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    };

    if (mAuthToken != null) {
      headers['Authorization'] = mAuthToken!;
    }

    String url = '$mBaseUrl/$endPoint';
    String payload = req == null ? '{}' : jsonEncode(req);


    final http.Response response;

    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: payload,
      );
    }
    on TimeoutException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }
    on SocketException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }

    if (response.statusCode == 502)
    {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': response.reasonPhrase,
        'ErrorCode': -1,
      });
    }


    Map<String, dynamic> parsed = jsonDecode(response.body)?.cast<String, dynamic>();


    return compute(parseObjectResponse, {
      'response': jsonEncode(parsed),
      'code': response.statusCode,
      'fromJson': fromJson,
    });
  }

  Future<ApiSingleResponse<T>> callObjectApiGet<T>({
    required String endPoint,
    required ModelFromJson fromJson,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    };

    if (mAuthToken != null) {
      headers['Authorization'] = mAuthToken!;
    }

    String url = '$mBaseUrl/$endPoint';


    final http.Response response;

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
    }
    on TimeoutException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }
    on SocketException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }

    if (response.statusCode == 502)
    {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': response.reasonPhrase,
        'ErrorCode': -1,
      });
    }


    Map<String, dynamic> parsed = jsonDecode(response.body)?.cast<String, dynamic>();


    return compute(parseObjectResponse, {
      'response': jsonEncode(parsed),
      'code': response.statusCode,
      'fromJson': fromJson,
    });
  }

  Future<ApiListResponse<T>> callListApi<T>({
    required String endPoint,
    ApiPayload? req,
    required ModelFromJson fromJson,
  }) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    };

    if (mAuthToken != null) {
      headers['Authorization'] = mAuthToken!;
    }

    String url = '$mBaseUrl/$endPoint';
    String payload = req == null ? '{}' : jsonEncode(req);

    final http.Response response;

    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: payload,
      );
    }
    on TimeoutException catch (e) {
      return ApiListResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }
    on SocketException catch (e) {
      return ApiListResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }

    if (response.statusCode == 502)
      {
        return ApiListResponse(null, <String, dynamic>{
          'Status': 'Error',
          'ErrorMessage': response.reasonPhrase,
          'ErrorCode': -1,
        });
      }

    Map<String, dynamic> parsed = jsonDecode(response.body)?.cast<String, dynamic>();




    return compute(parseListResponse, {
      'response': jsonEncode(parsed),
      'code': response.statusCode,
      'fromJson': fromJson,
    });
  }

  Future<ApiListResponse<T>> callListApiGet<T>({
    required String endPoint,
    ApiPayload? req,
    required ModelFromJson fromJson,
  }) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    };

    if (mAuthToken != null) {
      headers['Authorization'] = mAuthToken!;
    }

    String url = '$mBaseUrl/$endPoint';

    final http.Response response;

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
    }
    on TimeoutException catch (e) {
      return ApiListResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }
    on SocketException catch (e) {
      return ApiListResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }

    if (response.statusCode == 502)
    {
      return ApiListResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': response.reasonPhrase,
        'ErrorCode': -1,
      });
    }

    Map<String, dynamic> parsed = jsonDecode(response.body)?.cast<String, dynamic>();




    return compute(parseListResponse, {
      'response': jsonEncode(parsed),
      'code': response.statusCode,
      'fromJson': fromJson,
    });
  }

  Future<ApiSingleResponse<T>> callFileApi<T>(
      {required String endPoint,
        required ModelFromJson fromJson,
        required String key,
        required String value,
        MultipartFile? file}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    };

    if (mAuthToken != null) {
      headers['Authorization'] = mAuthToken!;
    }

    String url = '$mBaseUrl/$endPoint';

    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(file!);
    request.headers.addAll(headers);
    request.fields[key] = value;

    final http.Response response;

    try {
      response = await http.Response.fromStream(await request.send());
    }
    on TimeoutException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }
    on SocketException catch (e) {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': e.message,
        'ErrorCode': -1,
      });
    }

    if (response.statusCode == 502)
    {
      return ApiSingleResponse(null, <String, dynamic>{
        'Status': 'Error',
        'ErrorMessage': response.reasonPhrase,
        'ErrorCode': -1,
      });
    }

    final parsed = jsonDecode(response.body)?.cast<String, dynamic>();


    return compute(parseObjectResponse, {
      'response': jsonEncode(parsed),
      'code': response.statusCode,
      'fromJson': fromJson,
    });
  }

}

ApiListResponse<T> parseListResponse<T>(Map<String, dynamic> parameters) {
  final body = parameters['response'];
  final statusCode = parameters['code'];
  final fromJson = parameters['fromJson'];

  final Map<String, dynamic> parsed;

  try {
    parsed = jsonDecode(body)?.cast<String, dynamic>();
  } on FormatException {
    return ApiListResponse(null, <String, dynamic>{
      'Status': 'Error',
      'ErrorMessage': body,
      'ErrorCode': statusCode,
    });
  }

  if (statusCode != 200) {
    return ApiListResponse(null, parsed);
  }

  return ApiListResponse<T>.fromMap(parsed, fromJson);
}

ApiSingleResponse<T> parseObjectResponse<T>(Map<String, dynamic> parameters) {
  final body = parameters['response'];
  final statusCode = parameters['code'];
  final fromJson = parameters['fromJson'];

  final Map<String, dynamic> parsed;
  try {
    parsed = jsonDecode(body)?.cast<String, dynamic>();
  } on FormatException {
    return ApiSingleResponse(null, <String, dynamic>{
      'Status': 'Error',
      'ErrorMessage': body,
      'ErrorCode': statusCode,
    });
  }

  if (statusCode != 200) {
    return ApiSingleResponse(null, parsed);
  }

  return ApiSingleResponse<T>.fromMap(parsed, fromJson);
}
