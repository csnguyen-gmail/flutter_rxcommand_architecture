import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:marika_client/services/base_api.dart';
import 'package:marika_client/services/entities/user_info.dart';

class SignInApi extends BaseApi<UserInfo> {
  Future<UserInfo> signIn(LoginInfo info) {
    var map = info.toJson().cast<String, String>();
    return post(header: map);
  }

  @override
  String apiUrl() {
    return "Accounts/auth";
  }

  @override
  Future<UserInfo> responseParse(String body) {
    return compute<String, UserInfo>(_parse, body);
  }
}

UserInfo _parse(String body) {
  var map = json.decode(body);
  return UserInfo.fromJson(map);
}
