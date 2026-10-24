import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fasal_sehat/l10n/app_localizations.dart';
import 'package:fasal_sehat/core/theme.dart';
import 'package:fasal_sehat/features/navigation/main_nav_screen.dart';

/// Root Application Widget for Fasal Sehat.
/// Configures MaterialApp with Light Theme, RTL-supported Localization (Urdu/English),
/// and responsive locale switching.
class FasalSehatApp extends StatefulWidget {
  const FasalSehatApp({super.key});

  /// Allows dynamic runtime switching between Urdu and English
  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_FasalSehatAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<FasalSehatApp> createState() => _FasalSehatAppState();
}

class _FasalSehatAppState extends State<FasalSehatApp> {
  // Default to Urdu as specified by the Master Prompt
  Locale _locale = const Locale('ur');

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      setState(() {
        _locale = newLocale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fasal Sehat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainNavScreen(),
    );
  }
}
