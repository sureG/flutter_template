import 'package:flutter/cupertino.dart';
import '../utils/screen_util.dart';
import '../values/colors.dart';

Widget buildTextField({
  TextEditingController? controller,
  String? placeholder,
  bool obscureText = false,
  bool isCodeInput = false,
  bool keyboardNumber = false,
  int fontSize = 14,
  VoidCallback? onEditingComplete}) {
  // iOS样式
  return CupertinoTextField(
      controller: controller,
      obscureText: obscureText,
      placeholder: placeholder,
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: keyboardNumber ? TextInputType.number : null,
      onEditingComplete: onEditingComplete,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize.sp, color: AppColors.textBlack),
      cursorColor: AppColors.textBlue,
      decoration: null);
}