import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/api/api.dart';
import '../../data/api/my_response.dart';
import '../../routes/routes.dart';
import '../../utils/sp_util.dart';
import '../../values/languages.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void onLoginBtnClick() async {
    Get.toNamed(Routes.home);
    return;
    if (isLoading) return;
    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    isLoading = true;
    update();
    try {
      await API.login(username, password);
      await SPUtil.setAccountName(username);
      Get.offNamed(Routes.home);
    } catch (error) {
      isLoading = false;
      update();
      Get.snackbar(LanguageKeys.loginFailed.tr, MyError.messageFromError(error));
    }
  }

  void onLanguageClick() async {
    final value = await Get.toNamed(Routes.languages);
    if (value != null) {
      update();
    }
  }

}
