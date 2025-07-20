import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Histoy.dart';
import 'Histoy_state.dart';

class HistoyCubit extends Cubit<HistoyState> {
  HistoyCubit() : super(HistoyInitial());

  Future<void> fetchHistory() async {
    emit(HistoyLoading());
    try {
      final data = await getHistoryData();
      emit(HistoyLoaded(data));
    } catch (e) {
      emit(HistoyError(e.toString()));
    }
  }
}
