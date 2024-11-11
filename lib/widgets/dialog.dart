import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/screen_util.dart';
import '../values/colors.dart';

import 'button.dart';

void showCustomOKDialog(String content) {
  showCustomDialog(content: content, okStr: 'OK');
}

void showCustomDialog(
    {String? title,
      String? content,
      TextStyle? contentStyle,
      Widget? subContent,
      String? okStr,
      VoidCallback? onOk,
      String? cancelStr,
      VoidCallback? onCancel,
      bool barrierDismissible = true}) {
  var actions = <Widget>[];
  int actionCount = 0;
  if (cancelStr != null) actionCount++;
  if (okStr != null) actionCount++;

  if (cancelStr != null) {
    final button = buildOutlinedButton(
        title: cancelStr,
        height: 40,
        onPressed: () {
          Get.back();
          if (onCancel != null) {
            onCancel();
          }
        });
    if (actionCount > 1) {
      actions.add(Expanded(flex: 1, child: button));
    } else {
      actions.add(SizedBox(width: 143.w, child: button));
    }
  }

  if (okStr != null) {
    final button = buildButton(
        title: okStr,
        height: 40,
        onPressed: () {
          Get.back();
          if (onOk != null) {
            onOk();
          }
        });
    if (actionCount > 1) {
      actions.add(SizedBox(width: 11.w));
      actions.add(Expanded(flex: 1, child: button));
    } else {
      actions.add(SizedBox(width: 143.w, child: button));
    }
  }

  Widget? contentWidget = content != null ? Text(content,
    textAlign: TextAlign.center,
    style: contentStyle ?? TextStyle(color: AppColors.textBlack, fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.5,
      // backgroundColor: Colors.blue
    ),
  ) : null;
  if (subContent != null) {
    if (contentWidget == null) {
      contentWidget = subContent;
    } else {
      contentWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          contentWidget,
          subContent
        ],
      );
    }
  }

  Widget dialog = AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder( // 设置圆角
      borderRadius: BorderRadius.circular(14.w),
    ),
    title: Center(
      child: Text(title ?? '',
        style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600,
          // backgroundColor: Colors.blue
        ),
      ).paddingSymmetric(horizontal: 15.w),
    ),
    content: contentWidget,
    // scrollable: subContent != null,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions,
      )
    ],
    actionsPadding: EdgeInsets.only(bottom: 30.w, left: 20.w, right: 20.w),
    contentPadding: EdgeInsets.only(left: 21.w, right: 21.w, bottom: 25.w),
    titlePadding: EdgeInsets.only(top: title?.isNotEmpty == true ? 32.w : 0, bottom: title?.isNotEmpty == true ? 20.w : 10.w),
  );
  if (!barrierDismissible) {
    dialog = WillPopScope(child: dialog,
        onWillPop: () async {
          return false;
        });
  }
  Get.dialog(dialog,
    barrierDismissible: barrierDismissible,
  );
}
