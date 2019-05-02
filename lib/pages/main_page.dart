import 'package:flutter/material.dart';
import 'package:marika_client/blocs/application_bloc.dart';
import 'package:marika_client/blocs/bloc_provider.dart';
import 'package:marika_client/services/entities/account_info.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var appBloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      body: Center(
        child: buildProfile(appBloc),
      ),
    );
  }

  Widget buildProfile(ApplicationBloc appBloc) {
    return Stack(
      children: <Widget>[
        StreamBuilder<AccountInfo>(
          stream: appBloc.accountInfoCommand,
          builder: (BuildContext context, AsyncSnapshot<AccountInfo> snapshot) {
             AccountInfo info = snapshot.data;
             return Text(info.profile.name);
          }
        ),
      ],
    );
  }
}
