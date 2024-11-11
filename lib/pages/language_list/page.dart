import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../utils/screen_util.dart';
import '../../values/colors.dart';
import '../../values/languages.dart';
import '../../widgets/line.dart';

import 'controller.dart';

class LanguageListPage extends StatelessWidget {
  LanguageListPage({super.key});

  final controller = Get.put(LanguageListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LanguageKeys.settingLanguage.tr),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Routes.popOrToHome();
            },
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: GetBuilder<LanguageListController>(builder: (controller) {
                  return ListView.builder(
              itemCount: Languages.supportedLanguages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.onItemClick(index);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: _buildItem(index)
                  )
                );
              });
            }
            )
        )
    ).adaptWebForPC;
  }

  _buildItem(int index) {
    final item = Languages.supportedLanguages[index];
    final isSelected = item == Languages.currentLanguage;
    final isLast = index == Languages.supportedLanguages.length - 1;
    final content = Row(
      children: [
        SizedBox(width: 17.w, height: 60.w),
        Text(
          item.name,
          style: TextStyle(color: AppColors.textBlack, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        Expanded(child: Container()),
        Visibility(
          visible: isSelected,
          child: Icon(Icons.check,
              color: AppColors.textBlue, size: 18.w),
        ),
        SizedBox(width: 17.w)
      ],
    );
    if (isLast) {
      return Container(
        margin: EdgeInsets.only(bottom: 25.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.w), bottomRight: Radius.circular(12.w)), color: Colors.white),
        child: content,
      );
    } else if (index == 0) {
      return Container(
        margin: EdgeInsets.only(top: 25.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12.w), topRight: Radius.circular(12.w)), color: Colors.white),
        child: Column(
          children: [
            content,
            buildDottedLine(padding: 17.w)
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          content,
          buildDottedLine(padding: 17.w)
        ],
      ),
    );
  }
}
