import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// * [ApiLogInterceptor] is a mixin class that handle API log.
/// * You can override the [logInterceptor] value in your class.
/// * [ApiClient] is a mixin class, so you can use it with other classes.
mixin ApiLogInterceptor {
  static final Interceptor _interceptor = PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: false,
    maxWidth: 90,
    logPrint: (line) => developer.log(line.toString(), name: "ApiClient"),
  );

  Interceptor get logInterceptor {
    return _interceptor;
  }
}
