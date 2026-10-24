import 'package:flutter/material.dart';
import 'package:fasal_sehat/app.dart';
import 'package:fasal_sehat/core/constants.dart';
import 'package:fasal_sehat/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _voiceOutputEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    final isUrdu = currentLocale.languageCode == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Language Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language_rounded, color: AppColors.primaryGreen),
                      const SizedBox(width: 12),
                      Text(
                        l10n.language,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RadioGroup<String>(
                    groupValue: currentLocale.languageCode,
                    onChanged: (val) {
                      if (val != null) {
                        FasalSehatApp.setLocale(context, Locale(val));
                      }
                    },
                    child: Column(
                      children: const [
                        RadioListTile<String>(
                          title: Text('اردو (Urdu)'),
                          subtitle: Text('مکمل اردو انٹرفیس اور آواز'),
                          value: 'ur',
                        ),
                        Divider(),
                        RadioListTile<String>(
                          title: Text('English'),
                          subtitle: Text('English interface and guides'),
                          value: 'en',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Preferences Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      l10n.voiceOutput,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    subtitle: Text(
                      isUrdu
                          ? 'نتائج کی آڈیو رہنمائی خودکار سنیں'
                          : 'Speak remedies automatically',
                    ),
                    secondary: const Icon(Icons.volume_up_rounded, color: AppColors.primaryGreen),
                    activeThumbColor: AppColors.primaryGreen,
                    activeTrackColor: AppColors.paleGreen,
                    value: _voiceOutputEnabled,
                    onChanged: (val) {
                      setState(() {
                        _voiceOutputEnabled = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // App Info & Offline Status Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.paleGreen,
                      child: Icon(Icons.wifi_off_rounded, color: AppColors.primaryGreen),
                    ),
                    title: Text(
                      l10n.worksOffline,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      isUrdu
                          ? 'انٹرنیٹ کے بغیر فیلڈ میں کام کرتا ہے'
                          : 'No internet connection required in the field',
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.paleGreen,
                      child: Icon(Icons.info_outline_rounded, color: AppColors.primaryGreen),
                    ),
                    title: Text(l10n.appVersion),
                    subtitle: const Text('Fasal Sehat Mobile Computing AI Engine'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
