import 'package:flutter/material.dart';

import 'artists_albums.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final Color _color = Colors.pink;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const MyWidget(),
    );
  }
}
class AlbumData {
  final String artist;
  final String album;
  final String? imageUrl;

  AlbumData(
      this.artist, {
        required this.album,
        this.imageUrl,
      });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      AlbumData(
        'Земфира',
        album: 'Прости меня моя любовь',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/ru/9/9e/%D0%97%D0%B5%D0%BC%D1%84%D0%B8%D1%80%D0%B0_%D0%9F%D0%9C%D0%9C%D0%9B.jpg?utm_source=ru.wikipedia.org&utm_campaign=index&utm_content=thumbnail_unscaled&_=20230812091834',
      ),
      AlbumData(
        'Григорий Лепс',
        album: 'Зеркала',
        imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/85/Grigory_Leps_LIVE_2025.jpg/960px-Grigory_Leps_LIVE_2025.jpg?utm_source=ru.wikipedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
      ),
      AlbumData(
        'Кино',
        album: 'Группа крови',
        imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/93/Split_Cathedral_Bell_Tower_From_The_Vestibule_-_Split.jpg/1920px-Split_Cathedral_Bell_Tower_From_The_Vestibule_-_Split.jpg?utm_source=ru.wikipedia.org&utm_campaign=parser&utm_content=thumbnail',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String artist;
  final String album;
  final String? imageUrl;

  const _Card(
      this.artist, {
        required this.album,
        this.imageUrl,
      });

  factory _Card.fromData(AlbumData data) => _Card(
    data.artist,
    album: data.album,
    imageUrl: data.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 140,
              width: 100,
              child: Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    album,
                    style: Theme.of(context).textTheme.bodyLarge,
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