import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/screen_util.dart';
import '../../values/colors.dart';
import '../../values/languages.dart';
import '../../widgets/button.dart';
import '../../widgets/loading.dart';
import '../../widgets/text_field.dart';

import 'controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点空白区域回收键盘
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(), // 禁用回弹
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25.w, right: 25.w, top: 50.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: Languages.supportedLanguages.length > 1,
                            child: Row(children: [
                              Expanded(child: Container()),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: controller.onLanguageClick,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10.w, top: 10.w, bottom: 10.w),
                                  child: Row(
                                    children: [
                                      Text(Languages.currentLanguage.name,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.textNormal),),
                                      Icon(Icons.arrow_drop_down,
                                          color: AppColors.textNormal,
                                          size: 12.w),
                                    ],
                                  ),
                                ),
                              )
                            ],
                            ),
                          ),
                          SizedBox(height: 60.w),
                          Text(LanguageKeys.loginWelcomeBack.tr,
                            style: TextStyle(fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack),),
                          SizedBox(height: 80.w),
                          Container(
                            height: 60.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    12.w)), color: Colors.white),
                            padding: EdgeInsets.only(left: 17.w, right: 17.w),
                            child: buildTextField(
                                controller: controller.usernameController,
                                placeholder: LanguageKeys
                                    .loginAccountPlaceHolder.tr),
                          ),
                          SizedBox(height: 16.w),
                          Container(
                            height: 60.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    12.w)), color: Colors.white),
                            padding: EdgeInsets.only(left: 17.w, right: 17.w),
                            child: buildTextField(
                                controller: controller.passwordController,
                                onEditingComplete: controller.onLoginBtnClick,
                                placeholder: LanguageKeys
                                    .loginPasswordPlaceHolder.tr,
                                obscureText: true),
                          ),
                          SizedBox(height: 30.w),
                          buildButton(title: LanguageKeys.loginButton.tr,
                              onPressed: controller.onLoginBtnClick),
                          SizedBox(height: 20.w),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<LoginController>(builder: (controller) {
                    return Container(child: controller.isLoading
                        ? buildLoading()
                        : Container());
                  }),
                ],
              )
          )
      ),
    ).adaptWebForPC;
  }
}
