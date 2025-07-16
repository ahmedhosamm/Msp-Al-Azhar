import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Blogs.dart';
import 'Blogs_state.dart';
import '../UI/blogs.dart';

class BlogsCubit extends Cubit<BlogsState> {
  BlogsCubit() : super(BlogsLoading());

  Future<void> fetchBlogs() async {
    emit(BlogsLoading());
    try {
      final blogs = await BlogsApi.getBlogs();
      emit(BlogsLoaded(blogs));
    } catch (e) {
      emit(BlogsError(e.toString()));
    }
  }
}
