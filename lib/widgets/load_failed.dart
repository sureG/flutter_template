
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/screen_util.dart';
import '../values/languages.dart';
import '../widgets/button.dart';

Widget buildLoadFailed(VoidCallback onPressed) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Text(LanguageKeys.networkError.tr),
    SizedBox(
      height: 40.w,
    ),
    buildButton(
        title: LanguageKeys.retry.tr,
        onPressed: onPressed),
  ]);
}