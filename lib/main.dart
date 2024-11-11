import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/routes.dart';
import 'utils/screen_util.dart';
import 'utils/sp_util.dart';
import 'values/languages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.initSharedPreferences();
  Languages.initCurrentLocale(SPUtil.getLanguageCode());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final whiteSwatch = MaterialColor(
      Colors.white.value,
      const <int, Color>{
        50: Colors.white,
        100: Colors.white,
        200: Colors.white,
        300: Colors.white,
        400: Colors.white,
        500: Colors.white,
        600: Colors.white,
        700: Colors.white,
        800: Colors.white,
        900: Colors.white,
      },
    );
    final account = SPUtil.getAccountName();
    final initialRoute = account.isNotEmpty ? Routes.home : Routes.login;
    return GetMaterialApp(
      translations: Languages(),
      locale: Languages.currentLocale(),
      fallbackLocale: Languages.defaultLocale,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: whiteSwatch,
        appBarTheme: const AppBarTheme(
          centerTitle: true, // 安卓上标题也居中显示
          elevation: 0, // 去除阴影
        ),
      ),
      initialRoute: initialRoute,
      getPages: Routes.getPages,
      defaultTransition: ScreenUtil.isPCScreen() ? Transition.noTransition : null, // PC端不显示场景动画
      title: 'App Title', // 安卓应用退后台时显示的应用名
    );
  }
}

