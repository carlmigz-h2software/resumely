import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resumely/core/errors/exceptions.dart';
import 'package:resumely/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
}

const String cachedUserKey = 'CACHED_USER_KEY';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await sharedPreferences.setString(cachedUserKey, jsonString);
    } catch (e) {
      throw const CacheException(message: 'Failed to cache user session');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(cachedUserKey);
      if (jsonString != null) {
        return UserModel.fromJson(jsonDecode(jsonString));
      }
      return null;
    } catch (e) {
      throw const CacheException(message: 'Failed to retrieve cached user');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(cachedUserKey);
    } catch (e) {
      throw const CacheException(message: 'Failed to clear user cache');
    }
  }
}
