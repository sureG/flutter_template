import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../utils/screen_util.dart';
import '../../values/colors.dart';
import '../../values/languages.dart';
import '../../widgets/line.dart';

import 'controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LanguageKeys.settingTitle.tr),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Routes.popOrToHome();
            },
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: GetBuilder<SettingController>(builder: (controller) {
              return Column(children: [
                Container(
                  height: 60.w,
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Text(LanguageKeys.settingAccount.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.textBlack)),
                      Expanded(child: Container()),
                      Text(controller.account ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.textGray)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.w),
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: controller.onLanguage,
                        child: InkWell(
                          child: Row(
                            children: [
                              Text(LanguageKeys.settingLanguage.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: AppColors.textBlack)),
                              Expanded(child: Container()),
                              Text(controller.currentLanguage,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: AppColors.textGray)),
                              SizedBox(width: 6.w, height: 60.w),
                              Icon(Icons.arrow_forward_ios_sharp,
                                  color: AppColors.textGray, size: 12.w),
                            ],
                          ),
                        ),
                      ),
                      buildDottedLine(),
                      GestureDetector(
                        onTap: controller.onCheckVersion,
                        child: Row(
                          children: [
                            Text(LanguageKeys.settingVersion.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: AppColors.textBlack)),
                            Expanded(child: Container()),
                            Text(controller.version ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: AppColors.textGray)),
                            SizedBox(height: 60.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: controller.onLogout,
                  child: Container(
                    height: 60.w,
                    padding: EdgeInsets.only(left: 17.w, right: 17.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.w)),
                        color: Colors.white),
                    child: Center(
                      child: Text(LanguageKeys.settingLogout.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.textBlack)),
                    ),
                  ),
                ),
              ]);
            }),
          ),
        )).adaptWebForPC;
  }
}
