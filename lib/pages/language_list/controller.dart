import 'package:get/get.dart';
import '../../values/languages.dart';

class LanguageListController extends GetxController {

  void onItemClick(int index) {
    final language = Languages.supportedLanguages[index];
    if (language == Languages.currentLanguage) return;
    Languages.updateLocale(language.locale);
    Get.back(result: index);
  }

}
