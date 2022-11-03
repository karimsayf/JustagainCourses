import 'package:flutter/material.dart';
import 'package:justagain_tesk_task/utils/constants.dart';

class LocalizationsService with ChangeNotifier {
  Locale appLocale = deviceLocale;


  changeAppLocale(Locale locale) {
    appLocale = locale;
    notifyListeners();
  }
}
