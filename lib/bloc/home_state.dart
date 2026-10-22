
import 'package:equatable/equatable.dart';

import '../models/card.dart';

class HomeState extends Equatable {
  final List<CardData> data;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.data = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<CardData>? data,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return HomeState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    data,
    isLoading,
    isRefreshing,
    error,
  ];
}
