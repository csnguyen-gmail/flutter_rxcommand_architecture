import 'dart:async';

import 'package:marika_client/services/account_api.dart';
import 'package:marika_client/services/entities/user_info.dart';
import 'package:marika_client/services/local_storage.dart';
import 'package:marika_client/services/signin_api.dart';
import 'package:rx_command/rx_command.dart';
import 'package:marika_client/blocs/bloc_provider.dart';
import 'package:marika_client/services/entities/account_info.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  // common
  RxCommand<LoginInfo, void> setupCommand;
  RxCommand<void, void> cleanCommand;
  RxCommand<AccountInfo, AccountInfo> accountInfoCommand;

  // error catcher
  Observable uiExceptionStream;

  ApplicationBloc() {
    setupCommand = RxCommand.createAsyncNoResult<LoginInfo>((loginInfo) async {
      // login if require
      if (loginInfo != null) {
        var userInfo = await SignInApi().signIn(loginInfo);
        await LocalStorage().setInfo<UserInfo>(userInfo, hasSave: true);
      }

      // parallel load resource
      var futureAccount = AccountApi().getAccount();
      var results = await Future.wait<dynamic>([
        futureAccount,
      ]);

      // divide to others commands
      var account = results[0] as AccountInfo;
      accountInfoCommand.execute(account);
    });

    cleanCommand = RxCommand.createAsyncNoParamNoResult(() async {
      await LocalStorage().resetAllInfo();
      accountInfoCommand.execute(null);
    });

    accountInfoCommand = RxCommand.createSync<AccountInfo, AccountInfo>((account) => account,
        emitsLastValueToNewSubscriptions: true);

    // error catcher
    uiExceptionStream = Observable.merge([
      setupCommand.thrownExceptions,
    ]).asBroadcastStream();
  }

  void dispose() {
    setupCommand.dispose();
    cleanCommand.dispose();
    accountInfoCommand.dispose();
  }
}