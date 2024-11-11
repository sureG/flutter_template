
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/screen_util.dart';
import '../values/colors.dart';

Widget buildButton({required String title, int fontSize = 16, double height = 60, VoidCallback? onPressed}) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          height: height.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.w),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textBlue,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: fontSize.sp, fontWeight: FontWeight.bold)),
                onPressed: onPressed,
                child: Text(title)
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildOutlinedButton({required String title, int fontSize = 16, double height = 60, VoidCallback? onPressed}) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          height: height.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.w),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: fontSize.sp, fontWeight: FontWeight.bold),
                    foregroundColor: AppColors.textBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w), // 设置边框圆角
                    ),
                    side: const BorderSide(color: AppColors.textBlue),
                ),
                onPressed: onPressed,
                child: Text(title)
            ),
          ),
        ),
      ),
    ],
  );
}

_buildButtonForPlatform({required String title, required double fontSize, VoidCallback? onPressed}) {
  final text = Text(title, style: TextStyle(fontSize: fontSize));
  if (Platform.isIOS) {
    return CupertinoButton(
        onPressed: onPressed, child: text);
  } else if (kIsWeb) {
    return TextButton(onPressed: onPressed, child: Text(title));
  }
  return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: fontSize)),
      onPressed: onPressed,
      child: Text(title)
  );
}