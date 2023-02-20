// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:demo_web/domain/entities/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageProvider {
  AppUserInfo? getUserInfo();

  void setUserInfo(AppUserInfo? appUserInfo);

  void setCurrentRoute(String route);

  String getCurrentRoute();
}

class LocalStorageProviderImpl implements LocalStorageProvider {
  static const String USER_INFO_KEY = 'app_user_info';
  static const String CURRENT_ROUTE_KEY = 'current_route_key';

  static LocalStorageProviderImpl? _instance;
  final SharedPreferences _sharedPreferences;

  LocalStorageProviderImpl._(this._sharedPreferences);
  factory LocalStorageProviderImpl() {
    if (_instance == null) {
      throw 'need call init Storage';
    }
    return _instance!;
  }
  static Future init() async {
    if (_instance != null) {
      throw 'Storage had inited';
    }
    _instance =
        LocalStorageProviderImpl._(await SharedPreferences.getInstance());
    return;
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

  @override
  String getCurrentRoute() {
    return _sharedPreferences.getString(CURRENT_ROUTE_KEY) ?? '';
  }

  @override
  void setCurrentRoute(String route) {
    _sharedPreferences.setString(CURRENT_ROUTE_KEY, route);
  }
}
