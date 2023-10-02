import 'package:dio/dio.dart';

/// * [ApiClient] is a class that contains API client data.
/// * [isSecure] is a boolean that set the API client to use HTTPS or HTTP.
/// * [endpoint] is a string that contains the API client endpoint.
/// * You can override the [isSecure] and [endpoint] values in your class.
/// * [client] is a Dio for HTTP requests.
/// * You can override the [client] value in your class.
/// * [ApiClient] is a mixin class, so you can use it with other classes.
mixin ApiClient {
  final bool isSecure = true;
  final String endpoint = 'api.github.com';

  Dio? _client;

  Dio get client {
    if (_client != null) return _client!;

    final Dio dio = Dio()
      ..options.baseUrl = ((isSecure) ? "https://" : "http://") + endpoint
      ..options.method = 'GET';

    return _client = dio;
  }

  set client(Dio client) {
    _client = client;
  }
}
