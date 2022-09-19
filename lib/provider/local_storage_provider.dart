import 'dart:convert';

import 'package:demo_web/domain/entities/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageProvider {
  AppUserInfo? getUserInfo();

  void setUserInfo(AppUserInfo? appUserInfo);
}

class LocalStorageProviderImpl implements LocalStorageProvider {
  static const String USER_INFO_KEY = 'app_user_info';

  final SharedPreferences _sharedPreferences;

  LocalStorageProviderImpl._(this._sharedPreferences);

  static LocalStorageProviderImpl init(SharedPreferences sharedPreferences) {
    return LocalStorageProviderImpl._(sharedPreferences);
  }

  @override
  AppUserInfo? getUserInfo() {
    final raw = _sharedPreferences.getString(USER_INFO_KEY);
    if (raw != null) {
      final Map<String, dynamic> json = jsonDecode(raw);
      AppUserInfo? userInfo = AppUserInfo.fromJson(json);
      return userInfo;
    }
    return null;
  }

  @override
  void setUserInfo(AppUserInfo? appUserInfo) {
    if (appUserInfo != null) {
      final json = appUserInfo.toJson();
      final rawData = jsonEncode(json);
      _sharedPreferences.setString(USER_INFO_KEY, rawData);
    } else {
      _sharedPreferences.setString(USER_INFO_KEY, '');
    }
  }
}
