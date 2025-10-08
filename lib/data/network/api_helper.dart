import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app_url.dart';
import '../response/exception.dart';
import '../response/response_check.dart';

class NetworkApiService {
  var dio = Dio();
    NetworkApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppUrl.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => debugPrint(obj.toString()), // Use debugPrint to avoid truncation
    ));
  }
  
  Future<dynamic> getApi({required String urll}) async {
    late var jsonResponse;
    try {
      var response = await await dio.get("${AppUrl.baseUrl}${urll}");
      // print(response);
      jsonResponse = checkREsponse(response);
    } on DioException catch (e) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
    print(e.response?.data);
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    print(e.requestOptions);
    print(e.message);
  }} on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }

  Future postApi({required url, required FormData formData}) async {
    late var jsonResponse;

    try {
      var response = await dio.post("${AppUrl.baseUrl}${url}",
          options: Options(
            headers: {},
          ),
          data: formData);
      // print(response);
      jsonResponse = checkREsponse(response);
    } on DioException catch (e) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
    print(e.response?.data);
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    print(e.requestOptions);
    print(e.message);
    throw FetchDataException(e.message.toString());
  }} on SocketException catch (se) {
  debugPrint("SOCKET EXCEPTION: $se");
  throw FetchDataException("No Internet Connection");
}catch (e, stack) {
  debugPrint("❗️Unhandled Error: $e");
  debugPrint("📌 StackTrace: $stack");
  throw FetchDataException("Unexpected error");
}
    return jsonResponse;
  }
}
