import 'package:flutter/foundation.dart';

class ConfigUtil {

  static bool isDebugMode() {
    // return false;
    return kDebugMode;
  }

  static bool showAllLog() {
    return isDebugMode();
  }
}