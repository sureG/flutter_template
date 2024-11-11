import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/api/api.dart';
import '../../data/api/my_response.dart';
import '../../routes/routes.dart';
import '../../utils/sp_util.dart';
import '../../utils/version_util.dart';
import '../../values/colors.dart';
import '../../values/languages.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    _checkAppUpdate();
    super.onInit();
  }

  @override
  void onReady() {
    _onResume();
    super.onReady();
  }

  var _isLoadingDeviceStock = false;
  void _loadData() async {
    if (_isLoadingDeviceStock) return;
    _isLoadingDeviceStock = true;
    final userName = SPUtil.getAccountName();
    try {
      _isLoadingDeviceStock = false;
      update();
    } catch (error) {
      _isLoadingDeviceStock = false;
      print(MyError.messageFromError(error));
    }
  }

  static var _didShowUpgrade = false;
  void _checkAppUpdate() async {
    if (kIsWeb || !GetPlatform.isAndroid) return;
    if (_didShowUpgrade) return;
    final version = await VersionUtil.getVersion();
    try {
      final versionInfo = await API.checkAppUpdate(version);
      if (_didShowUpgrade) return;
      if (versionInfo.version != version) {
        _didShowUpgrade = true;
        final forcedUpgrade = versionInfo.forceUpdate;
        showDialog(context: Get.context!,
            barrierDismissible: !forcedUpgrade,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () => Future.value(!forcedUpgrade),
                child: AlertDialog(
                  title: Text(LanguageKeys.appUpdateTitle.tr),
                  content: Text(versionInfo.updateInfo ?? ''),
                  actions: <Widget>[
                    if (!forcedUpgrade)
                      TextButton(
                        child: Text(LanguageKeys.dialogCancel.tr, style: TextStyle(color: AppColors.textBlue)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    TextButton(
                      child: Text(LanguageKeys.appUpdateButton.tr, style: TextStyle(color: AppColors.textBlue)),
                      onPressed: () {
                        _appUpdate(versionInfo.downloadUrl);
                        if (!forcedUpgrade) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              );
            });
      }

      print(versionInfo);
    } catch (error) {
      print(MyError.messageFromError(error));
    }
  }

  _appUpdate(String url) {

  }

  var isLoading = false;

  /// 点击设置
  void onSettingClick() async {
    await Get.toNamed(Routes.setting);
    _onResume();
  }

  /// 返回到当前页面时触发
  _onResume() {
    _loadData();
  }

  /// app从后台回到前台
  void onAppResume() {
    _onResume();
    _checkAppUpdate();
  }

}
