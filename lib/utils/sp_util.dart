import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SharedPreferences? _sharedPreferences;
  static Future<void> initSharedPreferences() async {
    if (_sharedPreferences == null) {
      final sp = await SharedPreferences.getInstance();
      _sharedPreferences = sp;
      _updateLogInState();
    }
  }

  static Future<SharedPreferences> _getSP() async {
    await initSharedPreferences();
    return _sharedPreferences!;
  }

  static var isLoggedInState = false.obs;
  static _updateLogInState() {
    bool res = isLogin();
    isLoggedInState.value = res;
  }

  static const String _accountNameKey = 'ACCOUNT_NAME';
  static Future<void> setAccountName(String account) async {
    final sp = await _getSP();
    await sp.setString(_accountNameKey, account);
    _updateLogInState();
  }

  static String getAccountName() {
    return _sharedPreferences?.getString(_accountNameKey) ?? '';
  }

  static const String _tokenKey = 'TOKEN';
  static Future<void> setToken(String token) async {
    final sp = await _getSP();
    await sp.setString(_tokenKey, token);
    _updateLogInState();
  }

  static String getToken() {
    return _sharedPreferences?.getString(_tokenKey) ?? ''; // 0ee0ade4-19c0-4ae5-8a45-0d68f1b22370
  }

  static bool isLogin() {
    return getToken().isNotEmpty && getAccountName().isNotEmpty;
  }

  static Future<void> clearLoginInfo() async {
    final sp = await _getSP();
    await sp.remove(_tokenKey);
    await sp.remove(_accountNameKey);
    _updateLogInState();
  }

  static const String _languageCodeKey = 'LANGUAGE_CODE';
  static Future<void> setLanguageCode(String code) async {
    final sp = await _getSP();
    await sp.setString(_languageCodeKey, code);
  }

  static String getLanguageCode() {
    return _sharedPreferences?.getString(_languageCodeKey) ?? '';
  }

}