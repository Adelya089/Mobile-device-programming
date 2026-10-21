
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadRequested());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final bloc = context.read<HomeBloc>();

    final finished = bloc.stream.firstWhere(
          (state) => !state.isLoading && !state.isRefreshing,
    );

    bloc.add(HomeRefreshRequested());

    await finished;
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
                context.read<HomeBloc>().add(
                  HomeSearchChanged(search),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null) {
                  return Center(
                    child: Text(state.error!),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: state.data.isEmpty
                        ? [
                      const Center(
                        child: Text('Исполнители не найдены'),
                      ),
                    ]
                        : state.data
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
