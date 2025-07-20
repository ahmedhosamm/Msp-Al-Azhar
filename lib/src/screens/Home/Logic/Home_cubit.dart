import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc States
abstract class HomeState {}
class HomeInitial extends HomeState {}
class HomeLoaded extends HomeState {}

// Bloc Cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  
  void load() {
    emit(HomeLoaded());
  }
}
