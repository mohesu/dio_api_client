import 'dart:io';

import 'package:dio/dio.dart';

import '../../logger.dart';
import '../../user.dart';

/// * [ApiAuthInterceptor] is a mixin class that handle API authentication.
/// * You can override the [authInterceptor] value in your class.
/// * [ApiClient] is a mixin class, so you can use it with other classes.
/// * [User] is a singleton class that contains user data.
/// * You can override the [user] value in your class.
/// * [token] is a string that contains user/API token.
/// * You can override the [token] value in your class.
/// * You can override the [refreshToken] value in your class.
///
mixin ApiAuthInterceptor {
  String _refreshToken = "";
  Interceptor? _interceptor;

  User? get user => User.instance;

  Interceptor get authInterceptor {
    if (_interceptor != null) return _interceptor!;

    return _interceptor = InterceptorsWrapper(
      onRequest: _onRequest,
      //onResponse: _onResponse,
      onError: _onError,
    );
  }

  String get refreshToken {
    if (_refreshToken.isNotEmpty) return _refreshToken;
    return _refreshToken = "YOUR_REFRESH_TOKEN";
  }

  set refreshToken(String refreshToken) {
    _refreshToken = refreshToken;
  }

  String get token {
    if (user != null && (user?.token?.isNotEmpty ?? false)) {
      logger.v("token: ${user?.token}");
      return user!.token!;
    } else {
      logger.w('No token available', null, StackTrace.current);
      return "";
    }
  }

  _onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      logger.w('Unauthorized', null, StackTrace.current);
      return handler.reject(error);
    }
    return handler.next(error);
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (token.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    return handler.next(options);
  }

  // _onResponse(Response response, ResponseInterceptorHandler handler) async {
  //   return handler.next(response);
  // }
}
