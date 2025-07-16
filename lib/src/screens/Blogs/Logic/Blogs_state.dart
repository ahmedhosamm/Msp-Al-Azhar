abstract class BlogsState {}

class BlogsLoading extends BlogsState {}

class BlogsLoaded extends BlogsState {
  final List blogs;
  BlogsLoaded(this.blogs);
}

class BlogsError extends BlogsState {
  final String message;
  BlogsError(this.message);
}
