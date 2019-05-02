
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marika_client/blocs/application_bloc.dart';
import 'package:marika_client/blocs/bloc_provider.dart';
import 'package:marika_client/helpers/custom_route.dart';
import 'package:marika_client/pages/login_page.dart';
import 'package:marika_client/pages/main_page.dart';
import 'package:marika_client/services/entities/user_info.dart';
import 'package:marika_client/services/local_storage.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _kDurationAtLeaseSplashScreenShown = Duration(seconds: 1);
  StreamSubscription _setupSub;
  StreamSubscription _exceptionsSub;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() async{
    await LocalStorage().loadAllInfo();
    var userInfo = LocalStorage().getInfo<UserInfo>();
    
    // already login
    if (userInfo?.id != null) {
      var appBloc = BlocProvider.of<ApplicationBloc>(context);

      _setupSub = Observable.zip([
        appBloc.setupCommand,
        Observable.periodic(_kDurationAtLeaseSplashScreenShown).take(1),  // make sure Splash is displayed
      ], null).listen((data){
        _moveTo(MainPage());
      });

      _exceptionsSub = appBloc.setupCommand.thrownExceptions.listen((e){
        print(e);
        _moveTo(LoginPage());
      });

      appBloc.setupCommand.execute();
    }
    // not login yet
    else {
      Future.delayed(_kDurationAtLeaseSplashScreenShown, (){
        _moveTo(LoginPage());
      });
    }
  }

  @override
  void dispose() {
    if (_setupSub != null) {
      _setupSub.cancel();
    }

    if (_exceptionsSub != null) {
      _exceptionsSub.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash.png',
            fit: BoxFit.cover, height: double.infinity, width: double.infinity),
      ),
    );
  }

  void _moveTo(Widget page) {
    Navigator.of(context).pushReplacement(
      CustomMaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }
}


