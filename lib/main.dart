import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:marika_client/blocs/application_bloc.dart';
import 'package:marika_client/blocs/bloc_provider.dart';
import 'package:marika_client/localizations/cupertino_localizations.dart';
import 'package:marika_client/localizations/message_localizations.dart';
import 'package:marika_client/pages/splash_page.dart';
import 'package:marika_client/services/local_storage.dart';
import 'package:util_plugin/util_plugin.dart';

Future main() async {
  // Set portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var iosLocale;
  if (Platform.isIOS) {
    Map<dynamic, dynamic> results = await UtilPlugin.locale;
    String lanCode = results["lanCode"] as String;
    String countryCode = results["countryCode"] as String;
    iosLocale = Locale(lanCode, countryCode);
  }
  return runApp(MarikaClient(iosLocale));
}

class MarikaClient extends StatefulWidget {
  final Locale locale;
  MarikaClient(this.locale);

  @override
  _MarikaClientState createState() => _MarikaClientState();
}

class _MarikaClientState extends State<MarikaClient> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: MaterialApp(
          localeResolutionCallback: _localeResolutionCallback,// fix bug locale change by IOS Setting
          localizationsDelegates: _localizeDelegates(),
          supportedLocales: _supportedLocales(),
          theme: _theme(),
          title: "MarikaCafe",
          home: SplashPage(),
        )
    );
  }


  Locale _localeResolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
    Locale candidateLocale = Platform.isIOS ? widget.locale : locale;
    Locale selectedLocale = supportedLocales.first;

    for (Locale lc in supportedLocales) {
      if (lc.languageCode == candidateLocale.languageCode) {
        selectedLocale = candidateLocale;
        break;
      }
    }

    // keep Locale
    LocalStorage().setInfo<Locale>(selectedLocale);
    return selectedLocale;
  }

  List<LocalizationsDelegate<dynamic>> _localizeDelegates() {
    return const <LocalizationsDelegate<dynamic>>[
      // app Localizations
      MessageLocalizations.delegate,
      CupertinoLocalizationsDelegate(),
      // material Localizations
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }

  List<Locale> _supportedLocales() {
    return [
      const Locale('vi', ''), // Vietnamese
      const Locale('en', ''), // English
    ];
  }

  ThemeData _theme() {
    return ThemeData(
      primarySwatch: Colors.green,
    );
  }

  // App life cycle
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // TODO
    } else if (state == AppLifecycleState.paused) {
      // TODO
    }
  }
}
