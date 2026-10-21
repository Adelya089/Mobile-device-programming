
abstract class HomeEvent {}

class HomeLoadRequested extends HomeEvent {}

class HomeSearchChanged extends HomeEvent {
  final String query;

  HomeSearchChanged(this.query);
}

class HomeRefreshRequested extends HomeEvent {}
