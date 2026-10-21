
import '../models/card.dart';

class HomeState {
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
}
