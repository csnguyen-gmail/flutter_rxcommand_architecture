// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      id: json['id'] as String,
      ttl: json['ttl'] as int,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      userId: json['userId'] as String,
      role: json['role'] as int);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'ttl': instance.ttl,
      'created': instance.created?.toIso8601String(),
      'userId': instance.userId,
      'role': instance.role
    };

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) {
  return LoginInfo(name: json['name'] as String, pass: json['pass'] as String);
}

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) =>
    <String, dynamic>{'name': instance.name, 'pass': instance.pass};
