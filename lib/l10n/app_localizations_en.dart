// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fasal Sehat';

  @override
  String get appNameUrdu => 'فصل صحت';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get takeAnotherPhoto => 'Take another photo';

  @override
  String get saved => 'Saved ✓';

  @override
  String get save => 'Save';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get checking => 'Checking...';

  @override
  String probably(String disease) {
    return 'Probably $disease';
  }

  @override
  String get retakeHint => 'Retake the photo closer, in daylight';

  @override
  String get retakePhoto => 'Retake photo';

  @override
  String get uncertainResultTitle => 'Could not identify';

  @override
  String get uncertainResultDesc => 'Retake photo closer and in good lighting.';

  @override
  String get consultOfficer =>
      'For severe cases consult your local agriculture officer.';

  @override
  String get emptyHistoryTitle => 'No scans yet';

  @override
  String get emptyHistoryDesc =>
      'Take a photo of a crop leaf to identify diseases.';

  @override
  String get language => 'Language';

  @override
  String get voiceOutput => 'Voice output';

  @override
  String get worksOffline => 'Works 100% offline';

  @override
  String get appVersion => 'Version 1.0.0';

  @override
  String get permissionDeniedTitle => 'Camera Permission Required';

  @override
  String get permissionDeniedDesc =>
      'Please grant camera access to take leaf photos.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get deleteConfirm => 'Delete this diagnosis?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get healthy => 'Healthy';

  @override
  String get mild => 'Mild';

  @override
  String get severe => 'Severe';

  @override
  String get tipSingleLeaf => 'Single leaf in focus';

  @override
  String get tipPlainBg => 'Plain background';

  @override
  String get tipDaylight => 'Good daylight, avoid shadows';

  @override
  String get gotIt => 'Got it';
}
