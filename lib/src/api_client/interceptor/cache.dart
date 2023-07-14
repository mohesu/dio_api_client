import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

import '../../../dio_api_client.dart';

/// * ApiCacheManager is a mixin class that handle API cache.
/// * You can override the [cacheManager] value in your class.
/// * [ApiClient] is a mixin class, so you can use it with other classes.
mixin ApiCacheManager on ApiClient {
  Duration cacheDuration = const Duration(days: 1);
  DioCacheInterceptor? _cacheManager;
  late CacheStore cacheStore = HiveCacheStore(DioApiClient.cacheDir.path);
  DioCacheInterceptor get cacheManager {
    if (_cacheManager != null) return _cacheManager!;
    // Global options
    final options = CacheOptions(
      // A default store is required for interceptor.
      store: cacheStore,
      policy: CachePolicy.request,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behavior is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
    return _cacheManager = DioCacheInterceptor(
      options: options,
    );
  }

  /// * [cacheManager] is a DioCacheInterceptor for cache requests.
  set cacheManager(DioCacheInterceptor cacheManager) {
    _cacheManager = cacheManager;
  }

  /// * [cacheStore] is a CacheStore for cache requests.
  clearCache() {
    cacheStore.clean();
  }
}
