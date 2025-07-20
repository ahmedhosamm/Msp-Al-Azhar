import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Feedback.dart';
import 'Feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  Future<void> fetchReviews() async {
    emit(FeedbackLoading());
    try {
      final reviews = await FeedbackApi.fetchReviews();
      emit(FeedbackLoaded(reviews));
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }
}
