import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home/page.dart';
import '../pages/language_list/page.dart';
import '../pages/login/page.dart';
import '../pages/setting/page.dart';
import '../utils/sp_util.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/';

  static const String setting = '/setting';
  static const String languages = '/languages';

  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(),
        middlewares: [LoginGuard()]
    ),
    GetPage(name: home, page: () => HomePage(),
        // middlewares: [NotLoginGuard()]
    ),

    GetPage(name: setting, page: () => SettingPage(),
      // middlewares: [NotLoginGuard()],
    ),
    GetPage(name: languages, page: () => LanguageListPage(),
      middlewares: [NoHomeGuard()],
    ),

  ];

  static void popOrToHome() {
    final route = Get.routing.route;
    if (route == null) return;
    if (route.isFirst) {
      Get.offAllNamed(home);
    } else {
      Get.back();
    }
  }
}

// 需要登录页面，未登录状态返回登录页
class LoginGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (SPUtil.getAccountName().isNotEmpty) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}

// 需要登录页面，未登录状态返回登录页
class NotLoginGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (SPUtil.getAccountName().isEmpty) {
      return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}

// 浏览器刷新时，回到首页
class NoHomeGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.routing.route == null) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}
