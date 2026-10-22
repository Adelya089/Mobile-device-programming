
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/api_interface.dart';
import 'home_event.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiInterface repository;

  Timer? _debounce;
  String _search = '';

  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeLoadRequested>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        isRefreshing: false,
      ));

      await _loadData(emit);
    });

    on<HomeSearchChanged>((event, emit) {
      _search = event.query;

      _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        add(HomeLoadRequested());
      });
    });

    on<HomeRefreshRequested>((event, emit) async {
      emit(state.copyWith(
        isRefreshing: true,
      ));

      await _loadData(emit);
    });
  }

  Future<void> _loadData(Emitter<HomeState> emit) async {
    try {
      final data = await repository.loadData(q: _search);

      if (data == null) {
        throw Exception('Ошибка загрузки данных');
      }

      emit(state.copyWith(
        data: data,
        isLoading: false,
        isRefreshing: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isRefreshing: false,
        error: 'Не удалось загрузить данные',
      ));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
