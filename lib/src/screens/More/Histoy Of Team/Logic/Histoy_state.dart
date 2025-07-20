
import '../Data/dio_Histoy.dart';

abstract class HistoyState {}

class HistoyInitial extends HistoyState {}
class HistoyLoading extends HistoyState {}
class HistoyLoaded extends HistoyState {
  final List<TeamHistoryModel> historyList;
  HistoyLoaded(this.historyList);
}
class HistoyError extends HistoyState {
  final String message;
  HistoyError(this.message);
}
