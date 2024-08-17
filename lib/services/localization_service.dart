import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/lang/tr_tr.dart';

class LocalizationService extends Translations {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() {
    return _instance;
  }

  LocalizationService._internal();
  Locale locale = const Locale('tr', 'TR');
  String currentLang = "Türkçe";
  final fallbackLocale = const Locale('tr', 'TR');

  final langs = ['Türkçe'];

  final flags = ['🇹🇷'];

  final locales = const [
    Locale('tr', 'TR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'tr_TR': trTR,
      };

  // Gets locale from language, and updates the locale
  Future<Locale> changeLocale(String lang) async {
    final getLocale = _getLocaleFromLanguage(lang);
    await Get.updateLocale(locale);
    locale = getLocale;
    currentLang = lang;
    return locale;
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
