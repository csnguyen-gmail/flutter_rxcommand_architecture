// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
      status: json['status'] as String,
      id: json['id'] as String,
      profile: json['profile'] == null
          ? null
          : ProfileInfo.fromJson(json['profile'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('id', instance.id);
  writeNotNull('profile',
      instance.profile == null ? null : _profileToJson(instance.profile));
  return val;
}

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) {
  return ProfileInfo(
      name: json['name'] as String,
      avatar: json['avatar'] == null
          ? null
          : _avatarFromJson(json['avatar'] as String),
      gender: json['gender'] as String,
      age: json['age'] as String);
}

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('gender', instance.gender);
  writeNotNull('age', instance.age);
  return val;
}
