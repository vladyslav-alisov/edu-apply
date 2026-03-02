import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_apply/core/error/exceptions.dart';

abstract interface class AuthPersistentDataSource {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
  Future<void> deleteAccessToken();
  Future<void> deleteRefreshToken();
}

const String _accessTokenKey = "accessToken";
const String _refreshTokenKey = "refreshToken";

class AuthPersistentDataSourceSharedPreferencesImpl
    implements AuthPersistentDataSource {
  AuthPersistentDataSourceSharedPreferencesImpl(
      {required SharedPreferences prefs})
      : _sharedPreferences = prefs;

  final SharedPreferences _sharedPreferences;

  @override
  Future<String?> getAccessToken() async {
    try {
      return _sharedPreferences.getString(_accessTokenKey);
    } catch (e) {
      throw PersistenceException(e.toString());
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _sharedPreferences.getString(_refreshTokenKey);
    } catch (e) {
      throw PersistenceException(e.toString());
    }
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    try {
      await _sharedPreferences.setString(_accessTokenKey, accessToken);
    } catch (e) {
      throw PersistenceException(e.toString());
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _sharedPreferences.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw PersistenceException(e.toString());
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    await _sharedPreferences.remove(_accessTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _sharedPreferences.remove(_refreshTokenKey);
  }
}
