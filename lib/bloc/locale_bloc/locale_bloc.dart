
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_events.dart';
import 'locale_state.dart';

export 'locale_events.dart';
export 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc()
      : super(
    LocaleState(
      currentLocale:
      WidgetsBinding.instance.platformDispatcher.locale
          .languageCode ==
          'en'
          ? const Locale('en')
          : const Locale('ru'),
    ),
  ) {
    on<ChangeLocaleEvent>((event, emit) {
      final locale = state.currentLocale.languageCode == 'ru'
          ? const Locale('en')
          : const Locale('ru');

      emit(LocaleState(currentLocale: locale));
    });
  }
}
