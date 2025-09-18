import 'package:evently/core/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


List<LanguageModel> languageModel=[
  LanguageModel(langCode: 'en', langName: 'english'),
  LanguageModel(langCode: 'ar', langName: 'arabic'),
];

final themeProvider= StateProvider<ThemeMode>(
        (ref)=>ThemeMode.light
);
final languageProvider= StateProvider<String>(
        (ref)=>'en'
);
