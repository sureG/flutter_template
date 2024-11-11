import 'package:dio/dio.dart';
import '../../../utils/config_util.dart';
import '../../../utils/log.dart';

/// Log 拦截器
class LogsInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (ConfigUtil.isDebugMode()) {
      final buffer = StringBuffer();
      buffer
        ..write(options.method)
        ..write(' ')
        ..write(options.uri)
        ..write('\n');
      options.headers.forEach((key, v) => buffer.write('\n  $key:$v'));
      buffer.write('\n\n${options.data}');
      Log.d(buffer.toString());
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (ConfigUtil.isDebugMode()) {
      final buffer = StringBuffer();
      buffer..write('code:${response.statusCode}')..write('\n');

      response.headers.forEach((key, v) => buffer.write('\n  $key:$v'));
      buffer.write('\n\n${response.data}');
      Log.d(buffer.toString());
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (ConfigUtil.isDebugMode()) {
      final buffer = StringBuffer();
      buffer..write('code:${err.response?.statusCode}')..write('\n');
      buffer.write('\n\n${err.toString()}');
      buffer.write('\n${err.response?.toString()}');
      Log.e(buffer.toString());
    }
    super.onError(err, handler);
  }
}
