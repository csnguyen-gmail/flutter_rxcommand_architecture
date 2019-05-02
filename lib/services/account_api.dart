import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:marika_client/services/base_api.dart';
import 'package:marika_client/services/entities/account_info.dart';

// info
class AccountApi extends BaseApi<AccountInfo> {
  Future<AccountInfo> getAccount() {
    return get(needToken: true);
  }

  @override
  String apiUrl() {
    return "Accounts/info";
  }

  @override
  Future<AccountInfo> responseParse(String body) {
    return compute<String, AccountInfo>(_infoParse, body);
  }
}

AccountInfo _infoParse(String body) {
  var map = json.decode(body);
  return AccountInfo.fromJson(map);
}