import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class S {
  static late S _instance;
  static S get instance {
    _instance = _instance;
    return _instance;
  }

  static Future<S> init(Locale locale) async {
    final instance = S();
    await instance.load(locale);
    return instance;
  }

  Future<void> load(Locale locale) async {
    final String localeName = locale.languageCode;
    final String canonicalLocale = Intl.canonicalizedLocale(localeName);

    final bool isEn = canonicalLocale == 'en';
    final bool isDe = canonicalLocale == 'de';

    if (isEn) {
      _currentLocalization = 'en';
    } else if (isDe) {
      _currentLocalization = 'de';
    } else {
      _currentLocalization = 'en';
    }

    final String path = 'i18n/$_currentLocalization.json';

    if (await rootBundle.load(path).catchError((error) {
          print('Error loading localization file: $error');
          return null;
        }) !=
        null) {
      final data = await rootBundle.loadString(path);
      _localizedValues = json.decode(data) as Map<String, dynamic>;
    } else {
      print('Localization file not found: $path');
    }
  }

  static Locale locale = const Locale('en', 'US');

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('de', 'DE'),
  ];

  static Map<String, dynamic> _localizedValues = {};

  String get language => _localizedValues['language'] ?? '';
  String get english => _localizedValues['english'] ?? '';
  String get german => _localizedValues['german'] ?? '';
  String get hello => _localizedValues['hello'] ?? '';
  String get welcome => _localizedValues['welcome'] ?? '';

  static String _currentLocalization = '';
  static String get currentLocalization => _currentLocalization;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = AppLocalizationsDelegate();
}

class AppLocalizationsDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) => S.init(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
