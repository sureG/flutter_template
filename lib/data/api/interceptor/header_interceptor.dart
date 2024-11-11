import 'package:dio/dio.dart';

import '../../../utils/sp_util.dart';
import '../../../values/languages.dart';

/// header拦截器
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // options.headers['User-Agent'] = ''; // 添加UserAgent请求头
    options.headers["content-type"] = options.method.toLowerCase() == 'get' ? "application/json" : "application/x-www-form-urlencoded";
    options.headers["token"] = SPUtil.getToken();
    // options.headers["Accept-Language"] = Languages.currentLanguage.locale.languageCode;
    super.onRequest(options, handler);
  }
}
