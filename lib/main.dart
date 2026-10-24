
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_app/presentation/home_page/home_page.dart';

import 'bloc/like_bloc/like_event.dart';
import 'bloc/like_bloc/like_bloc.dart';
import 'bloc/locale_bloc/locale_bloc.dart';
import 'bloc/home_bloc.dart';
import 'components/locale/l10n/app_locale.dart';
import 'data/likes_database.dart';
import 'data/repositories/artist_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(ArtistRepository()),
        ),
        BlocProvider(
          create: (_) =>
          LikeBloc(LikesDatabase())..add(const LoadLikesEvent()),
        ),
        BlocProvider(
          create: (_) => LocaleBloc(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
            ),
            locale: state.currentLocale,
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocale.supportedLocales,
            home: const MyHomePage(
              title: 'Валиуллова Аделя ПИбд-31',
            ),
          );
        },
      ),
    );
  }
}
