import 'dart:developer';

import 'package:dio/dio.dart';
import '../../utils/config_util.dart';
import 'my_response.dart';
import 'http.dart';
import '../model/login_result.dart';
import '../model/version_info.dart';

class API {

  /// 登录
  static Future<LoginResult> login(String userName, String passWord, {CancelToken? cancelToken}) async {
    final res = await request(path: '/user/login', params: {
      'userName': userName,
      'password': passWord,
    }, usePost: true, cancelToken: cancelToken);
    final response = toMyResponse(res);
    return LoginResult.fromJson(response.data);
  }

  /// 检查版本更新
  static Future<VersionInfo> checkAppUpdate(String versionNumber) async {
    final params = {'versionNumber': versionNumber};
    final response = await request(path: '/version/check/update', params: params, usePost: true);
    return VersionInfo.fromJson(toMyResponse(response).data);
  }

  static Future<Response> request({
    required String path,
    required Map<String, dynamic> params,
    bool usePost = false,
    CancelToken? cancelToken}) async {
    Response response;
    if (usePost) {
      response = await HttpRequest()
          .dio.post(path, data: params, cancelToken: cancelToken);
    } else {
      response = await HttpRequest()
          .dio.get(path, queryParameters: params, cancelToken: cancelToken);
    }

    if (ConfigUtil.showAllLog()) {
      log('request:$path params:$params');
      log('response:${response.toString()}'); // 转成json文件看value类型
    }
    return response;
  }

  static MyResponse toMyResponse(Response response) {
    Map<String, dynamic> dic = response.data;
    MyResponse myResponse = MyResponse.fromJson(dic);
    final error = myResponse.error;
    if (error != null) {
      throw(error);
    }
    return myResponse;
  }

  static List<T> modelListFromData<T>({
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    if (data is! List) {
      throw MyError('', 'Data parsing exception.');
    }
    final list = <T>[];
    for (var item in data) {
      list.add(fromJson(item));
    }
    return list;
  }

}