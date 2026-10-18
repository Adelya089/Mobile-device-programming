import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/artist_repository.dart';
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
  final ArtistRepository repo = ArtistRepository();

  final TextEditingController searchController = TextEditingController();

  late Future<List<CardData>?> data;

  @override
  void initState() {
    super.initState();
    data = repo.loadData();
  }

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
      CupertinoPageRoute(
        builder: (context) => DetailsPage(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Поиск исполнителя',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (search) {
                setState(() {
                  data = repo.loadData(q: search);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CardData>?>(
              future: data,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!
                        .map(
                          (item) => AlbumCard.fromData(
                        item,
                        onLike: (String artist, bool isLiked) =>
                            _showSnackBar(
                              context,
                              artist,
                              isLiked,
                            ),
                        onTap: () => _navToDetails(
                          context,
                          item,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}