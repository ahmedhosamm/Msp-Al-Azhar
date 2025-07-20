import '../Data/dio_Feedback.dart';

abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {
  final List<ReviewModel> reviews;
  FeedbackLoaded(this.reviews);
}

class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError(this.message);
}


