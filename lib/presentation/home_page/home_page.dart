
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/locale_bloc/locale_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../components/locale/l10n/app_locale.dart';
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
  final TextEditingController searchController =
  TextEditingController();

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

  void _showSnackBar(
      BuildContext context,
      String artist,
      bool isLiked,
      ) {
    final locale = AppLocale.of(context)!;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$artist: ${isLiked ? locale.liked : locale.unliked}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navToDetails(
      BuildContext context,
      CardData data,
      ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DetailsPage(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: locale.language,
            icon: const Icon(Icons.language),
            onPressed: () {
              context.read<LocaleBloc>().add(
                const ChangeLocaleEvent(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: locale.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    children: state.data.isEmpty
                        ? [
                      Center(
                        child: Text(locale.notFound),
                      ),
                    ]
                        : state.data
                        .map(
                          (item) => AlbumCard.fromData(
                        item,
                        onLike: (
                            String artist,
                            bool isLiked,
                            ) =>
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
