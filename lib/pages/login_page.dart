import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marika_client/blocs/application_bloc.dart';
import 'package:marika_client/blocs/bloc_provider.dart';
import 'package:marika_client/helpers/custom_route.dart';
import 'package:marika_client/helpers/dialog.dart';
import 'package:marika_client/pages/main_page.dart';
import 'package:marika_client/services/entities/user_info.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApplicationBloc _appBloc;
  StreamSubscription _setupSub;
  StreamSubscription _exceptionsSub;

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _setupSub = _appBloc.setupCommand.listen((_){
      // move to next page
      Navigator.of(context).pushReplacement(
        CustomMaterialPageRoute(
          builder: (BuildContext context) => MainPage(),
        ),
      );
    });
    _exceptionsSub = _appBloc.setupCommand.thrownExceptions.listen((e){
      showSimpleDialog(context, e.message);
    });
  }

  @override
  void dispose() {
    _setupSub.cancel();
    _exceptionsSub.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text("Login"),
              onPressed: _signIn
            ),
          ),
          StreamBuilder<bool>(
            stream: _appBloc.setupCommand.isExecuting,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return snapshot.hasData && snapshot.data == true
                  ? Container(color: Colors.black45, child: Center(child: CircularProgressIndicator()),)
                  : Container();
            }
          ),
        ],
      ),
    );
  }
  void _signIn() {
    _appBloc.setupCommand.execute(LoginInfo(
        name: "demo", pass: "123"
    ));
  }
}
