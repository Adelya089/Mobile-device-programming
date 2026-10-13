import 'package:flutter/material.dart';

import 'artists_albums.dart';
import 'presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
  runLab2();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Валиуллова Аделя ПИбд-31'),
    );
  }
}
