abstract class BlogsDetailsState {}

class BlogsDetailsLoading extends BlogsDetailsState {}

class BlogsDetailsLoaded extends BlogsDetailsState {
  final dynamic blog;
  BlogsDetailsLoaded(this.blog);
}

class BlogsDetailsError extends BlogsDetailsState {
  final String message;
  BlogsDetailsError(this.message);
} 