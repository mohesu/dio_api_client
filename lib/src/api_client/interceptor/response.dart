import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

/// * [ApiResponseInterceptor] is a mixin class that handles API response.
/// * [T] is a generic type of the API response.
/// * [fromMap] is a function that convert API response to [T].
/// * You can override the [responseInterceptor] value in your class.
/// * You can override the [fromMap] value in your class.
mixin ApiResponseInterceptor<T> {
  Interceptor? _interceptor;

  T Function(dynamic data)? fromMap;

  Map<String, String> get jsonHeaders => {
        HttpHeaders.acceptHeader: 'application/json',
      };

  Interceptor get responseInterceptor {
    if (_interceptor != null) return _interceptor!;

    return _interceptor = InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      //onError: _onError,
    );
  }

  // _onError(DioException e, ErrorInterceptorHandler handler) async {
  //   return handler.next(e);
  // }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(jsonHeaders);
    return handler.next(options); //continue
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data == null) {
      //logger.v('Response.data is NULL');
      return handler.next(response);
    }
    var data = response.data;

    if (data is bool || data is int || data is num) {
      //logger.v('Response.data is $data<${data.runtimeType} type>');
      return handler.next(response);
    }

    if (response.data?.isEmpty ?? true) {
      //logger.v('Response.data is empty or unhandled i.e. (${data.runtimeType})');
      return handler.next(response..data = null);
    }

    try {
      if (data is List<int>) {
        data = utf8.decode(data);
      }
    } catch (e) {
      return handler.next(response);
    }

    try {
      if (data is String) data = json.decode(data);
    } catch (e) {
      return handler.next(response..data = data);
    }

    if (fromMap == null) {
      //logger.v('fromMap is null. Sending Response.data as ${data.runtimeType}');
      return handler.next(response..data = data);
    }

    if (response.requestOptions.extra["useFromMap"] ?? true == false) {
      log(
        'extra["useFromMap"] is false. Sending Response.data as ${data.runtimeType}',
        name: 'Error while mapping List',
        error:
            'extra["useFromMap"] is false. Sending Response.data as ${data.runtimeType}',
        stackTrace: StackTrace.current,
      );
      return handler.next(response..data = data);
    }
    try {
      if (data is Map<String, dynamic>) {
        //logger.v('Response.data is Map<String, dynamic>');
        return handler.next(response..data = fromMap!(data));
      }
      if (data is List<dynamic>) {
        //logger.v('Response.data is List');

        return handler.next(response..data = data.map<T>(fromMap!).toList());
      }
    } catch (e) {
      log(
        e.toString(),
        name: 'Error while mapping List',
        error: e,
        stackTrace: StackTrace.current,
      );
      return handler.reject(
          DioException(requestOptions: response.requestOptions, error: e),
          true);
    }

    //logger.e('return data, dataType ${data.runtimeType}');
    return handler.next(response);
  }
}
