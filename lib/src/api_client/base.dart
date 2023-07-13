import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

import '../logger.dart';
import '../status/error.dart';
import 'client.dart';
import 'interceptor/auth.dart';
import 'interceptor/cache.dart';
import 'interceptor/log.dart';
import 'interceptor/response.dart';

/// * [DioApiClient] mainly used to make API requests.
/// * [DioApiClient] implements [ApiClient], [ApiCacheManager], [ApiAuthInterceptor], [ApiLogInterceptor], and [ApiResponseInterceptor].
/// * [DioApiClient] is a abstract class, so you can't use it directly. You must extend it in your class.
/// * [T] is a generic type that used to parse the API response.
/// * [path] is a string that contains the API endpoint.
/// * [data] is a generic type of response data.
/// * [hasData] is a boolean that returns true if the API response has data.
/// * [interceptors] is a list of [Interceptor] that used to intercept the API request.
/// * [apiRequest] is a method that used to make API requests.
/// * [apiGet] is a method that used to make GET API requests.
/// * [apiPost] is a method that used to make POST API requests.
/// * [apiPut] is a method that used to make PUT API requests.
/// * [apiPatch] is a method that used to make PATCH API requests.
/// * [apiDelete] is a method that used to make DELETE API requests.
/// * [apiHead] is a method that used to make HEAD API requests.
/// * [apiDownload] is a method that used to make DOWNLOAD API requests.
/// * [apiUpload] is a method that used to make UPLOAD API requests.
abstract class DioApiClient<T>
    with
        ApiClient,
        ApiCacheManager,
        ApiAuthInterceptor,
        ApiLogInterceptor,
        ApiResponseInterceptor<T> {
  static late Directory cacheDir;

  static Future<void> init() async {
    cacheDir = await getTemporaryDirectory();
  }

  String path = "random/url";

  T? data;

  bool get hasData => data != null;

  List<Interceptor> get interceptors => kReleaseMode
      ? [
          if (cacheDuration.inMicroseconds > 0) cacheManager,
          authInterceptor,
          responseInterceptor,
        ]
      : [
          if (cacheDuration.inMicroseconds > 0) cacheManager,
          authInterceptor,
          logInterceptor,
          responseInterceptor,
        ];

  @protected
  Future<Response<R?>> apiRequest<R>(
    String path, {
    String method = "GET",
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useInterceptor = true,
  }) async {
    Response<R?> response;
    options ??= Options();
    options.method = method;

    if (useInterceptor) {
      for (var interceptor in interceptors) {
        if (client.interceptors.contains(interceptor)) continue;
        client.interceptors.add(interceptor);
      }
    }

    try {
      try {
        //await _metric.start();
        response = await client.request<R>(path,
            data: data,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);

        //logger.v(response.statusMessage, null, StackTrace.current);
        /// * [responseInterceptor] will throw an [AppError] if the API response has an error.
      } on DioException catch (e) {
        logger.e(e.message, e);
        AppError appError = AppError();
        try {
          appError = AppError.fromJson(e.response?.data);
        } on FormatException catch (e) {
          logger.e(e.runtimeType, StackTrace.current);
          logger.e("$e", e);
        }
        throw appError..stackTrace = e.stackTrace;
      }

      /// * SocketException will throw an [AppError] if there is no internet connection.
    } on SocketException catch (e) {
      logger.e(e.address, e);
      throw AppError(message: 'No Internet connection 😑');

      /// * HttpException will throw an [AppError] if the API endpoint is not found.
    } on HttpException catch (e) {
      logger.e(e.uri, e);
      throw AppError(message: "Couldn't find the destination 😱");

      /// * FormatException will throw an [AppError] if the API response has a bad format.
    } on FormatException catch (e) {
      logger.e(e.source, e);
      throw AppError(message: "Bad response format 👎");

      /// * NetworkImageLoadException will throw an [AppError] if the image URL is not found.
    } on NetworkImageLoadException catch (e) {
      logger.e(e.uri, e);
      throw AppError(message: "Unable to Load Image");

      /// * WebSocketException will throw an [AppError] if the socket connection is not established.
    } on WebSocketException catch (e) {
      logger.e(e.message, e);
      throw AppError(message: "Unable to Connect to Socket");

      /// * AppError will throw an [AppError] if the API response has an error.
    } on AppError catch (e) {
      logger.e("$e", e, e.stackTrace);
      rethrow;
    } catch (e) {
      logger.e("$e", e, StackTrace.current);
      throw AppError();
    }
    return response;
  }

  /// * clearCache method is used to clear the cache.
  @override
  Future<bool> clearCache() async {
    data = null;
    super.clearCache();
    return true;
  }

  @protected
  Future<Response<T?>> get({
    String dynamicPath = "",
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return apiRequest<T>(path + dynamicPath,
        method: "GET",
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @protected
  Future<Response<List<T>?>> getList({
    String dynamicPath = "",
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return apiRequest<List<T>>(path + dynamicPath,
        method: "GET",
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @protected
  Future<Response<T?>> post({
    String dynamicPath = "",
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return apiRequest<T>(path + dynamicPath,
        method: "POST",
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
