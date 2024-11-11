import 'package:get/get.dart';
import '../../utils/log.dart';
import '../../values/languages.dart';

class MyResponse {
  /// 0000 代表成功
  final String key;
  final String msg;
  dynamic data;

  MyResponse.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        msg = json['msg'],
        data = json['data'];

  get isSuccess {
    return key == '0000';
  }

  MyError? get error {
    if (isSuccess) {
      return null;
    }
    return MyError(key, msg);
  }
}

class MyError implements Exception {
  final String key;
  final String msg;

  MyError(this.key, this.msg);

  static String messageFromError(dynamic error) {
    if (error is MyError) {
      return error.msg.tr;
    }
    Log.d('network error:$error');
    return LanguageKeys.networkError.tr;
  }

  static String logFromError(dynamic error) {
    if (error is MyError) {
      return error.msg;
    }
    return error.toString();
  }
}