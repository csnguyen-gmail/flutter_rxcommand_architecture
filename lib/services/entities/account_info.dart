import 'package:json_annotation/json_annotation.dart';
import 'package:marika_client/helpers/utils.dart';
import 'package:marika_client/services/base_api.dart';

part 'account_info.g.dart';
// flutter packages pub run build_runner build

// info
@JsonSerializable(nullable: true, includeIfNull: false)
class AccountInfo {
  String status;
  String id;
  @JsonKey(toJson: _profileToJson)
  ProfileInfo profile;
  AccountInfo({this.status, this.id, this.profile,});

  factory AccountInfo.anonymous() => AccountInfo(
    profile: ProfileInfo(),
  );

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}
Map<String, dynamic> _profileToJson(ProfileInfo profile) => profile.toJson();

// profile
@JsonSerializable(nullable: true, includeIfNull: false)
class ProfileInfo {
  String name;
  @JsonKey(fromJson: _avatarFromJson)
  String avatar;
  String gender;
  String age;
  ProfileInfo({this.name, this.avatar, this.gender, this.age});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => _$ProfileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}
String _avatarFromJson(String avatar) {
  if (isNotEmpty(avatar)) {
    return BaseApi.s3Url + avatar;
  }
  return null;
}