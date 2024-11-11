import 'dart:ui';

import 'package:get/get.dart';
import '../utils/sp_util.dart';

class LanguageItem {
  final String name;
  final Locale locale;

  const LanguageItem(this.name, this.locale);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is LanguageItem && name == other.name && locale == other.locale;
  }

  @override
  int get hashCode => name.hashCode ^ locale.hashCode;
}

class Languages extends Translations {

  static final supportedLanguages = [
    const LanguageItem('中文', chineseLocale),
    const LanguageItem('English', englishLocale),
  ];

  /// 获取当前选中的语言
  static LanguageItem get currentLanguage {
    final locale = _currentLocale ?? defaultLocale;
    // 精确查找
    for (var item in supportedLanguages) {
      if (item.locale == locale) {
        return item;
      }
    }
    // 模糊查找
    for (var item in supportedLanguages) {
      if (item.locale.languageCode == locale.languageCode) {
        return item;
      }
    }
    /// 未找到，返回第一个
    return supportedLanguages.first;
  }

  static const Locale chineseLocale = Locale('zh', 'Hans'); //Locale('en', 'US');
  static const Locale englishLocale = Locale('en', 'US');
  static const Locale defaultLocale = chineseLocale;

  static Locale? _currentLocale;
  static initCurrentLocale(String languageCode) {
    if (_currentLocale != null || languageCode.isEmpty) return;
    for (var item in supportedLanguages) {
      if (item.locale.languageCode == languageCode) {
        _currentLocale = item.locale;
        break;
      }
    }
  }

  /// 获取当前设置的语言，未设置时返回当前设备语言
  static Locale? currentLocale() {
    _currentLocale ??= Get.deviceLocale;
    return _currentLocale;
  }


  /// 切换当前显示的语言
  static updateLocale(Locale locale) async {
    _currentLocale = locale;
    Get.updateLocale(locale);
    SPUtil.setLanguageCode(locale.languageCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'zh_Hans': {
      LanguageKeys.loginWelcomeBack: '登录',
      LanguageKeys.loginAccountPlaceHolder: '账号',
      LanguageKeys.loginPasswordPlaceHolder: '密码',
      LanguageKeys.loginButton: '登录',
      LanguageKeys.loginFailed: '登录失败',

      LanguageKeys.homeTitle: '标题',

      LanguageKeys.settingTitle: '设置',
      LanguageKeys.settingAccount: '账号',
      LanguageKeys.settingLanguage: '语言',
      LanguageKeys.settingVersion: '版本',
      LanguageKeys.settingLogout: '退出登录',
      LanguageKeys.settingDialogTitle: '是否确定退出？',
      LanguageKeys.dialogCancel: '取消',
      LanguageKeys.dialogConfirm: '确定',
      LanguageKeys.loading: '加载中...',
      LanguageKeys.noData: '没有查询到数据',
      LanguageKeys.networkError: '网络出错，无法加载',
      LanguageKeys.retry: '重试',

      LanguageKeys.appUpdateTitle: '发现新版本',
      LanguageKeys.appUpdateButton: '升级',
    },
    'en_US': {
      LanguageKeys.loginWelcomeBack: 'Login',
      LanguageKeys.loginAccountPlaceHolder: 'Username',
      LanguageKeys.loginPasswordPlaceHolder: 'Password',
      LanguageKeys.loginButton: 'Login',
      LanguageKeys.loginFailed: 'Login failed',

      LanguageKeys.homeTitle: 'Title',

      LanguageKeys.settingTitle: 'Settings',
      LanguageKeys.settingAccount: 'Account',
      LanguageKeys.settingLanguage: 'Language',
      LanguageKeys.settingVersion: 'Version',
      LanguageKeys.settingLogout: 'Logout',
      LanguageKeys.settingDialogTitle: 'Are you sure you want to exit?',
      LanguageKeys.dialogCancel: 'Cancel',
      LanguageKeys.dialogConfirm: 'Confirm',
      LanguageKeys.loading: 'Loading...',
      LanguageKeys.noData: 'No data',
      LanguageKeys.networkError: 'Network error',
      LanguageKeys.retry: 'Retry',

      LanguageKeys.appUpdateTitle: 'New Version',
      LanguageKeys.appUpdateButton: 'Upgrade',
    },
  };
}

class LanguageKeys {
  // 登录页
  static const String loginWelcomeBack = 'loginWelcomeBack';
  static const String loginAccountPlaceHolder = 'loginAccountPlaceHolder';
  static const String loginPasswordPlaceHolder = 'loginPasswordPlaceHolder';
  static const String loginButton = 'loginButton';
  static const String loginFailed = 'loginFailed';

  // 首页
  static const String homeTitle = 'homeTitle';

  // 设置页
  static const String settingTitle = 'settingTitle';
  static const String settingAccount = 'settingAccount';
  static const String settingLanguage = 'settingLanguage';
  static const String settingVersion = 'settingVersion';
  static const String settingLogout = 'settingLogout';
  static const String settingDialogTitle = 'settingDialogTitle';

  static const String dialogCancel = 'dialogCancel';
  static const String dialogConfirm = 'dialogConfirm';

  static const String loading = 'loading';
  static const String noData = 'noData';
  static const String networkError = 'networkError';
  static const String retry = 'retry';

  static const String appUpdateTitle = 'appUpdateTitle';
  static const String appUpdateButton = 'appUpdateButton';

}