/*
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotel/utils/logger.dart';

mixin CacheItemData {
  String indexName = "global";

  SharedPreferences storage = appLocator<SharedPreferences>();

  @protected
  Future<void> saveToDisk(dynamic data, [String? altIndex]) async {
    try {
      await _saveToDisk(altIndex ?? indexName, data);
    } catch (e) {
      logger.e("Cannot encode $data", e, StackTrace.current);
    }
  }

  @protected
  Object? getFromDisk([String? altIndex]) {
    return _getFromDisk(altIndex ?? indexName);
  }

  @protected
  List<String>? getListFromDisk([String? altIndex]) {
    return _getListFromDisk(altIndex ?? indexName);
  }

  @protected
  Future<bool> removeIndex([String? altIndex]) async {
    try {
      return await storage.remove(altIndex ?? indexName);
    } catch (e) {
      logger.e("Cannot remove index provided", e, StackTrace.current);
    }
    return false;
  }

  bool exists([String? altIndex]) {
    return (storage.containsKey(altIndex ?? indexName));
  }

  Future<bool> clear() async {
    return await storage.clear();
  }

  Object? _getFromDisk(String key) {
    return storage.get(key);
  }

  List<String>? _getListFromDisk(String key) {
    return storage.getStringList(key);
  }

  Future<bool> _saveToDisk(String key, dynamic content) async {
    if (content is List<String>) {
      return await storage.setStringList(key, content);
    }
    if (content is List<Object>) {
      final List<String> newContent =
          content.map<String>((e) => jsonEncode(e)).toList();
      return await storage.setStringList(key, newContent);
    }

    switch (content.runtimeType) {
      case String:
        return await storage.setString(key, content);
      case bool:
        return await storage.setBool(key, content);
      case int:
        return await storage.setInt(key, content);
      case double:
        return await storage.setDouble(key, content);
      case Null:
        return await storage.remove(key);
      default:
        return await storage.setString(key, jsonEncode(content));
    }
  }
}
*/
