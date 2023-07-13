import 'dart:convert';

import 'package:dio_api_client/base_service.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

import 'logger.dart';

/// * [User] is a class that contains user data.
interface class User {
  /// * [name] is a string that contains user name.
  String name;

  /// * [email] is a string that contains user email.
  String email;

  /// * [password] is a string that contains user password.
  String password;

  /// * [phone] is a string that contains user phone number.
  String phone;

  /// * [address] is a string that contains user address.
  String address;

  /// * [isVerified] is a boolean that contains user verification status.
  bool isVerified;

  /// * [token] is a string that contains user/API token.
  String? token;
  User({
    this.name = "",
    this.email = "",
    this.password = "",
    this.phone = "",
    this.address = "",
    this.isVerified = false,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      phone: map['phone'] ?? "",
      address: map['address'] ?? "",
      isVerified: map['isVerified'] ?? false,
      token: map['token'] ?? "",
    );
  }

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
    bool? isVerified,
    String? token,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isVerified: isVerified ?? this.isVerified,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "isVerified": isVerified,
      "token": token,
    };
  }

  @override
  String toString() {
    return "User(name: $name, email: $email, password: $password, phone: $phone, address: $address, isVerified: $isVerified, token: $token)";
  }

  /// * [userHiveKey] is a string that contains user hive key.
  static String userHiveKey = 'userHiveKeyId';

  /// * [cacheStore] is a [CacheStore] that contains user cache store.
  static CacheStore cacheStore = HiveCacheStore(DioApiClient.cacheDir.path);

  static User? _instance;

  /// * [instance] is a [User] user instance.
  static User? get instance {
    if (_instance != null) return _instance;
    cacheStore.get(userHiveKey).then((value) {
      if (value != null) {
        _instance = User.fromJson(jsonDecode(utf8.decode(value.content ?? [])));
      }
    }).catchError((e) {
      logger.e(e);
    });
    return _instance;
  }

  /// * set user in cache memory with hive
  static Future<void> setUser(User user) async {
    _instance = user;
    await cacheStore.set(
      CacheResponse(
        key: userHiveKey,
        content: utf8.encode(jsonEncode(user.toJson())),
        date: DateTime.now(),
        maxStale: null,
        cacheControl: CacheControl(),
        eTag: '',
        expires: null,
        headers: [],
        lastModified: '',
        priority: CachePriority.high,
        requestDate: DateTime.now(),
        responseDate: DateTime.now(),
        url: 'localhost',
      ),
    );
  }
}
