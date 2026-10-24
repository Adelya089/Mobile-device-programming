
import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_event.dart';
import '../../data/likes_database.dart';
import 'like_state.dart';
export 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikesDatabase database;

  LikeBloc(this.database)
      : super(const LikeState(likedIds: [])) {
    on<LoadLikesEvent>((event, emit) async {
      final ids = await database.loadLikes();

      emit(LikeState(likedIds: ids));
    });

    on<ChangeLikeEvent>((event, emit) async {
      await database.toggleLike(event.id);

      final ids = await database.loadLikes();

      emit(LikeState(likedIds: ids));
    });
  }
}
