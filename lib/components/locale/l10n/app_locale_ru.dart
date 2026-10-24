// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get searchHint => 'Поиск исполнителя';

  @override
  String get notFound => 'Исполнители не найдены';

  @override
  String get liked => 'лайк поставлен!';

  @override
  String get unliked => 'лайк убран';

  @override
  String get album => 'Альбом';

  @override
  String get language => 'Язык';
}
