import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/card.dart';
import '../details_page/details_page.dart';
import 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CardData> data = [
    CardData(
      'Земфира',
      album: 'Прости меня моя любовь',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/ru/9/9e/%D0%97%D0%B5%D0%BC%D1%84%D0%B8%D1%80%D0%B0_%D0%9F%D0%9C%D0%9C%D0%9B.jpg',
    ),
    CardData(
      'Григорий Лепс',
      album: 'Зеркала',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/85/Grigory_Leps_LIVE_2025.jpg/960px-Grigory_Leps_LIVE_2025.jpg',
    ),
    CardData(
      'Кино',
      album: 'Группа крови',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/93/Split_Cathedral_Bell_Tower_From_The_Vestibule_-_Split.jpg/1920px-Split_Cathedral_Bell_Tower_From_The_Vestibule_-_Split.jpg?utm_source=ru.wikipedia.org&utm_campaign=parser&utm_content=thumbnail',
    ),
  ];

  void _showSnackBar(BuildContext context, String artist, bool isLiked) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isLiked ? '$artist: лайк поставлен!' : '$artist: лайк убран',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.map((item) {
              return AlbumCard.fromData(
                item,
                onLike: (String artist, bool isLiked) =>
                    _showSnackBar(context, artist, isLiked),
                onTap: () => _navToDetails(context, item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
