// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'فصل صحت';

  @override
  String get appNameUrdu => 'فصل صحت';

  @override
  String get takePhoto => 'تصویر لیں';

  @override
  String get takeAnotherPhoto => 'ایک اور تصویر';

  @override
  String get saved => 'محفوظ ہو گیا ✓';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get home => 'مرکزی صفحہ';

  @override
  String get history => 'ریکارڈ';

  @override
  String get settings => 'ترتیبات';

  @override
  String get checking => 'چیک کیا جا رہا ہے...';

  @override
  String probably(String disease) {
    return 'امکان ہے: $disease';
  }

  @override
  String get retakeHint => 'روشنی میں، پتہ قریب کر کے دوبارہ تصویر لیں';

  @override
  String get retakePhoto => 'دوبارہ تصویر لیں';

  @override
  String get uncertainResultTitle => 'پہچان ممکن نہیں ہو سکی';

  @override
  String get uncertainResultDesc => 'براہ کرم روشنی میں پتے کی واضح تصویر لیں۔';

  @override
  String get consultOfficer =>
      'شدید بیماری کی صورت میں قریبی محکمہ زراعت سے رجوع فرمائیں۔';

  @override
  String get emptyHistoryTitle => 'کوئی ریکارڈ موجود نہیں';

  @override
  String get emptyHistoryDesc => 'بیماری کی تشخیص کے لیے پتے کی تصویر لیں۔';

  @override
  String get language => 'زبان';

  @override
  String get voiceOutput => 'آواز سے رہنمائی';

  @override
  String get worksOffline => 'مکمل طور پر آف لائن کام کرتا ہے';

  @override
  String get appVersion => 'ورژن 1.0.0';

  @override
  String get permissionDeniedTitle => 'کیمرہ کی اجازت درکار ہے';

  @override
  String get permissionDeniedDesc =>
      'پتے کی تصویر لینے کے لیے کیمرہ کی اجازت دیں۔';

  @override
  String get openSettings => 'سیٹنگز کھولیں';

  @override
  String get errorTitle => 'کوئی خرابی پیش آ گئی';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get deleteConfirm => 'کیا آپ اس ریکارڈ کو حذف کرنا چاہتے ہیں؟';

  @override
  String get cancel => 'منسوخ';

  @override
  String get delete => 'حذف کریں';

  @override
  String get healthy => 'صحت مند';

  @override
  String get mild => 'ہلکی بیماری';

  @override
  String get severe => 'شدید بیماری';

  @override
  String get tipSingleLeaf => 'صرف ایک پتہ فوکس میں ہو';

  @override
  String get tipPlainBg => 'پیچھے صاف پس منظر ہو';

  @override
  String get tipDaylight => 'دن کی اچھی روشنی، سائے سے بچیں';

  @override
  String get gotIt => 'سمجھ آ گیا';
}
