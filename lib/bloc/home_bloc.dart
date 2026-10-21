
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
      emit(HomeState(
        data: state.data,
        isLoading: true,
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
      emit(HomeState(
        data: state.data,
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

      emit(HomeState(data: data));
    } catch (e) {
      emit(HomeState(
        data: state.data,
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
