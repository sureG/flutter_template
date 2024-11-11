// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult()
  ..userId = json['userId'] as int
  ..token = json['token'] as String
  ..userName = json['userName'] as String?
  ..status = json['status'] as int;

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'userName': instance.userName,
      'status': instance.status,
    };
