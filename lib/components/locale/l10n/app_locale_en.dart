// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get searchHint => 'Search for an artist';

  @override
  String get notFound => 'No artists found';

  @override
  String get liked => 'liked!';

  @override
  String get unliked => 'like removed';

  @override
  String get album => 'Album';

  @override
  String get language => 'Language';
}
