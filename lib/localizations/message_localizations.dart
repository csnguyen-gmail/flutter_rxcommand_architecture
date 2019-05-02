import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// flutter pub get
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/localizations/l10n lib/localizations/*_localizations.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/localizations/l10n --no-use-deferred-loading lib/localizations/*_localizations.dart lib/localizations/l10n/intl_*.arb

import 'l10n/messages_all.dart';

class MessageLocalizations {
  static Future<MessageLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new MessageLocalizations();
    });
  }

  static MessageLocalizations of(BuildContext context) {
    return Localizations.of<MessageLocalizations>(context, MessageLocalizations);
  }

  static const LocalizationsDelegate<MessageLocalizations> delegate = const _MessageLocalizationsDelegate();

  // definition
  String get close => Intl.message("Đóng", name: 'close',);

}

class _MessageLocalizationsDelegate extends LocalizationsDelegate<MessageLocalizations> {
  const _MessageLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MessageLocalizations> load(Locale locale) => MessageLocalizations.load(locale);

  @override
  bool shouldReload(_MessageLocalizationsDelegate old) => false;
}
