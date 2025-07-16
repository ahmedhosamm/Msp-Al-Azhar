import 'package:flutter_bloc/flutter_bloc.dart';
import 'BlogsDetails_state.dart';
import '../Data/dio_Blogs.dart';

class BlogsDetailsCubit extends Cubit<BlogsDetailsState> {
  BlogsDetailsCubit() : super(BlogsDetailsLoading());

  Future<void> fetchBlog(String blogId) async {
    emit(BlogsDetailsLoading());
    try {
      final blogs = await BlogsApi.getBlogs();
      dynamic blog;
      try {
        blog = blogs.firstWhere((b) => b.id == blogId);
      } catch (_) {
        blog = null;
      }
      if (blog != null) {
        emit(BlogsDetailsLoaded(blog));
      } else {
        emit(BlogsDetailsError('Blog not found'));
      }
    } catch (e) {
      emit(BlogsDetailsError('Error: $e'));
    }
  }
} 