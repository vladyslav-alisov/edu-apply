import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppSettingsLocalDataSource {
  Future<ThemeMode> getTheme();

  Future<bool> saveTheme(ThemeMode theme);

  Future<String> getLanguageCode();

  Future<bool> saveLanguageCode(String langCode);
}

class AppSettingsLocalDataSourceImpl implements AppSettingsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  static const String _langCodeKey = "langCode";
  static const String _themeKey = "theme";

  AppSettingsLocalDataSourceImpl(
    SharedPreferences sharedPrefs,
  ) : _sharedPreferences = sharedPrefs;

  @override
  Future<String> getLanguageCode() async {
    return _sharedPreferences.getString(_langCodeKey) ?? "en";
  }

  @override
  Future<ThemeMode> getTheme() async {
    String? theme = _sharedPreferences.getString(_themeKey);

    ThemeMode themeMode = switch (theme) {
      "system" => ThemeMode.system,
      "dark" => ThemeMode.dark,
      "light" => ThemeMode.light,
      _ => ThemeMode.system,
    };

    return themeMode;
  }

  @override
  Future<bool> saveLanguageCode(String langCode) async {
    return await _sharedPreferences.setString(_langCodeKey, langCode);
  }

  @override
  Future<bool> saveTheme(ThemeMode theme) async {
    return await _sharedPreferences.setString(_themeKey, theme.name);
  }
}
