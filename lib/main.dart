// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_with_provider/common/theme.dart';
import 'package:todolist_with_provider/container/todo_screen.dart';
import 'package:todolist_with_provider/viewmodal/todo_viewmodal.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoViewModal()),
        ],
        child: MaterialApp(
          supportedLocales: [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: appTheme,
          initialRoute: '/',
          routes: {'/': (context) => TodoScreen()},
        ));
  }
}
