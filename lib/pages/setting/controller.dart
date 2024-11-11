import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../utils/sp_util.dart';
import '../../utils/version_util.dart';
import '../../values/languages.dart';
import '../../widgets/dialog.dart';

class SettingController extends GetxController {

  String get currentLanguage => Languages.currentLanguage.name;
  String? version;
  String? account;

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  _loadData() async {
    version = await VersionUtil.getVersion();
    account = SPUtil.getAccountName();
    update();
  }

  void onLanguage() async {
    if (Languages.supportedLanguages.length <= 1) return;
    final value = await Get.toNamed(Routes.languages);
    if (value != null) {
      update();
    }
  }

  void onCheckVersion() {

  }

  void onLogout() {
    showCustomDialog(
      title: '',
      content: LanguageKeys.settingDialogTitle.tr,
      okStr: LanguageKeys.dialogConfirm.tr,
      onOk: () async {
        await SPUtil.clearLoginInfo();
        Get.offAllNamed(Routes.login);
      },
      cancelStr: LanguageKeys.dialogCancel.tr,
    );
  }
}
