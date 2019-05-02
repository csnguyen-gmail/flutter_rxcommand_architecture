import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';
// flutter packages pub run build_runner build

@JsonSerializable(nullable: true)
class UserInfo {
  String id;
  int ttl;
  DateTime created;
  String userId;
  int role;
  UserInfo({this.id, this.ttl, this.created, this.userId, this.role});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable(nullable: true)
class LoginInfo {
  String name;
  String pass;
  LoginInfo({this.name, this.pass,});

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}
