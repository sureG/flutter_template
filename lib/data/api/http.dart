import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../utils/config_util.dart';

import 'interceptor/header_interceptor.dart';
import 'interceptor/logs_interceptor.dart';

class HttpOptions {
  //地址域名前缀
  static final String baseUrl = ConfigUtil.isDebugMode() ? 'http://api-ts.example.com/' : 'http://api.example.com/';

  // 超时时间
  static const Duration timeoutDefault = Duration(seconds: 30);
  static const Duration timeoutConnect = timeoutDefault;
  static const Duration timeoutReceive = timeoutDefault;
  static const Duration timeoutSend = timeoutDefault;

}

class HttpRequest {
  // 单例模式使用Http类，
  static final HttpRequest _instance = HttpRequest._();

  factory HttpRequest() => _instance;

  late final Dio dio;

  /// 内部构造方法
  HttpRequest._() {
    /// 初始化dio
    final options = BaseOptions(
        connectTimeout: HttpOptions.timeoutConnect,
        receiveTimeout: HttpOptions.timeoutReceive,
        sendTimeout: HttpOptions.timeoutSend,
        baseUrl: HttpOptions.baseUrl);

    dio = Dio(options);

    /// 添加各种拦截器
    dio.interceptors
        ..add(HeaderInterceptor())
        ..add(LogsInterceptor());
  }

  /// 封装request方法
  Future request({
    required String path, //接口地址
    required HttpMethod method, //请求方式
    dynamic data, //数据
    Map<String, dynamic>? queryParameters,
    bool showLoading = true, //加载过程
    bool showErrorMessage = true, //返回数据
  }) async {
    const Map methodValues = {
      HttpMethod.get: 'get',
      HttpMethod.post: 'post',
      HttpMethod.put: 'put',
      HttpMethod.delete: 'delete',
      HttpMethod.patch: 'patch',
      HttpMethod.head: 'head'
    };

    //动态添加header头
    Map<String, dynamic> headers = <String, dynamic>{};
    headers["version"] = "1.0.0";

    Options options = Options(
      method: methodValues[method],
      headers: headers,
    );

    try {
      if (showLoading) {
        //EasyLoading.show(status: 'loading...');
      }
      Response response = await HttpRequest().dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (error) {
      final httpException = error.error;
      if (showErrorMessage) {
        //EasyLoading.showToast(httpException.msg);
      }
    } finally {
      if (showLoading) {
        //EasyLoading.dismiss();
      }
    }
  }
}

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  head,
}