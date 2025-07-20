// Bloc States for Home Screen
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
