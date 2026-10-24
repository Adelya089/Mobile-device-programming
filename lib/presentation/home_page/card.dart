
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/like_bloc/like_event.dart';
import '../../bloc/like_bloc/like_bloc.dart';
import '../../models/card.dart';

typedef OnLikeCallback = void Function(String artist, bool isLiked)?;

class AlbumCard extends StatelessWidget {
  final String artist;
  final String album;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const AlbumCard(
      this.artist, {
        super.key,
        required this.album,
        this.imageUrl,
        this.onLike,
        this.onTap,
      });

  factory AlbumCard.fromData(
      CardData data, {
        OnLikeCallback onLike,
        VoidCallback? onTap,
      }) =>
      AlbumCard(
        data.artist,
        album: data.album,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    final id = '$artist|$album';

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  errorBuilder: (_, __, ___) {
                    return const Placeholder();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge,
                    ),
                    Text(
                      album,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    BlocBuilder<LikeBloc, LikeState>(
                      builder: (context, state) {
                        final isLiked =
                        state.likedIds.contains(id);

                        return GestureDetector(
                          onTap: () {
                            context.read<LikeBloc>().add(
                              ChangeLikeEvent(id),
                            );

                            onLike?.call(artist, !isLiked);
                          },
                          child: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isLiked
                                ? Colors.red
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
