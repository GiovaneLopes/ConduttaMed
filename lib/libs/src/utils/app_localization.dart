import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AppLocalization {
  final FlutterLocalization localization = FlutterLocalization.instance;

  AppLocalization() {
    init();
  }

  Iterable<Locale> get supportedLocales => localization.supportedLocales;
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      localization.localizationsDelegates;

  void init() {
    localization.init(
      mapLocales: [
        const MapLocale(
          'pt',
          {'title': 'pt_BR'},
          countryCode: 'pt_BR',
        ),
      ],
      initLanguageCode: 'pt',
    );
  }
}
