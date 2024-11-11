import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/screen_util.dart';
import '../../values/colors.dart';
import '../../values/languages.dart';
import '../../widgets/loading.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.onAppResume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftPadding = 25.w;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: controller.onSettingClick,
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              child: Icon(Icons.settings, color: AppColors.textNormal, size: 18.w),
                            ),
                          ),
                          SizedBox(width: leftPadding - 10.w, height: 44.w)
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: leftPadding, right: leftPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LanguageKeys.homeTitle.tr, style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack),),
                            SizedBox(height: 30.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<HomeController>(builder: (controller) {
                  return Container(child: controller.isLoading
                      ? buildLoading()
                      : Container());
                }),
              ],
            )
        )
    ).adaptWebForPC;
  }

}
